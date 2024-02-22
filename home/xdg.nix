{ config, ... }:
let
  browser = [ "chrome.desktop" ];

  # XDG MIME types
  associations = {
    "application/json" = browser;
    "application/pdf" = [ "org.pwmt.zathura.desktop.desktop" ];
    "application/x-extension-htm" = browser;
    "application/x-extension-html" = browser;
    "application/x-extension-shtml" = browser;
    "application/x-extension-xht" = browser;
    "application/x-extension-xhtml" = browser;
    "application/xhtml+xml" = browser;
    "audio/*" = [ "mpv.desktop" ];
    "image/*" = [ "imv.desktop" ];
    "text/html" = browser;
    "video/*" = [ "mpv.dekstop" ];
    "x-scheme-handler/about" = browser;
    "x-scheme-handler/chrome" = [ "chrome.desktop" ];
    "x-scheme-handler/discord" = [ "discordcanary.desktop" ];
    "x-scheme-handler/ftp" = browser;
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "x-scheme-handler/notion" = "notion-app-enhanced.desktop";
    "x-scheme-handler/spotify" = [ "spotify.desktop" ];
    "x-scheme-handler/tg" = [ "telegramdesktop.desktop" ];
    "x-scheme-handler/unknown" = browser;
    "x-scheme-handler/webcal" = browser;
  };
in
{
  xdg = {
    enable = true;
    cacheHome = config.home.homeDirectory + "/.local/cache";

    mimeApps = {
      enable = true;
      defaultApplications = associations;
    };

    userDirs = {
      enable = false;
      createDirectories = false;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "${config.xdg.userDirs.pictures}/Screenshots";
      };
    };
  };
}
