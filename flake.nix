{
  description = "Home Manager configuration of Ennio";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";
    devshell.url = "github:numtide/devshell";
  };

  outputs = inputs @ { self, nixpkgs, flake-utils, home-manager, darwin, devshell }:
    let
      # the devshells used by this repo
      devshells = (import ./modules/devShell.nix) inputs;

      customOverlays = import ./home-manager/overlays.nix;
      overlays = [
        customOverlays.oh-my-zsh
      ];

      mkDarwinSystem = { username, extraModules ? [ ] }: darwin.lib.darwinSystem {
        system = "x86_64-darwin";
        modules = [
          ./home-manager/configuration.nix
          home-manager.darwinModules.home-manager
          {
            nixpkgs.overlays = overlays;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = { config, ... }: {
              imports = [
                ./home-manager/home.nix
                ./home-manager/hammerspoon.nix
                ./home-manager/karabiner.nix
              ] ++ extraModules;

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
      mkLinuxSystem = { username, extraModules ? [ ] }: home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [
          ./home-manager/home.nix
          ({
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
          })
        ] ++ extraModules;
      };
    in
    {
      darwinConfigurations."M-C02G32FSML7H" = mkDarwinSystem {
        username = "marae";
        extraModules = [
          (import ./home-manager/axis.nix)
          ({
            services.aws-sso = {
              enable = true;
              secureStore = "keychain";
              extraConfig = ''
                UrlAction: open-url-in-container
                ConfigProfilesUrlAction: open-url-in-container
                UrlExecCommand:
                  - /Applications/Firefox.app/Contents/MacOS/firefox
                  - "%s"
              '';
            };
          })
        ];
      };

      darwinConfigurations."Ennios-MacBook-Pro" = mkDarwinSystem {
        username = "enniomara";
        extraModules = [
          ./home-manager/personal.nix
        ];
      };

      # work workstation
      homeConfigurations."marae@pcczc65196q9" = mkLinuxSystem {
        username = "marae";
        extraModules = [
          (import ./home-manager/axis.nix)
          ({
            # I want to automatically open in my laptop's browser, instead of
            # having to override the BROWSER variable
            services.open-url-via-ssh.automaticBrowserOverride = true;
            services.aws-sso = {
              enable = true;
              secureStore = "file";
              extraConfig = ''
                UrlAction: open
              '';
            };
          })
          ./home-manager/agent-forwarding-tmux.nix
        ];
      };

      homeConfigurations."vagrant@linux-box" = mkLinuxSystem { username = "vagrant"; };
    } // devshells;
}
