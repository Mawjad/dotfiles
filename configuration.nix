# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

# Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.resumeDevice = "/dev/disk/by-partlabel/Swap";

  security.protectKernelImage = false;

  networking.hostName = "MAWJAD";
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 443 ];
    allowedUDPPortRanges = [
      { from = 4000; to = 4007; }
      { from = 8000; to = 8010; }
    ];
  };

 #Set your time zone.
 time.timeZone = "America/Phoenix";

 #Select internationalisation properties.
 i18n.defaultLocale = "en_US.UTF-8";

 i18n.extraLocaleSettings = {   
   LC_ADDRESS = "en_US.UTF-8";
   LC_IDENTIFICATION = "en_US.UTF-8";
   LC_MEASUREMENT = "en_US.UTF-8";
   LC_MONETARY = "en_US.UTF-8";
   LC_NAME = "en_US.UTF-8";
   LC_NUMERIC = "en_US.UTF-8";
   LC_PAPER = "en_US.UTF-8";
   LC_TELEPHONE = "en_US.UTF-8";
   LC_TIME = "en_US.UTF-8";
 };

  #Enable the X11 windowing system.
  services.xserver.enable = true;
  
  #Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.mawjad = {
    isNormalUser = true;
    description = "George Alsen Stone";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
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
  };

  #Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
    environment.systemPackages = with pkgs; [
      git
      xclip
      gparted
      parted
      go
      gopls
      odin
      ols
      zig
      zls
      nil
      mitschemeX11
      rustup
      racket
      helix
      neovim
      neofetch
      dig
      raylib
      auto-cpufreq
      emscripten
      scons
    ];

  #services
  services.flatpak.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  services.auto-cpufreq.enable = true;
  
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  nix.settings.experimental-features = [ "nix-command" "flakes"];
}
