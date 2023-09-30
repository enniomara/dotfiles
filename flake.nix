{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, devshell }:
    let
      # the devshells used by this repo
      devshells = (import ./modules/devShell.nix) inputs;
    in
    {

    } // devshells;
}
