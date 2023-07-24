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

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list
                                        ;; "r-minimal"
                                        ;; "r-pracma"
                                        ;; "r-colorout"
                                        ;; "r-testthat"
                                        "ripgrep"
                                        "fd"
                                        ;; "bfs"
                                        )))
  ;; (local-file "nushell.scm")
  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
    (list (service home-bash-service-type
                   (home-bash-configuration
                     (environment-variables 
                       '(("GNUPKGS" . "~/.config/guix/current/share/guile/site/3.0/gnu/"))
                       )
                     (aliases '(("ls" . "ls --color=auto")))
                     (bashrc (list (local-file
                                     ".bashrc"
                                     "bashrc")))
                     (bash-profile (list (local-file
                                           ".bash_profile"
                                           "bash_profile")))
                     (bash-logout (list (local-file
                                          ".bash_logout"
                                          "bash_logout")))))
          ;; (service home-environment-variables)
          )))
