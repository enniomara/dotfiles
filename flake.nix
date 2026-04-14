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
    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.flake-utils.follows = "flake-utils";
    };

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/3";

    import-tree.url = "github:vic/import-tree";
    den.url = "github:vic/den";
  };

  outputs = inputs: let
    # the devshells used by this repo
    devshells = import ./devShell.nix inputs;

    den =
      (inputs.nixpkgs.lib.evalModules {
        modules = [(inputs.import-tree ./modules)];
        specialArgs.inputs = inputs;
      }).config;
  in
    {
      inherit (den.flake) nixosConfigurations darwinConfigurations homeConfigurations;
    }
    // devshells;
}
