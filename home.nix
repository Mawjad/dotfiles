{ config, lib, pkgs, pkgs-unstable, userSettings, systemSettings, ... }:

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
    #go
    #gopls
    odin
    ols
    zig
    zls
    nil
    mitschemeX11
    rustup
    racket
    neovim
    neofetch
    lldb
    dig
    auto-cpufreq
    emscripten
    scons
    protonup
    firefox
    librewolf
    spotify
    obs-studio
    krita
    webcord-vencord
    peek
    libresprite
    vscodium
    flameshot
    libglvnd
    xorg.libXi
    xorg.libX11
    xorg.libXrandr
    xorg.libXcursor
    xorg.libXinerama
    libsForQt5.bismuth
    libsForQt5.plasma-disks
    libsForQt5.plasma-workspace
    gnome.gnome-software
  ])

  ++

  (with pkgs-unstable;[
    raylib
    go
    gopls
  ]);

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;
  };

  home.sessionVariables = {
    EDITOR = lib.mkForce userSettings.editor;
    ### PROTONUP COMPAT PATH ###
    STEAM_EXTRA_COMPAT_TOOLS_PATHS =
    "\${HOME}/.steam/root/compatibilitytools.d";
  };
}
