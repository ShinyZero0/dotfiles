;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules
  (gnu home)
  (gnu packages)
  (gnu packages package-management)
  (gnu packages base)
  (gnu services)
  (gnu home services shells)
  (gnu home services mcron)
  (gnu home services ssh)
  (gnu home services)
  (guix gexp)
  (guix utils)
  (zero packages guile-lsp-server)
  (zero packages bspwm-git)
  (zero packages zerolib)
  (ice-9 textual-ports)
  )
(define-syntax-rule (colon-join args ...)
  (string-join (list args ...) ":"))
(define-syntax-rule (newline-join args ...)
  (string-join (list args ...) "\n"))
(define home
  (home-environment
    (packages
      (append
        (specifications->packages
          (list
            "ripgrep"
            "glibc-locales"
            "keynav"
            "detox"
            "qutebrowser"
            "fzf"
            "zoxide"
            "neovim"
            ;; "bfs"
            ))
        (list
          guile-lsp-server
          bspwm-git
          )
        ))
    (services
      (list
        (service
          home-zsh-service-type
          (home-zsh-configuration
            (zshrc
              (list
                (local-file "./zsh/zshrc")
                (local-file "./zsh/aliases.zsh")
                (local-file "./zsh/commands.zsh")
                (local-file "./zsh/p10k.zsh")
                ))
            ))
        (service home-bash-service-type
                 (home-bash-configuration
                   (environment-variables 
                     `(
                       ("GNUPKGS"
                        . ,(file-append guix "/share/guile/site/3.0"))
                       ("GUIX_LOCPATH"
                        . ,(file-append glibc-locales "/lib/locale"))
                       ("PATH"
                        . ,(colon-join
                             "$HOME/.local/bin"
                             "$HOME/.dotnet/tools"
                             "$HOME/.cargo/bin"
                             "$HOME/.dotnet"
                             "$PATH"
                             ))
                       ("GUILE_LOAD_PATH"
                        . ,(colon-join
                             "$HOME/.local/share/guile/site/3.0"
                             "$GUILE_LOAD_PATH"
                             ))
                       ("FZF_DEFAULT_OPTS"
                        . ,(let
                             ((args '("--reverse"
                                      "--scheme=path"
                                      "--cycle"
                                      "-i"))
                              (colors '("dark"
                                        "fg:#cbe3e7"
                                        "bg:#1b182c"
                                        "hl:#ff99e3"
                                        "fg+:#aaffe4"
                                        "bg+:#565575"
                                        "hl+:#63f2f1"
                                        "gutter:#1b182c"
                                        "pointer:#aaffe4"
                                        "prompt:#ff99e3"
                                        "info:#ffe9aa"
                                        "header:#cbe3e7"
                                        "spinner:#63f2f1")))
                             (string-append
                               (string-join args " ")
                               " --color="
                               (string-join colors ","))))
                       ("PAGER" . "less -RF --incsearch --status-line --mouse --wheel-lines 3")
                       ("MANPAGER" . "$PAGER")
                       ("BAT_PAGER" . "$PAGER")
                       ("DELTA_PAGER" . "$PAGER")
                       ("DOTNET_CLI_TELEMETRY_OPTOUT" . "1")
                       ("POWERSHELL_TELEMETRY_OPTOUT" . "1")
                       ("LINKDING_TOKEN" . "28185e63c63f3324f5613ce152094b34731379a2")
                       ("EDITOR" . "nvim")
                       ("VISUAL" . "$EDITOR")
                       ("XDG_DATA_DIRS"
                        . ,(colon-join "$HOME/.nix-profile/share" "/usr/share" "$XDG_DATA_DIRS")
                       )
                     ))
                   (bashrc (list
                             (local-file
                               "./bash/bashrc")))
                   (bash-profile (list
                                   (local-file
                                     "./bash/bash_profile")))
                   (bash-logout (list
                                  (local-file
                                    "./bash/bash_logout")))))
        (simple-service
          'zsh-abbr
          home-xdg-configuration-files-service-type
          `(
            ("zsh-abbr/user-abbreviations"
             ,(computed-file
                "user-abbreviations"
                (with-extensions
                  (list guile-zerolib)
                  (with-imported-modules
                    '((guix build utils)
                      (ice-9 textual-ports)
                      (zerolib)
                      )
                    #~(begin
                        (use-modules (guix build utils)
                                     (ice-9 textual-ports)
                                     (zerolib))
                        (copy-recursively
                          #$(local-file "zsh" #:recursive? #t) ".")
                        (write-all-lines
                          (list
                            (read-all-text "./abbrs.zsh")
                            (read-all-text "./abbrs-xbps.zsh"))
                          (open-output-file #$output))
                        ))
                  )
                ))
            ))

        (service home-ssh-agent-service-type
                 (home-ssh-agent-configuration))))))

        ;; (service home-mcron-configuration
        ;;          (jobs 
        ;;            (list
        ;;              )))
        ))))
home
