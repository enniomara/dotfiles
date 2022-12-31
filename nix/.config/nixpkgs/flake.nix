{
  description = "Home Manager configuration of Ennio";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, home-manager }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        # Got the tip of using legacypackages from
        # https://www.reddit.com/r/NixOS/comments/x2ohne/converting_my_home_manager_setup_to_flake/imktfr5/,
        # which is needed because home-manager doesn't seem to support
        # generating configuration for all supported systems (using
        # flake-utils). Issue tracking that is in
        # https://github.com/nix-community/home-manager/issues/3075
        # It doesn't feel good to do this but it seems to work at the time of
        # writing (2022-12-31)
        legacyPackages.homeConfigurations.marae = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./home.nix
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      }
    );
}
