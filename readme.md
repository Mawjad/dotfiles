# Nix Configuration
## Agenda
- [x] *Custom Options*
- [x] *Special Args*
- [x] *Fix protonup compat params in home-manager*
- [x] [implement Nix format for languages & config in helix.nix; get rid of cloned toml files]
- [ ] *godot.nix*
- [ ] *flatpak.nix*

### Flake:
	nix flake update
>

### System:
	sudo nixos-rebuild switch --flake .
>

### Home-manager:
	home-manager switch --flake .
>

(at least for home-manager)
you can use lib.mkForce/Default to 'toggle values'
[conflicting .nix files / modules]

	optionName = lib.mkForce value; # priority 50

	optionName = value; # priority 100

	optionName = lib.mkDefault value; # priority 1000

	optionName = lib.mkOverride {priority: int}value // manually set value
