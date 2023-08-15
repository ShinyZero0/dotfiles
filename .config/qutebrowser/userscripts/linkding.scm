#!/usr/bin/env -S guile -e main
!#

(use-modules (web client)
             (json)
             (zerolib)
             (zerolib shell)
             (scheme base)
             (srfi srfi-26)
             (ice-9 receive)
             (ice-9 threads))

(define (main args)
  (let1 (arg1 (cadr args))
        (cond
          ((equal? arg1 "get") => (lambda _ (main-get)))
          ((equal? arg1 "post") => (lambda _ (main-post)))
          ((equal? arg1 "delete") => (lambda _ (main-delete))))))

(define (main-post)
  (let*
    ((tags (get-tags))
     (selected-tags
       (split-lines
         (call-command-with-input
           "rofi"
           '("-dmenu" "-i" "-multi-select")
           tags))))
    (post-linkding "bookmarks"
                   (scm->json-string
                     `(("url" . ,(getenv "QUTE_URL"))
                       ("tag_names" . ,(list->vector selected-tags)))))))

(define (main-get)
  (let1 (selected-bmark (car (string-split (select-bmark) #\tab)))
        (unless (string-null? selected-bmark)
          (with-output-to-file
            (getenv "QUTE_FIFO")
            (lambda _
              (display
                (string-append/shared
                  "open -tr "
                  selected-bmark)))))))
(define (main-delete)
  (define selected-bmark (select-bmark))
  (unless (string-null? selected-bmark)
    (del-bookmark 
      (last
        (string-split selected-bmark #\tab)))))

(define (select-bmark)
  (let1
    (bmarks
      (par-map
        (lambda (bmark)
          (string-join
            (list
              (assoc-ref bmark "url")
              (assoc-ref bmark "title")
              (string-join
                (vector->list
                  (assoc-ref bmark "tag_names"))
                ", ")
              (number->string (assoc-ref bmark "id")))
            "\t"))
        (get-bmarks)))
    (call-command-with-input
      "rofi"
      '("-dmenu" "-i" "-display-columns=url,title,tags,id")
      bmarks)))

(define (get-bmarks)
  (get-linkding "bookmarks"))
(define (get-tags)
  (par-map
    (cute assoc-ref <> "name")
    (get-linkding "tags")))
(define (del-bookmark bm)
  (req-linkding 'DELETE (string-append/shared "bookmarks/" bm)))
(define (get-linkding endpoint)
  (vector->list
    (assoc-ref
      (json-string->scm
        (utf8->string
          (req-linkding 'GET endpoint)))
      "results")))
(define (post-linkding endpoint body)
  (req-linkding 'POST endpoint (string->utf8 body)))
(define*
  (req-linkding method endpoint #:optional (body #f))
  (receive
    (_ resp-body)
    (http-request
      (string-append/shared
        "http://localhost:9090/api/" endpoint "/")
      #:body body
      #:method method
      #:headers
      `((Authorization
          . ,(string-append/shared
               "Token "
               (getenv "LINKDING_TOKEN")))
        (Content-Type . "application/json")))
    resp-body))
