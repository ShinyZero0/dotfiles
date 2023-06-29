{ config, pkgs, nuScripts, nuTreeSitter, ... }: {
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
  home.packages = with pkgs; [

    # Stuff

    firefox-devedition-bin
    onlyoffice-bin
    xkeysnail
    keynav

    # Language tooling

    pyright
    black

    # Nix
    nixfmt
    nil

    comrak
    marksman

    shellcheck

    # Required in flakes:
    # lua-language-server
    # stylua
    # omnisharp-roslyn 

    # CLI stuff

    magic-wormhole-rs
    delta
    bat
    gum
    vivid

    duf
    du-dust

    btop
    bottom
    qrencode
    entr # run commands on file changes
    zellij
    moreutils
    fd
    ripgrep
    sd # sed
    skim
    fzf
    # pagers
    moar
    ov
    chroma
    translate-shell
    python310Packages.grip # markdown previewer
    github-cli
    empty # needed for rofi-connman

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
  ];

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

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/zero/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
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
