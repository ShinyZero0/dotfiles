#! /usr/bin/env guile
!#
(use-modules (json parser)
             (zerolib)
             (ice-9 threads))

(define (get-workspace-strings)
  (let*
    (
     (workspaces
       (filter
         (lambda (ws)
           (not (string-null? ws)))
         (list-tail
           (split-lines
             (call-command "bspc" "query" "-D" "--names"))
           10)))
     (get-ws-desc 
       (lambda (ws)
         (call-command
           "xdotool"
           "getwindowname"
           (number->string
             (assoc-ref 
               (json-string->scm
                 (call-command
                   "bspc" "query" "-T" "-d" ws))
               "focusedNodeId")))))
     (append-ws-desc
       (lambda (ws)
         (let1 (desc (get-ws-desc ws))
           (string-append
             ws " : " 
             (if (string? desc) desc ""))))))
    (par-map
      append-ws-desc
      workspaces)))

(write-lines (get-workspace-strings))
