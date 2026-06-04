# this is the packages file (for permanent packages)
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    helix
    curl
    htop
    librewolf
    sway
    waybar
    swaybg
    xdg-desktop-portal-wlr
    fastfetch
  ];
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
