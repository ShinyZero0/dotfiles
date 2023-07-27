#!/usr/bin/env -S guile -e main
!#

(use-modules (web client)
             (zerolib)
             (scheme base)
             (srfi srfi-11)
             (json)
             )
(define (main args)
  (let ((arg1 (cadr args)))
  (cond
    ((equal? arg1 "get") => (lambda (a) (main-get)))
    ((equal? arg1 "post") => (lambda (a) (main-post)))
    ((equal? arg1 "delete") => (lambda (_) (main-delete)))
    )
  ))
(define (main-post)
  (define tags
    (get-tags))
  (define selected-tags
    (string-split
      (call-command-with-input "rofi"
                               '("-dmenu" "-i" "-multi-select")
                               (string-join tags "\n"))
    #\newline))
  (post-linkding "bookmarks"
    (scm->json-string
      `(("url" . ,(getenv "QUTE_URL"))
        ("tag_names" . ,(list->vector selected-tags)))))
    )
(define (main-get)
  (define selected-bmark (select-bmark))
  (define
    qute-socket
    (open-file (getenv "QUTE_FIFO") "w"))
  (if (not (string-null? selected-bmark))
    (display
      (string-append
        "open -tr "
        (car
          (string-split
            selected-bmark
            #\tab)))
      qute-socket))
  )
(define (main-delete)
  (define selected-bmark (select-bmark))
  (if (not (string-null? selected-bmark))
  (del-bookmark 
    (car
      (reverse
        (string-split selected-bmark #\tab)))))
  )
(define (select-bmark)
  (define bmarks
    (string-join
      (map
        (lambda (bmark)
          (string-join
            (list
             (assoc-ref bmark "url")
             (assoc-ref bmark "title")
             (string-join
               (vector->list
                 (assoc-ref bmark "tag_names"))
               ", ")
             (number->string (assoc-ref bmark "id"))
             ) "\t"
            ))
        (get-bmarks))
      "\n")
    )
    (call-command-with-input
      "rofi"
      '("-dmenu" "-i" "-display-columns=url,title,tags")
      bmarks)
  )
(define (get-bmarks)
  (vector->list (get-linkding "bookmarks")))
(define (get-tags)
  (map
    (lambda (tag)
      (assoc-ref tag "name"))
    (vector->list
      (get-linkding "tags"))))
(define (get-linkding endpoint)
    (assoc-ref
      (json-string->scm
        (utf8->string
          (req-linkding 'GET endpoint #f)))
        "results"))
(define (post-linkding endpoint body)
  (req-linkding 'POST endpoint (string->utf8 body)))
(define (del-bookmark bm)
  (req-linkding 'DELETE (string-append "bookmarks/" bm) #f)
  )
(define (req-linkding method endpoint body)
  (let-values
    (((response resp-body)
      (http-request
        (string-append
          "http://localhost:9090/api/"
          endpoint
          "/")
        #:body body
        #:method method
        #:headers
        `(
          (Authorization
            . ,(string-append
                 "Token "
                 (getenv "LINKDING_TOKEN")))
          (Content-Type . "application/json")
          ))))
    resp-body))
