my nix files (for nixos-minimal)

This comes with a configured verison of sway and kitty as a terminal

install

```bash
rm -f /etc/nixos/configuration.nix
cp ~/Nix-Files/nixos/configuration.nix /etc/nixos/ # This assumes you have cloned it in ~/ or $HOME
cp ~/Nix-Files/nixos/pkgs.nix /etc/nixos/ # this file contains your persistent packages
sudo nixos-rebuild switch # rebuild and apply changes
```
