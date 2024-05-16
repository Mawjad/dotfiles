{ config, lib, pkgs, userSettings, systemSettings, ... }:

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
  home.packages = with pkgs; [
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
    libsForQt5.bismuth
    libsForQt5.plasma-disks
    libsForQt5.plasma-workspace
    gnome.gnome-software
  ];

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
