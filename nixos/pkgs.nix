# this is the packages file (for permanent packages)
{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    curl
    htop
    librewolf
    sway
    kitty
    waybar
    swaybg
    xdg-desktop-portal-wlr
    fastfetch
  ];
  fonts.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
