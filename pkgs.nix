{ lib, pkgs, ... }:

let
  zen = builtins.getFlake "github:ch4og/zen-browser-flake";
  m4b-tool = builtins.getFlake "github:sandreas/m4b-tool";
in

{
  home.packages = with pkgs; [
    vesktop
    # deadd-notification-center
    gnupg
    signal-desktop
    gimp
    steam
    neofetch
    btop
    baobab
    texliveFull
    typst
    spotify
    zen.packages.${builtins.currentSystem}.default
    mutt-wizard
    pinentry-rofi
    stremio
    ddcutil
    ddcui
    libreoffice-still
    autojump
    unzip
    gcc
    ripgrep
    pass
    isync
    libnotify
    python312
    python312Packages.pip
    python312Packages.virtualenv
    nodejs_22
    nodePackages_latest.typescript-language-server
    #nodePackages_latest.svelte-language-server
    android-studio
    ghidra
    android-tools
    bento4
    m4b-tool.packages.${builtins.currentSystem}.default
    vlc
    pamixer
    jq
    evince
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-original"
    "steam-unwrapped"
    "steam-run"
    "spotify"
    "android-studio-stable"
  ];
}
