{inputs, ...}: {
  me.nix-registries = {
    homeManager = {
      # Create registry so that it can be used in `nix run` commands without downloading upstream nixpkgs again
      nix.registry.home.flake = inputs.nixpkgs-unstable;
      nix.registry.home-stable.flake = inputs.nixpkgs;
    };

    darwin = {
      determinateNix = {
        registry = {
          # Create registry so that it can be used in `nix run` commands without downloading upstream nixpkgs again
          home.flake = inputs.nixpkgs-unstable;
          home-stable.flake = inputs.nixpkgs;
        };
      };
    };
  };
}
