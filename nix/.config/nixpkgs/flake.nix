{
  description = "Home Manager configuration of Ennio";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, darwin }:
    let
      customOverlays = import ./overlays.nix;
      overlays = [
        customOverlays.oh-my-zsh
      ];

      mkDarwinSystem = { username, extraModules ? [ ] }: darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = overlays;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = { ... }: {
              imports = [
                ./home.nix
                ./hammerspoon.nix
              ] ++ extraModules;
            };
          }
        ];

      };
      mkLinuxSystem = { username, extraModules ? [ ] }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home.nix
          ({
            nixpkgs.overlays = overlays;
            home.username = username;
            home.homeDirectory = "/home/${username}";
            targets.genericLinux.enable = true;
          })
        ] ++ extraModules;
      };
    in
    {
      darwinConfigurations."M-C02G32FSML7H" = mkDarwinSystem {
        username = "marae";
        extraModules = [
          ./axis.nix
        ];
      };

      darwinConfigurations."Ennios-MacBook-Pro" = mkDarwinSystem {
        username = "enniomara";
        extraModules = [
          ./personal.nix
        ];
      };

      # work workstation
      homeConfigurations."marae@pcczc65196q9" = mkLinuxSystem {
        username = "marae";
        extraModules = [
          ./axis.nix
        ];
      };

      homeConfigurations."vagrant@linux-box" = mkLinuxSystem { username = "vagrant"; };
    };
}
