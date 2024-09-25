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
            home.activation.report-changes = home-manager.lib.hm.dag.entryAnywhere ''
              echo "++++* System Changes ++++++"
              nix store diff-closures $(ls -dv /nix/var/nix/profiles/per-user/${username}/home-manager-*-link | tail -2)
            '';

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
                ../home-manager/hammerspoon.nix
                ../home-manager/karabiner.nix
              ]
              ++ extraModules;

            config = {
              # from https://discourse.nixos.org/t/nvd-simple-nix-nixos-version-diff-tool/12397/31
              home.activation.report-changes = config.lib.dag.entryAnywhere ''
                echo "++++* System Changes ++++++"
                nix store diff-closures $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)
              '';
            };
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
