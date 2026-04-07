{inputs, ...}: let
  customOverlays = import ./_overlays.nix {inherit inputs;};
  overlays = [
    customOverlays.golangci-lint

    # extends the default nixpkgs overlay to also include nixpkgs-unstable
    customOverlays.nixpkgs-unstable

    inputs.nix-vscode-extensions.overlays.default
  ];
in {
  me.nix = {
    includes = [
      # only run this if configuration type is home-manager. Without this, on
      # darwin/nixos nixpkgs.overlays will be set in both darwin/nixos
      # configuration, and home-manager. Home-Manager doesn't like that.
      ({home, ...}: {
        homeManager = {
          nixpkgs.overlays = overlays;
        };
      })
    ];

    darwin = {
      nixpkgs.overlays = overlays;

      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    };
  };
}
