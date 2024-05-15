{config, pkgs, ...}:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = [ pkgs.marksman ];
  };

  home.file."~.config/helix/config.toml".source = ./helix-config.toml;
  home.file."~.config/helix/languages.toml".source = ./helix-languages.toml;
}
