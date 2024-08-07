{ config, lib, pkgs, pkgs-unstable, userSettings, systemSettings, ... }:

{
  imports = [ 
    ./hardware-configuration.nix  
  ]; #++
  #(if (config.nvidia.enable) 
    #then [./nvidia.nix]
  #else
    #(if (config.amd.enable)
      #then [./amd.nix]
      #else []));  
  
  options = {
    nvidia.enable = lib.mkEnableOption;
    amd.enable = lib.mkEnableOption;
  };
  
  config = {
  
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.resumeDevice = "/dev/disk/by-partlabel/Swap";

  security.protectKernelImage = false;

  networking.hostName = systemSettings.hostname;
  networking.networkmanager.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 80 230 443 ];
    allowedUDPPortRanges = [
      { from = 1000; to = 2000; }
    ];
  };

 time.timeZone = systemSettings.timezone;

 i18n.defaultLocale = systemSettings.locale;

  services.xserver.enable = true;
  
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true;

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };
  
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = userSettings.name;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.package = pkgs.mullvad-vpn;
  services.auto-cpufreq.enable = true;

  programs.steam.enable = true;
  programs.gamemode.enable = true;

  ### INITIAL VERS | DO NOT CHANGE
  system.stateVersion = "23.11";

  nix.settings.experimental-features = [ "nix-command" "flakes"];

    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 21d";  
    };
  
  };
}
