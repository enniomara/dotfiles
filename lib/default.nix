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

              config = {
                # use the 1password agent to sign commits on mac
                programs.git.extraConfig."gpg \"ssh\"".program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
              };
            };
          })
          userConfigurations;
      in
        [
          ../home-manager/configuration.nix
          denModule
          {
            nixpkgs.overlays = overlays;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
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

            # Create registry so that it can be used in `nix run` commands without downloading upstream nixpkgs again
            nix.registry.home.flake = nixpkgs-unstable;
            nix.registry.home-stable.flake = nixpkgs;
          }
        ]
        ++ extraModules;
    };
}
