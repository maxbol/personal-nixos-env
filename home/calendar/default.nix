{ config, pkgs, ... }:
let
  contactsUuid = "ee85de46-1923-44ff-aa47-1494baa7cc4c";
  khalConfig = callPackage config/khal.nix {};
  khardConfig = callPackage config/khard.nix {};
  vdirsyncerConfig = callPackage config/vdirsyncer.nix {};
in
{
  home.packages = with pkgs; [
    khal
    khard
    vdirsyncer
  ];

  xdg.configFile = {
    "vdirsyncer/config".text = vdirsyncerConfig;
    "khal/config".text = khalConfig;
    "khard/khard.conf".text = khardConfig;
  };

  systemd.services."vdirsyncer" = {
    description = "Synchronize calendars and contacts";
    startLimitBurst = 2;
    serviceConfig = {
      ExecStart = ''${pkgs.vdirsyncer}/bin/vdirsyncer sync'';
      RunTimeMaxSec = "3m";
      Restart = "on-failure";
    };
  };

  systemd.timers."vdirsyncer" = {
    description = "Synchronize vdirs";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "5m";
      OnUnitActiveSec = "15m";
      AccuracySec = "5m";
    };
  };
}