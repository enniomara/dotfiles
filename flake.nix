{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      rec {
        devShells.default =
          pkgs.mkShell {
            buildInputs = [
              pkgs.stow
            ];
            # set the name that will be shown in the zsh prompt
            name = "dotfiles";
          };
      }
    );
}
