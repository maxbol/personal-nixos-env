# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      # General system settings
      ../../modules/system.nix
      # Use Hyprland on my laptop !
      ../../modules/hyprland.nix
      # Sync all calendars and contacts
      ../../modules/vdirsyncer.nix
      # Incluse results of the hardware scan
      ./hardware-configuration.nix
    ];

  # Bootloader
  boot.loader = {
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      device = "nodev";
      efiSupport = true;
      useOSProber = false;
    };
    grub2-theme = {
      enable = true;
      theme = "whitesur";
      icon = "whitesur";
      screen = "ultrawide2k";
    };
  };

  boot.initrd.systemd.enable = true;
  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  environment.systemPackages = with pkgs; [
    plymouth
    breeze-plymouth
  ];

  boot.kernelParams = [
    "hid-apple.fnmode=2"
    "hid-apple.iso_layout=1"
    "hid-apple.swap_opt_cmd=0"
    "quiet"
    "video=DP-2:3440x1440@60"
  ];

  networking.hostName = "jockey"; # Change your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  nix.settings = {
    # Enable flake support
    experimental-features = [ "nix-command" "flakes" ];
    # Optimise store
    auto-optimise-store = true;
  };

  services.syncthing = {
    enable = true;
    user = "max";
    dataDir = "/home/max";
    configDir = "/home/max/.config/syncthing";
  };

  systemd.services.tailscale-autoconnect = {
    description = "Automatic connection to Tailscale";

    # make sure tailscale is running before trying to connect to tailscale
    after = [ "network-pre.target" "tailscale.service" ];
    wants = [ "network-pre.target" "tailscale.service" ];
    wantedBy = [ "multi-user.target" ];

    # set this service as a oneshot job
    serviceConfig.Type = "oneshot";

    # have the job run this shell script
    script = with pkgs; ''
      # wait for tailscaled to settle
      sleep 2

      # check if we are already authenticated to tailscale
      status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
      if [ $status = "Running" ]; then # if so, then do nothing
        exit 0
      fi

      # otherwise authenticate with tailscale
      ${tailscale}/bin/tailscale up -authkey tskey-auth-kp1kJ86CNTRL-WxWbRp85hmKnXvLHgMGvmKhQrNeetnfs
    '';
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}


