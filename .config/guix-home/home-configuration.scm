;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules;{{{
  (guix gexp)
  (guix utils)
  (guix build utils)
  (guix modules)
  (gnu home)
  (gnu packages)
  (gnu packages shells)
  (gnu packages rust-apps)
  (gnu packages package-management)
  (gnu packages base)
  (gnu packages video)
  (gnu services configuration)
  (gnu services)
  (gnu home services mcron)
  (gnu home services ssh)
  (gnu home services)
  ;; rde
  (gnu home-services shells)
  (gnu home-services shellutils)
  (rde gexp)

  (srfi srfi-26)
  (scripts-pkg)
  (ice-9 match)
  (zerolib)
  (zero packages guile-zerolib))

(chdir (current-source-directory)) ; from (guix utils)
(define (augmented-directory name dir files);{{{
  (directory-union name
    (cons
      dir
      (map
        (lambda (file)
          (computed-file "additional-file"
                         (with-imported-modules
                           '((guix build utils))
                           #~(begin
                               (use-modules (guix build utils))
                               (mkdir-p #$output)
                               (copy-file
                                 #$file
                                 (string-append
                                   #$output "/" (strip-store-file-name #$file)))))))
        files))));}}}
(define (executable-file name file-like);{{{
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
          (chmod #$output #o755)))));}}}
(define (compound-file name files);{{{
  (computed-file
    name
    #~(begin
        (display
          #$(serialize-text-config
              ""
              files)
          (open-output-file #$output)))));}}}
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
                      "tokei"
                      "ffmpeg"
                      "perl-image-exiftool"
                      "detox"))
             (apps '("mpv"
                     "aerc"))
             (shell '("zoxide"))
             (guile '("guile"
                      "guile-json"
                      "guile-zerolib"
                      "guile-readline"))
             (web '("offpunk"
                    "chafa"
                    "qutebrowser"))
             (wm '("keynav"
                   "rofi"
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
                 (let1
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
                   (home-zsh-configuration
                     (zshenv
                       (list
                         (environment-variable-shell-definitions environment-variables)))
                     (zshrc
                       (map (lambda (f)
                              (slurp-file-like
                                (local-file f)))
                            (append (find-files "zsh.d")
                                    '("./zsh/p10k-single.zsh")))))));}}}
        (service home-zsh-direnv-service-type)
        (simple-service 'zsh-abbr ;{{{
                        home-xdg-configuration-files-service-type
                        `(
                          ("zsh-abbr/user-abbreviations"
                           ,(compound-file
                              "user-abbreviations"
                              (map (lambda (f) (local-file f))
                                   (append (find-files "zsh-abbr.d")
                                           '("./zsh-abbr/abbrs-xbps.zsh"))))))) ;}}}
        (service home-bash-service-type;{{{
                 (let1
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
                       ("VISUAL" . "$EDITOR"))) ;}}}
                   (home-bash-configuration
                     (bashrc (list
                               "PS1='[\\u@\\h \\W]\\$ '"))
                     (bash-profile (let
                                     ((guix;{{{
                                        (string-join
                                          '("GUIX_PROFILE=$HOME/.config/guix/current"
                                            ". $GUIX_PROFILE/etc/profile"
                                            "GUIX_PROFILE=$HOME/.guix-profile"
                                            ". $GUIX_PROFILE/etc/profile")
                                          "\n"))
                                      (nix
                                        (s+
                                          "[ -f $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]"
                                          " && . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"))
                                      (pics
                                        "mkdir -p /tmp/Pictures"));}}}
                                     (list
                                       guix nix pics
                                       (environment-variable-shell-definitions
                                         environment-variables))))))) ;}}}
        (simple-service 'nvim-config ;{{{
          home-xdg-configuration-files-service-type
          (map
            (match-lambda ((path . rest)
                           (cons (string-append "nvim/" path) rest)))
            `(("keys.vim";{{{
               ,(compound-file
                  "keys.vim"
                  (list
                    (local-file "nvim/keys.vim")
                    (plain-file
                      ""
                      (string-join
                        (list
                          (format
                            #f
                            "~{~anoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'~%~}"
                            '("n" "x" "o"))
                          (format
                            #f
                            "~{nnoremap <expr> ~a getline('.') =~~ '^\\s*$' ? 'S' : '~@*~a'~%~}"
                            '("A" "I" "a" "i")))
                        "\n")))));}}}
              ("init.vim"
               ,(compound-file "init"
                  (list
                    (local-file "./nvim/init.vim")
                    (local-file "./nvim/init-desktop.vim"))))
              ("ftplugin"
               ,(local-file "./nvim/ftplugin.d" #:recursive? #t))
              ("snippets"
               ,(local-file "./nvim/snippets.d" #:recursive? #t))
              ("lua/plugins";{{{
               ,(augmented-directory "plugins"
                  (local-file "./nvim/lua/plugins.d"
                              #:recursive? #t)
                  (list
                    (local-file "./nvim/lua/plugins/desktop.lua"))))
              ("lua/config"
               ,(augmented-directory "config"
                  (local-file "./nvim/lua/config.d"
                              #:recursive? #t)
                  (list
                    (local-file "./nvim/lua/config/lualine-desktop.lua" "lualine.lua")))))))
                                      ;}}}}}}
        (service home-ssh-agent-service-type
                 (home-ssh-agent-configuration))
        (service home-files-service-type;{{{
                 `((".local/bin/rg"
                    ,(executable-file
                       "rg"
                       (mixed-text-file
                         "rg"
                         "#!" dash "/bin/dash"
                         "\n" "if [ ! $PWD = $HOME ]; then"
                         "\n\t" ripgrep "/bin/rg $@"
                         "\n" "fi")))))
        (service home-xdg-configuration-files-service-type
                 `((".config/mpv/scripts/mpris.so"
                    ,(file-append mpv-mpris "/lib/mpris.so"))))))));}}}
home
