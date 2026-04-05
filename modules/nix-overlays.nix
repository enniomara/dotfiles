{inputs, ...}: let
  customOverlays = import ./_overlays.nix {inherit inputs;};
  overlays = [
    customOverlays.golangci-lint

    # extends the default nixpkgs overlay to also include nixpkgs-unstable
    customOverlays.nixpkgs-unstable

    inputs.nix-vscode-extensions.overlays.default
  ];
in {
  me.nix-overlays = {
    darwin.nixpkgs.overlays = overlays;
    homeManager.nixpkgs.overlays = overlays;
  };
}
