{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs = { self, nixpkgs, flake-utils, devshell }:
    flake-utils.lib.eachDefaultSystem (system: {
      devShell =
        let pkgs = import nixpkgs {
          inherit system;

          overlays = [ devshell.overlay ];
        };
        in
        pkgs.devshell.mkShell {
          # set the name that will be shown in the zsh prompt
          name = "dotfiles";
          packages = [
            pkgs.stow
            pkgs.goku
          ];
          commands = [
            {
              name = "rebuild-home";
              command = "home-manager switch --flake \"$PRJ_ROOT/nix/.config/nixpkgs/\"";

            }
          ];
        };
    });
}
