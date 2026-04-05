{
  darwin,
  home-manager,
  nixpkgs,
  nixpkgs-unstable,
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
          denModule
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
            targets.genericLinux.enable = true;
          }
        ]
        ++ extraModules;
    };
}
