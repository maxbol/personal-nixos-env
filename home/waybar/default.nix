{ pkgs
, config
, ...
}: {
  home.file.".config/waybar/config".source = ./config.json;
  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/khal.py".source = ./khal.py;
}
