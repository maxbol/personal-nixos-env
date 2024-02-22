{ pkgs, ... }: {
  home.packages = with pkgs; [
    yarn
    yarn2nix
    nodejs
    envsubst
    jq
    docker-compose
  ];
}