{
  description = "Max's first NixOS setup";

  nixConfig = {
    extra-experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://cache.nixos.org/"
    ];

    # nix community's cache server
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  # A flake is basically a list of inputs/outputs in which inputs are built and sent as arguments to outputs
  inputs = {
    # Official NixOS packages URL
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # Home manager for home-scoped config
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
    # Spicetify flake for Nix integration
    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Hyprland utils
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Sops-Nix for secrets managing
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    grub2-themes = {
      url = "github:vinceliuice/grub2-themes";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nixpkgs
    , hyprland
    , spicetify-nix
    , home-manager
    , hyprland-contrib
    , sops-nix
    , grub2-themes
    , ...
    }: {
      nixosConfigurations = {
        # My hostname, don't forget to change it !
        jockey = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          # Load configuration
          modules = [
            ./hosts/jockey
            sops-nix.nixosModules.sops
            grub2-themes.nixosModules.default

            # Load Home Manager
            home-manager.nixosModules.home-manager
            {
              nixpkgs.config.permittedInsecurePackages = [
                "electron-25.9.0"
              ];

              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;

              # Change the username !
              home-manager.extraSpecialArgs = { inherit inputs; };
              # home-manager.extraSpecialArgs = inputs;
              home-manager.users.max = import ./hosts/jockey/jockey_home.nix;
            }
          ];
        };
      };
    };
}
