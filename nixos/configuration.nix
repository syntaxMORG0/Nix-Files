{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./pkgs.nix
    ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Hostname
  networking.hostName = "flake";

  # Networking
  networking.networkmanager.enable = true;

  # Time
  time.timeZone = "Europe/Oslo";

  # Console keymap
  console.keyMap = "no";

  # X11 (still useful for fallback + XWayland apps)
  services.xserver.enable = true;
  services.xserver.xkb.layout = "no";
  services.xserver.xkb.options = "eurosign:e,caps:escape";

  # PipeWire audio
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Input devices
  services.libinput.enable = true;

  # Sway
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # XDG Portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # Polkit
  security.polkit.enable = true;

  # DBus
  services.dbus.enable = true;

  # OpenSSH
  services.openssh.enable = true;

  # User
  users.users.noah = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    initialPassword = "pass";

    packages = with pkgs; [
      tree
    ];
  };

  # Firefox
  programs.firefox.enable = true;

  # Graphics
  hardware.opengl.enable = true;

  system.stateVersion = "26.05";
}
