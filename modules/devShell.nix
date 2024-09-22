{ self, nixpkgs, flake-utils, devshell, ... }:
flake-utils.lib.eachDefaultSystem (system: {
  devShell =
    let pkgs = import nixpkgs {
      inherit system;

      overlays = [ devshell.overlays.default ];
    };
    in
    pkgs.devshell.mkShell {
      # set the name that will be shown in the zsh prompt
      name = "dotfiles";
      packages = [
        pkgs.stow
        pkgs.go-task
      ];
    };
})

