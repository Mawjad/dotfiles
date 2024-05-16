{ config, pkgs, ...}:

let
  myAliases = {
    ll = "ls -l";
    ".." = "cd ..";
    dev = "cd ~/Documents/GitHub";
    rdev = "cd ~/.dotfiles/";
    rplasma = "plasmashell --replace & disown";  
  };
in

{
  programs.bash = {
    enable = true;
    shellAliases = myAliases;  
  };

  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };

  programs.helix.defaultEditor = true;

}
