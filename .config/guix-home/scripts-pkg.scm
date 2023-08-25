(define-module (scripts-pkg))
(use-modules
  (guix packages)
  (gnu packages shells)
  (gnu packages bash)
  (gnu packages guile)
  (guix gexp)
  (guix build utils)
  (guix build-system copy)
  ((guix licenses) #:prefix license:))
(define-public
  scripts-pkg
  (let ((url ""))
    (package
      (name "scripts-pkg")
      (version "master")
      (source
        (local-file
          "scripts"
          #:recursive? #t))
      (build-system copy-build-system)
      (arguments
        (list
          #:install-plan
          #~'(("share" "bin/")
              ("yank-x11" "bin/yank")
              ("put-x11" "bin/put")
              ("picget" "bin/")
              ("picsave" "bin/")
              ("recent" "bin/")
              ("coolmusic" "bin/")
              ("zsanity" "bin/")
              ("picshare" "bin/")
              ("picyank" "bin/"))))
      (inputs (list
                dash
                bash
                zsh
                guile-3.0))
      ;; (native-inputs (list))
      (synopsis "scripts-pkg")
      (description "scripts-pkg")
      (home-page url)
      (license license:expat))))
