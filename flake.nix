{
  description = "Home Manager configuration of Ennio";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin.url = "github:lnl7/nix-darwin/nix-darwin-25.05";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    devshell.url = "github:numtide/devshell";
    devshell.inputs.nixpkgs.follows = "nixpkgs";

    # this flake is updated much more frequently than the release
    # nixpkgs. Added via a custom overlay.
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.flake-utils.follows = "flake-utils";
    };

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    import-tree.url = "github:vic/import-tree";
    den.url = "github:vic/den";
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixpkgs-unstable,
    flake-utils,
    home-manager,
    darwin,
    devshell,
    nix-vscode-extensions,
    determinate,
    import-tree,
    den,
  }: let
    customOverlays = import ./home-manager/overlays.nix {inherit inputs;};
    overlays = [
      customOverlays.golangci-lint

      # extends the default nixpkgs overlay to also include nixpkgs-unstable
      customOverlays.nixpkgs-unstable

      nix-vscode-extensions.overlays.default
    ];

    # the devshells used by this repo
    devshells = import ./devShell.nix {inherit devshell nixpkgs flake-utils overlays;};

    lib = import ./lib {inherit overlays nixpkgs nixpkgs-unstable home-manager darwin;};

    den =
      (inputs.nixpkgs.lib.evalModules {
        modules = [(inputs.import-tree ./modules)];
        specialArgs.inputs = inputs;
      }).config;

    inherit (den.den.hosts.aarch64-darwin) M-K6P79MG3J6;
    pcczc65196q9 = den.den.homes.x86_64-linux."marae@pcczc65196q9";

  in
    {
      darwinConfigurations."M-K6P79MG3J6" = lib.mkDarwinSystem {
        system = "aarch64-darwin";
        denModule = M-K6P79MG3J6.mainModule;
        userConfigurations = [
          {
            username = "marae";
            imports = [
              (import ./home-manager/axis.nix)
            ];
          }
          {
            username = "enniomara";
            imports = [./home-manager/personal.nix];
          }
        ];
      };

      darwinConfigurations."Ennios-MacBook-Pro" = lib.mkDarwinSystem {
        system = "x86_64-darwin";
        userConfigurations = [
          {
            username = "enniomara";
            imports = [./home-manager/personal.nix];
          }
        ];
      };

      # work workstation
      homeConfigurations."marae@pcczc65196q9" = lib.mkLinuxSystem {
        username = "marae";
        denModule = pcczc65196q9.mainModule;
        extraModules = [
          (import ./home-manager/axis.nix)
        ];
      };

      homeConfigurations."vagrant@linux-box" = lib.mkLinuxSystem {username = "vagrant";};
    }
    // devshells;
}
