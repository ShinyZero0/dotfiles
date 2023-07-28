;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(load "./scheme-ls.scm")
(load "./bspwm-git.scm")
(use-modules
  (gnu home)
  (gnu packages)
  (gnu packages package-management)
  (gnu packages base)
  (gnu services)
  (guix gexp)
  (gnu home services shells)
  (gnu home services mcron)
  (gnu home services)
  (guile-lsp-server)
  )
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
            "qutebrowser"
            ;; "bfs"
            ))
        (list
          guile-lsp-server
          bspwm-git
          ;; #$(program-file "scheme-ls"
          )
        ))
    (services
      (list
        (service home-bash-service-type
                 (home-bash-configuration
                   (environment-variables 
                     `(
                       ("GNUPKGS"
                        . ,(file-append guix "/share/guile/site/3.0"))
                       ("GUIX_LOCPATH"
                        . ,(file-append glibc-locales "/lib/locale"))
                       ("PATH"
                        . ,(string-join
                           (list "$HOME/.local/bin"
                                 "$HOME/.dotnet/tools"
                                 "$HOME/.cargo/bin"
                                 "$HOME/.dotnet"
                                 "$PATH"
                                 )
                           ":"))
                       ("GUILE_LOAD_PATH"
                        . ,(string-join
                           (list "$HOME/.local/share/guile/site/3.0"
                                 "$GUILE_LOAD_PATH"
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
home
