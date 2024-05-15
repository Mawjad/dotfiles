# Nix Configuration To-Do

- [ ] *Custom Options*
- [ ] *Special Args*

# Flake:
	nix flake update
>

# System:
	sudo nixos-rebuild switch --flake .
>

# Home-manager:
	home-manager switch --flake .
>

(at least for home-manager)
you can use lib.mkForce/Default to 'toggle values'
[conflicting .nix files / modules]

	optionName = lib.mkForce value; # priority 50

	optionName = value; # priority 100

	optionName = lib.mkDefault value; # priority 1000

	optionName = lib.mkOverride {priority: int}value // manually set value
