{
  darwin,
  home-manager,
  nixpkgs,
  overlays,
  ...
}: {
  mkLinuxSystem = {
    username,
    extraModules ? [],
  }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      # Specify your home configuration modules here, for example,
      # the path to your home.nix.
      modules =
        [
          ../home-manager/home.nix
          {
            nixpkgs.overlays = overlays;
            home.username = username;
            home.homeDirectory = "/home/${username}";
            targets.genericLinux.enable = true;

            # Create registry so that it can be used in `nix run` commands without downloading upstream nixpkgs again
            nix.registry.home.flake = nixpkgs;
          }
        ]
        ++ extraModules;
    };

  mkDarwinSystem = {
    username,
    extraModules ? [],
  }:
    darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ../home-manager/configuration.nix
        home-manager.darwinModules.home-manager
        {
          nixpkgs.overlays = overlays;

          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.${username} = {config, ...}: {
            imports =
              [
                ../home-manager/home.nix
                ../home-manager/hammerspoon
                ../home-manager/karabiner
              ]
              ++ extraModules;
          };

          # a new version of home manager broke compatibility with
          # nix-darwin. It started saying that $HOME as empty.
          # https://github.com/nix-community/./home-manager/issues/4026
          # https://github.com/nix-community/./home-manager/issues/4026
          users.users.${username}.home = "/Users/${username}";

          # Create registry so that it can be used in `nix run` commands without downloading upstream nixpkgs again
          nix.registry.home.flake = nixpkgs;
        }
      ];
    };
}
