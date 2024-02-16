{ config, pkgs, ... }:
let
  contactsUuid = "ee85de46-1923-44ff-aa47-1494baa7cc4c";
  khalConfig = pkgs.callPackage config/khal.nix {};
  khardConfig = pkgs.callPackage config/khard.nix {};
  vdirsyncerConfig = pkgs.callPackage config/vdirsyncer.nix {};
in
{
  home.packages = with pkgs; [
    khal
    khard
  ];

  xdg.configFile = {
    "vdirsyncer/config".text = vdirsyncerConfig;
    "khal/config".text = khalConfig;
    "khard/khard.conf".text = khardConfig;
  };
}