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

  outputs = inputs @ {
    self,
    nixpkgs,
    flake-utils,
    home-manager,
    darwin,
    devshell,
  }: let
    # the devshells used by this repo
    devshells = (import ./modules/devShell.nix) inputs;

    customOverlays = import ./home-manager/overlays.nix;
    overlays = [
      customOverlays.golangci-lint
    ];

    lib = import ./lib {inherit overlays nixpkgs home-manager darwin;};
  in
    {
      darwinConfigurations."M-K6P79MG3J6" = lib.mkDarwinSystem {
        system = "aarch64-darwin";
        userConfigurations = [
          {
            username = "marae";
            imports = [
              (import ./home-manager/axis.nix)
              {
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
              }
            ];
          }
          {
            username = "enniomara";
            imports = [./home-manager/personal.nix];
          }
        ];
      };

      darwinConfigurations."Ennios-MacBook-Pro" = lib.mkDarwinSystem {
        system = "x86_64-darwin";
        userConfigurations = [
          {
            username = "enniomara";
            imports = [./home-manager/personal.nix];
          }
        ];
      };

      # work workstation
      homeConfigurations."marae@pcczc65196q9" = lib.mkLinuxSystem {
        username = "marae";
        extraModules = [
          (import ./home-manager/axis.nix)
          {
            # I want to automatically open in my laptop's browser, instead of
            # having to override the BROWSER variable
            services.open-url-via-ssh.automaticBrowserOverride = true;
            services.aws-sso = {
              enable = true;
              secureStore = "file";
              # if url opening doesn't work, make sure that the GUI services in
              # ubuntu are not started (i.e. when a user is logged in through
              # the gui)
              extraConfig = ''
                UrlAction: open
              '';
            };
          }
          ./home-manager/agent-forwarding-tmux.nix
        ];
      };

      homeConfigurations."vagrant@linux-box" = lib.mkLinuxSystem {username = "vagrant";};
    }
    // devshells;
}
