;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules;{{{
  (gnu home)
  (gnu packages)
  (gnu packages shells)
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
  (zerolib));}}}

(chdir (current-source-directory))
(define (list->search-path lst)
  (string-join lst ":"))
(define-syntax-rule (colon-join args ...)
                    (string-join (list args ...) ":"))
(define fzf-options;{{{
  (let
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
      (string-join colors ","))));}}}
(define home
  (home-environment
    (packages;{{{
      (append
        (specifications->packages
          (list
            "ripgrep"
            "zoxide"
            "glibc-locales"
            "keynav"
            "detox"
            "qutebrowser"
            "fzf"
            "bat"
            "skroll"))
        (list
          guile-lsp-server
          bspwm-git)));}}}
    (services
      (list
        (service home-zsh-service-type;{{{
                 (home-zsh-configuration
                   (environment-variables
                     `(("FPATH"
                        . ,(list->search-path
                             (append
                               (string-product
                                 "$HOME/.guix-home/profile/share/zsh/"
                                 '("5.9/functions/" "site-functions"))
                               '("$HOME/.config/guix/current/share/zsh/site-functions"
                                 "/usr/share/zsh/site-functions"))))
                       ("SHELL" . ,(file-append zsh "/bin/zsh"))))
                   (zshrc
                     (map (lambda (s)
                            (local-file (string-append "zsh/" s)))
                          (list "zshrc" "aliases.zsh"
                                "commands.zsh" "p10k.zsh"
                                "x11.zsh")))));}}}
        (service home-bash-service-type;{{{
                 (home-bash-configuration
                   (environment-variables 
                     `(
                       ("GUIX_HOME_CONFIG_ROOT"
                        . "$HOME/.config/guix-home")
                       ("GNUPKGS"
                        . ,(file-append guix "/share/guile/site/3.0"))
                       ("GUIX_LOCPATH"
                        . ,(file-append glibc-locales "/lib/locale"))
                       ("PATH";{{{
                        . ,(colon-join
                             "$HOME/.local/bin"
                             "$HOME/.dotnet/tools"
                             "$HOME/.cargo/bin"
                             "$HOME/.dotnet"
                             "$PATH"));}}}
                       ("GUILE_LOAD_PATH"
                        . ,(colon-join
                             "$HOME/.local/share/guile/site/3.0"
                             "$GUILE_LOAD_PATH"))
                       ("GUIX_PACKAGE_PATH"
                        . ,(colon-join
                             "$HOME/.config/guix-packages"))
                       ("XDG_DATA_DIRS"
                        . ,(colon-join
                             "$HOME/.nix-profile/share"
                             "/usr/share" "$XDG_DATA_DIRS"))
                       ("FZF_DEFAULT_OPTS"
                        . ,fzf-options)
                       ("PAGER" . "less -RF --incsearch --status-line --mouse --wheel-lines 3")
                       ("MANPAGER" . "$PAGER")
                       ("BAT_PAGER" . "$PAGER")
                       ("DELTA_PAGER" . "$PAGER")
                       ("DOTNET_CLI_TELEMETRY_OPTOUT" . "1")
                       ("POWERSHELL_TELEMETRY_OPTOUT" . "1")
                       ("LINKDING_TOKEN" . "28185e63c63f3324f5613ce152094b34731379a2")
                       ("EDITOR" . "nvim")
                       ("VISUAL" . "$EDITOR")))
                   (bashrc (list
                             (local-file
                               "./bash/bashrc")))
                   (bash-profile (list
                                   (local-file
                                     "./bash/bash_profile")))
                   (bash-logout (list
                                  (local-file
                                    "./bash/bash_logout")))));}}}
        (simple-service 'zsh-abbr ;{{{
                        home-xdg-configuration-files-service-type
                        `(
                          ("zsh-abbr/user-abbreviations"
                           ,(computed-file
                              "user-abbreviations"
                              (with-extensions
                                (list guile-zerolib)
                                (with-imported-modules
                                  '((guix build utils)
                                    (zerolib fs))
                                  #~(begin
                                      (use-modules (guix build utils)
                                                   (zerolib fs))
                                      (copy-recursively
                                        #$(local-file "zsh" #:recursive? #t) ".")
                                      (merge-files
                                        (list
                                          "./abbrs.zsh"
                                          "./abbrs-xbps.zsh")
                                        #$output)))))))) ;}}}
        (service home-ssh-agent-service-type
                 (home-ssh-agent-configuration))))))

home
