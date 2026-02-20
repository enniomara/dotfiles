{
  nixpkgs,
  flake-utils,
  devshell,
  overlays,
  ...
}:
flake-utils.lib.eachDefaultSystem (system: {
  devShell = let
    pkgs = import nixpkgs {
      inherit system;

      overlays =
        [devshell.overlays.default]
        ++ overlays;
    };
  in
    pkgs.devshell.mkShell {
      # set the name that will be shown in the zsh prompt
      name = "dotfiles";
      packages = [
        pkgs.stow
        pkgs.go-task
        pkgs.alejandra
        pkgs.stylua
        pkgs.pre-commit
        pkgs.nh
      ];
    };
})
