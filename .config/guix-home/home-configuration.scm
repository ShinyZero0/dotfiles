;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             ;; ((gnu) #:prefix gnu:)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells))

(define store (open-connection))
(define home
  (home-environment
    ;; Below is the list of packages that will show up in your
    ;; Home profile, under ~/.guix-home/profile.
    (packages
      (append
        (specifications->packages
        (list
          "ripgrep"
          "glibc-locales"
          "keynav"
          "detox"
          ;; "bfs"
          ))
          (list
            guile-lsp-server
            ;; #$(program-file "scheme-ls"
            )
        ))
    (services
      (list
        (service home-bash-service-type
                 (home-bash-configuration
                   (environment-variables 
                     `(
                       ("GNUPKGS" .
                        ,((package-file guix "share/guile/site/3.0")
                          store))
                       ("GUIX_LOCPATH" .
                        ,((package-file glibc-locales "lib/locale")
                          store))
                       ("PATH" .
                        ,(string-join
                           (list "$HOME/.local/bin"
                                 "$HOME/.dotnet/tools"
                                 "$HOME/.cargo/bin"
                                 "$HOME/.dotnet"
                                 "$PATH"
                                 )
                           ":"))
                       )
                     )
                   (bashrc (list
                             (local-file
                               "./bash/bashrc")))
                   (bash-profile (list
                                   (local-file
                                     "./bash/bash_profile")))
                   (bash-logout (list
                                  (local-file
                                    "./bash/bash_logout")))))
        (service home-files
                 )
        ;; (service home-mcron-configuration
        ;;          (jobs 
        ;;            (list
        ;;              )))
        ))))
(close-connection store)
home
