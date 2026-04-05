{inputs, ...}: {
  me.nix-registries = {
    homeManager = {
      # Create registry so that it can be used in `nix run` commands without downloading upstream nixpkgs again
      nix.registry.home.flake = inputs.nixpkgs-unstable;
      nix.registry.home-stable.flake = inputs.nixpkgs;
    };

    darwin = {
      # this configuration makes nixpkgs use the system configuration (configured
      # by the flake), instead of using the configuration from GH. Not what I want.
      # I want 'nixpkgs#<prog>' to always fetch the latest nixpkgs version. For
      # pinned version i usually use 'home#<prog>'.
      nixpkgs.flake.setFlakeRegistry = false;
      nixpkgs.flake.setNixPath = false;

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
