# Basic system configuration

{ config, pkgs, ... }:

{
  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "sv_SE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Fonts for system and TWM
  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      hack-font
      noto-fonts-cjk-serif
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-extra

      # nerdfonts
      (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "DroidSansMono" ]; })
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # Do I need this?
    fontconfig.defaultFonts = {
      serif = [ ];
      sansSerif = [ ];
      monospace = [ ];
      emoji = [ ];
    };
  };

  # zsh needs to be set before changing the default shell
  programs.zsh.enable = true;
  programs.dconf.enable = true;

  # No firwall for now, will switch when real install
  networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PasswordAuthentication = true; # temporarily enable pwd auth
    };
    openFirewall = true;
  };

  services.tailscale.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in base system profile
  environment.systemPackages = with pkgs; [
    vim # Anything but Nano please
    wget
    killall
    curl
    git
    sops
    sysstat
    tailscale
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = false;
    extraConfig = "
  		load-module module-switch-on-connect
		";
  };

  services.power-profiles-daemon = {
    enable = true;
  };

  security.polkit.enable = true;
  # Auto-unlock of keyring
  security.pam.services.gdm.enableGnomeKeyring = true;

  services = {
    dbus.packages = [ pkgs.gcr ];

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };

  };

  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };

  # Change user and set a password !
  users.users.max = {
    isNormalUser = true;
    description = "Max Bolotin";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };

  # Auto-cleaning
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

}
