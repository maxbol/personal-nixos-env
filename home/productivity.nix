{ pkgs, ... }:

{

  home.packages = with pkgs; [
    # productivity
    azuredatastudio
    obsidian
    notion-app-enhanced
    calibre
    gvfs
  ];

}
