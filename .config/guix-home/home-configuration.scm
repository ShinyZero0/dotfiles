;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules;{{{
  (gnu home)
  (gnu packages)
  (gnu packages shells)
  (gnu packages rust-apps)
  (gnu packages shellutils)
  (gnu packages package-management)
  (gnu packages base)
  (gnu packages video)
  (gnu services configuration)
  (gnu services)
  (gnu home services shells)
  (gnu home services mcron)
  (gnu home services ssh)
  (gnu home services)
  (srfi srfi-26)
  (guix gexp)
  (guix utils)
  (guix modules)
  (scripts-pkg)
  (zero packages guile-zerolib))

(chdir (current-source-directory)) ; from (guix utils)
(define (executable-file name file-like)
  (computed-file
    name
    (with-imported-modules
      '((guix build utils))
      #~(begin
          (use-modules
            (guix build utils))
          (copy-file #$file-like
                     #$output)
          (patch-shebang #$output)
          (chmod #$output #o755)))))
(define (compound-file name files)
  (computed-file
    name
    #~(begin
        (display
          #$(serialize-text-config
              ""
              files)
          (open-output-file #$output)))))
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
          (let
            ((tools '("ripgrep"
                      "bfs"
                      "fzf"
                      "byobu"
                      "tmux"
                      "skroll"
                      "bat"
                      "detox"))
             (apps '("mpv" "mpv-mpris"))
             (shell '("zoxide"
                      "direnv"))
             (guile '("guile"
                      "guile-json"
                      "guile-zerolib"
                      "guile-readline"))
             (web '("offpunk"
                    "chafa"
                    "qutebrowser"))
             (wm '("keynav"
                   "bspwm-git"
                   "sxhkd"))
             (lua '("rust-stylua")))
           (append
             apps
             tools
             guile
             wm
             web
             shell
             lua
             '("glibc-locales"))))
        (list
          scripts-pkg)))
          ;}}}
    (services
      (list
        (service home-zsh-service-type;{{{
                 (home-zsh-configuration
                   (environment-variables
                     `(("FPATH"
                        . ,(string-join
                             (append
                               (map
                                 (cute string-append "$HOME/.guix-home/profile/share/zsh/" <>)
                                 '("5.9/functions" "site-functions"))
                               '("$HOME/.config/guix/current/share/zsh/site-functions"
                                 "/usr/share/zsh/site-functions"))
                             ":"))
                       ("SHELL" . ,(file-append zsh "/bin/zsh"))))
                   (zshrc
                     (map (lambda (s)
                            (local-file (string-append "zsh/" s)))
                          (list "zshrc"
                                "aliases.zsh"
                                "commands.zsh"
                                "p10k-single.zsh")))));}}}
        (simple-service 'zsh-direnv;{{{
                        home-zsh-service-type
                        (home-zsh-extension
                          (zshrc
                            (list
                              (computed-file
                                "direnv"
                                (with-extensions
                                  (list guile-zerolib)
                                  (with-imported-modules
                                    '((guix build utils))
                                    #~(begin
                                        (use-modules (guix build utils)
                                                     (zerolib shell))
                                        (display
                                          (call-command
                                            #+(file-append direnv "/bin/direnv")
                                            "hook"
                                            "zsh")
                                          (open-output-file #$output))))))))));}}}
        (simple-service 'zsh-abbr ;{{{
                        home-xdg-configuration-files-service-type
                        `(
                          ("zsh-abbr/user-abbreviations"
                           ,(compound-file
                              "user-abbreviations"
                              (list
                                (local-file "./zsh/abbrs.zsh")
                                (local-file "./zsh/abbrs-xbps.zsh")))))) ;}}}
        (service home-bash-service-type;{{{
                 (home-bash-configuration
                   (environment-variables ;{{{
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
                       ("PAGER" . "less -s -M -j.357 -w -RF --incsearch --mouse --wheel-lines 3")
                       ("MANPAGER" . "sh -c 'col -bx | bat -l man'")
                       ("BAT_PAGER" . "$PAGER")
                       ("DELTA_PAGER" . "$PAGER")
                       ("DOTNET_CLI_TELEMETRY_OPTOUT" . "1")
                       ("POWERSHELL_TELEMETRY_OPTOUT" . "1")
                       ("LINKDING_TOKEN" . "28185e63c63f3324f5613ce152094b34731379a2")
                       ("EDITOR" . "nvim")
                       ("VISUAL" . "$EDITOR")));}}}
                   (bashrc (list
                             (plain-file ""
                                         "PS1='[\\u@\\h \\W]\\$ '")))
                   (bash-profile (list
                                   (plain-file
                                     "guix"
                                     (string-join
                                       '("GUIX_PROFILE=$HOME/.config/guix/current"
                                         ". $GUIX_PROFILE/etc/profile"
                                         "GUIX_PROFILE=$HOME/.guix-profile"
                                         ". $GUIX_PROFILE/etc/profile")
                                       "\n"))
                                   (plain-file
                                     "autorun"
                                     "mkdir -p /tmp/Pictures")
                                   (plain-file
                                     "nix"
                                     (string-append
                                       "[ -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]"
                                       "&& . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh")))))) ;}}}
        (service home-xdg-configuration-files-service-type
                 `(("nvim/keys.vim"
                    ,(compound-file
                       "keys.vim"
                       (list
                         (local-file "nvim/keys.vim")
                         (plain-file
                           ""
                           (string-join
                             (append
                               (map
                                 (cute
                                   format #f
                                   "~anoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'"
                                   <>)
                                 '("n" "x" "o"))
                              (map
                                (cute
                                  format #f
                                  "nnoremap <expr> ~a getline('.') =~~ '^\\s*$' ? 'S' : '~@*~a'" <>)
                                '("A" "I" "a" "i")))
                             "\n")))))))
        (service home-ssh-agent-service-type
                 (home-ssh-agent-configuration))
        (service home-files-service-type
                 `((".local/bin/rg"
                    ,(executable-file
                       "rg"
                       (mixed-text-file
                         "rg"
                         "#!" dash "/bin/dash"
                         "\n" "if [ ! $PWD = $HOME ]; then"
                         "\n\t" ripgrep "/bin/rg $@"
                         "\n" "fi")))
                   (".config/mpv/scripts/mpris.so"
                    ,(file-append mpv-mpris "/lib/mpris.so"))))))))
home
