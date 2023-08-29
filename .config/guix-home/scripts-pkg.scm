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
          (with-imported-modules
            '((guix build utils))
            #~'(("scripts.d/" "bin/")
                ("yank-x11" "bin/yank")
                ("put-x11" "bin/put")))))
      (inputs (list
                dash
                bash-minimal
                zsh
                guile-3.0))
      ;; (native-inputs (list))
      (synopsis "scripts-pkg")
      (description "scripts-pkg")
      (home-page url)
      (license license:gpl3))))
scripts-pkg
