# Nixos Configuration
This directory contains configuration definitions for all of the machines running Nixos. This configuration is intended to be run by [Colmena](bootstrap-configuration.nix).

## Theory of Operation
`hive.nix` is the entry point. All definitions within that file are lazily evaluated. Machine definitions and role definitions are created separately and composed to form the final configuration for a given box.

`bootstrap-configuration.nix` exists to aid in boot-strapping new machines and in intended to be copied over `/etc/nixos/configuration.nix`. It enables ssh and adds a public key to allow `hive` definitions to then be applied.

## Modifying the Config
To change the configuration of a Nios machine update modify the appropriate `.nix` files in this directory then run `colmena apply` from within this directory. This will compute and apply the configuration for all machines defined in `hive.nix`. It is required that all defined machines be running and accessible for the apply phase to succeed. If you want to apply to only one box you can use `colmena apply --on [hostname]`. Sometimes it is necessary to reboot machines to change their configuration (for example for running services to be stopped after removing them). If a reboot is desired use `colmena apply --reboot`.

**N.B.** Colmena applies configurations to the machines but does not copy the `.nix` configuration files from this directory to those machines. That means that you cannot* locally change the configuration and must use this repo to modify the configurations.
**Well technically you can but it's ill-advised.*

## Updating Software
In `hive.nix` a specific repo version is pinned. To update software change the `meta.nixpkgs.rev` hash to a newer commit in the branch defined by `ref`. Then run `colmena apply` to download the new commit and apply it to the machines.