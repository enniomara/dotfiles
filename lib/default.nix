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
  }:
    darwin.lib.darwinSystem {
      inherit system;

      modules = let
        userConfig =
          builtins.map (userConfig: {
            # a new version of home manager broke compatibility with
            # nix-darwin. It started saying that $HOME as empty.
            # https://github.com/nix-community/./home-manager/issues/4026
            # https://github.com/nix-community/./home-manager/issues/4026
            users.users.${userConfig.username}.home = "/Users/${userConfig.username}";

            home-manager.users.${userConfig.username} = {config, ...}: {
              imports =
                [
                  ../home-manager/home.nix
                  ../home-manager/hammerspoon
                  ../home-manager/karabiner
                  ../home-manager/mac-containers.nix
                ]
                ++ userConfig.imports;

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
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = overlays;

            system.primaryUser = (builtins.head userConfigurations).username;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            # Create registry so that it can be used in `nix run` commands without downloading upstream nixpkgs again
            nix.registry.home.flake = nixpkgs-unstable;
            nix.registry.home-stable.flake = nixpkgs;

            nixpkgs.config.allowUnfree = true;
          }
        ]
        ++ userConfig;
    };

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
            nix.registry.home.flake = nixpkgs-unstable;
            nix.registry.home-stable.flake = nixpkgs;

            nixpkgs.config.allowUnfree = true;
          }
        ]
        ++ extraModules;
    };
}
