{ config, lib, pkgs, pkgs-new, pkgs-unstable, userSettings, systemSettings, ... }:

{
  home.username = userSettings.username;
  home.homeDirectory = "/home/"+userSettings.username;
    
  programs.home-manager.enable = true;

  imports = [
    ./sh.nix
    ./helix.nix
  ];

  home.stateVersion = "23.11";

  nixpkgs.config.allowUnfree = true;
  home.packages = 
  (with pkgs; [
    git
    xclip
    gparted
    parted
    clang
    go
    gopls
    odin
    ols
    zig
    zls
    nil
    mitschemeX11
    racket
    neovim
    neofetch
    dig
    auto-cpufreq
    emscripten
    scons
    protonup
    firefox
    chromium
    librewolf
    spotify
    obs-studio
    krita
    libresprite
    vscodium
    flameshot
    libsForQt5.bismuth
    libsForQt5.plasma-disks
    libsForQt5.plasma-workspace
    gnome.gnome-software
    noisetorch
    butler
    discord
    discord-canary
    netcat-gnu
    lm_sensors
    lmms
  ])

  ++

  (with pkgs-new;[
    raylib
    rustc
    rust-analyzer
    cargo
    clippy
  ])

  ++
  
  (with pkgs-unstable;[
    webcord-vencord
    vesktop
  ]);

  
  home.sessionVariables = {
    EDITOR = lib.mkForce userSettings.editor;
    ### PROTONUP COMPAT PATH ###
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
    "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
