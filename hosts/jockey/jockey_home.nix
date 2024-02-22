{ config, pkgs, inputs, ... }:

{

  imports = [
    # Use Hyprland as DE
    ../../home/environments/hyprland
    ../../home/gtk.nix
    
    # Needed programs
    ../../home/calendar
    ../../home/rofi
    ../../home/vscode
    ../../home/waybar

    ../../home/chrome.nix
    ../../home/cli.nix
    ../../home/development.nix
    ../../home/gaming.nix
    ../../home/git.nix
    ../../home/kubernetes.nix
    ../../home/media.nix
    ../../home/messaging.nix
    ../../home/nvim
    ../../home/productivity.nix
    ../../home/security.nix
    ../../home/shell
    ../../home/slack.nix
    ../../home/spotify.nix
    ../../home/ssh.nix
    ../../home/utils.nix
    ../../home/xdg.nix
  ];

  # Change your username ! 
  home = {
    username = "max";
    homeDirectory = "/home/max";

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
