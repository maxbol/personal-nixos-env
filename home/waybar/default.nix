{ pkgs
, config
, ...
}: {
  home.packages = with pkgs; [
    inotify-tools
  ];

  home.file.".config/waybar/config".source = ./config.json;
  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/khal.py".source = ./khal.py;
  home.file.".config/waybar/launch_waybar.sh".source = ./launch_waybar.sh;
}
