{inputs, ...}: {
  me.determinate = {
    darwin = {
      imports = [
        inputs.determinate.darwinModules.default
      ];

      determinateNix = {
        enable = true;
        registry = {
          # Create registry so that it can be used in `nix run` commands without downloading upstream nixpkgs again
          home.flake = inputs.nixpkgs-unstable;
          home-stable.flake = inputs.nixpkgs;
        };
      };
    };
  };
}
