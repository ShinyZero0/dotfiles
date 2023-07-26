#! /usr/bin/env guile
!#
(use-modules (json parser)
             ;; (rnrs io ports)
             (ice-9 popen)
             (ice-9 rdelim)
             (ice-9 regex)
             (ice-9 textual-ports)
             )
(define (call-command cmd)
  (let* (
         (pipes
           (pipe))
         (cmd-ls (string-split cmd #\space))
         (pid
             (spawn
               (car cmd-ls)
               cmd-ls
               #:output (cdr pipes)
               ))
         )
    (force-output (cdr pipes))
    (waitpid pid)
    ;; (close-port pipes)
    (close-port (cdr pipes))
    (string-trim-both
      (get-string-all (car pipes))
      (char-set-adjoin char-set:whitespace #\newline))))
(define (get-workspace-strings)
  (let*
    (
     (ws-filter
       (lambda (ws)
         (not (string-every char-set:whitespace ws))))
     (workspaces
       (filter
         ws-filter
         (list-tail
           (string-split
             (call-command "bspc query -D --names")
             #\newline)
           10)))
     (get-ws-desc 
       (lambda (ws)
         (call-command
           (string-append
             "xdotool getwindowname "
             (number->string
               (assoc-ref 
                 (json-string->scm
                   (call-command
                     (string-append "bspc query -T -d " ws)))
                 "focusedNodeId"))))))
     (append-ws-desc
       (lambda (ws)
         (let ((desc (get-ws-desc ws)))
           (string-append
             ws " : " 
             (if (string? desc) desc ""))))))
    (map
      append-ws-desc
      workspaces)))

;; (define rofi-pipe (open-pipe* OPEN_BOTH "rofi" "-dmenu" "-select"))

(display
  (string-join
    (get-workspace-strings) "\n"))
