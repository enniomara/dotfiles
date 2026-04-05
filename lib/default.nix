{
  darwin,
  home-manager,
  nixpkgs,
  nixpkgs-unstable,
  overlays,
  ...
}: {
  # Userconfiguration is a list of users to configure. The first user will be the primary user.
  mkDarwinSystem = {
    userConfigurations,
    system,
    denModule,
  }:
    darwin.lib.darwinSystem {
      inherit system;

      modules = let
        userConfig =
          builtins.map (userConfig: {
            home-manager.users.${userConfig.username} = {config, ...}: {
              imports = userConfig.imports;
            };
          })
          userConfigurations;
      in
        [
          ../home-manager/configuration.nix
          denModule
          {
            nixpkgs.overlays = overlays;
          }
        ]
        ++ userConfig;
    };

  mkLinuxSystem = {
    username,
    denModule,
    extraModules ? [],
  }:
    home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages.x86_64-linux;

      modules =
        [
          denModule
          {
            nixpkgs.overlays = overlays;
            targets.genericLinux.enable = true;
          }
        ]
        ++ extraModules;
    };
}
