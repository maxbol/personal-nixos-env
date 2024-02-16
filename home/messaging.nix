{ pkgs, ... }:

let
  signal-desktop = pkgs.signal-desktop.overrideAttrs (oldAttrs: rec {
    preFixup = oldAttrs.preFixup + ''
      				gappsWrapperArgs+=(
      						--add-flags "--use-tray-icon"
      				)
      		'';
  });


in
{

  home.packages = with pkgs; [
    # messaging
    signal-desktop
    telegram-desktop
    discord
  ];

}
