{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    yarn
    yarn2nix
    nodejs
  ];
}