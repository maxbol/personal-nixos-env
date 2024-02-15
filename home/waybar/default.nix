{ pkgs
, config
, ...
}: let
  waybar-tooltip-khal = fetchurl "https://github.com/TheChymera/waybar-tooltips/blob/fb2a638fe58959f9f496d6e77396f746118e761a/bin/waybar-tooltip-khal.py";
in {
  home.file.".config/waybar/config".source = ./config.json;
  home.file.".config/waybar/style.css".source = ./style.css;
  home.file.".config/waybar/khal.py".source = waybar-tooltip-khal;
}
