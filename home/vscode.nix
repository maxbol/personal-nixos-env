{ config, lib, pkgs, ... }:

let
  marketplaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "tokyo-night";
      publisher = "enkia";
      version = "0.9.6";
      sha256 = "sha256-Vk6wIGMzWPpv+A4vnHWAYnxTFYQBpVYZNu1BRim/TN0=";
    }
    {
      name = "azure-account";
      publisher = "ms-vscode";
      version = "0.11.6";
      sha256 = "sha256-bLhlQxpZHhL3IHAqFxJEhe38/hIklBqCxBdXeKPBawI="
    }
  ];
in
{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions;
      [
        bbenoist.nix
        (ms-python.python.overrideAttrs (finalAttrs: previousAttrs: {
          postPatch = "";
          separateDebugInfo = true;
        }))
        ms-azuretools.vscode-docker
        ms-vscode-remote.remote-ssh
      ] ++ marketplaceExtensions;
    userSettings = let fontSize = 12; in {
      "workbench.colorTheme" = "Tokyo Night";
      "workbench.startupEditor" = "none";

      # editor
      # "editor.fontFamily" = "Pragmata Pro Mono";
      "editor.fontFamily" = "JetBrainsMono Nerd Font Mono";
      "editor.fontSize" = fontSize;
      "editor.wordWrap" = "on";
      "editor.minimap.enabled" = false;

      # integrated terminal
      "terminal.integrated.fontSize" = fontSize;

      # python
      "python.formatting.provider" = "none";
      "[python]" = {
        "editor.defaultFormatter" = "ms-python.black-formatter";
        "editor.formatOnSave" = true;
      };
    };
  };
}
