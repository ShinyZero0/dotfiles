{ config, pkgs, inputs, system, ... }:
let 
  inherit (inputs) nuScripts nuTreeSitter sentsplit jsonfmt;
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "zero";
  home.homeDirectory = "/home/zero";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs;
    ([

      # Stuff
      firefox-devedition-bin
      onlyoffice-bin
      xkeysnail
      keynav

      # Language tooling

      yamlfmt

      pyright
      black

      # Nix
      nix-tree
      nixfmt
      nil

      comrak
      marksman

      shellcheck

      # Installed in devshells:
      # lua-language-server
      # stylua
      # jsbeautifier

      rome
      # rslint
      # flow
      quick-lint-js
      # eslint_d
      omnisharp-roslyn

      # CLI stuff

      croc
      delta
      bat
      gum

      duf
      du-dust

      # selfhost
      bore-cli
      jellyfin
      jellyfin-mpv-shim
      jellycli
      jftui
      jellyfin-web

      btop
      bottom
      qrencode
      entr
      zellij

      moreutils
      fd
      ripgrep
      sd # sed
      fzf
      chroma
      translate-shell
      # markdown previewer
      python311Packages.grip
      github-cli
      # needed for rofi-connman
      empty

      # Fonts
      ibm-plex
      (nerdfonts.override {
        fonts = [
          "InconsolataLGC"
          "IBMPlexMono"
          "NerdFontsSymbolsOnly"
          "CascadiaCode"
        ];
      })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ] ++ [
      jsonfmt.packages.${system}.default
      sentsplit.packages.${system}.default
    ]);

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".local/share/nushell/man-completions.nu".source =
      "${nuScripts}/custom-completions/man/man-completions.nu";
    ".local/share/nvim/lazy/nvim-treesitter/queries/nu/highlights.scm".source =
      "${nuTreeSitter}/queries/highlights.scm";
    ".local/share/nushell/zellij-completions.nu".source =
      "${nuScripts}/custom-completions/zellij/zellij-completions.nu";
    ".local/share/nushell/make-completions.nu".source =
      "${nuScripts}/custom-completions/make/make-completions.nu";
  };

  home.sessionVariables = {
    # DOTNET_ROOT = "${pkgs.dotnet-sdk_7}";
    NIXPKGS = "${pkgs.path}";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.nushell = {
    enable = true;
    # configFile.source = ./config/nushell/config.nu;
    # envFile.source = ./config/nushell/env.nu;
    # extraConfig = "./config/nushell/";
  };
  programs.zoxide = {
    enable = true;
    enableNushellIntegration = false;
  };
  # ...other config, other config...

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableNushellIntegration = false;
  };
}
