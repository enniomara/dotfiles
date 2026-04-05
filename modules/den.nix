{
  inputs,
  den,
  lib,
  me,
  ...
}: {
  imports = [
    inputs.den.flakeModule
    (inputs.den.namespace "me" true)
  ];

  den.default = {
    homeManager.home.stateVersion = lib.mkDefault "23.05";

    darwin = {
      system.stateVersion = lib.mkDefault 4;
    };

    includes = [
      den.provides.define-user
      me.nix
      me.nix-registries
    ];
  };

  den.schema.user.classes = lib.mkDefault ["homeManager"];
  den.ctx.user.includes = [den._.mutual-provider];

  den.hosts.aarch64-darwin.M-K6P79MG3J6.users.marae = {};
  den.hosts.aarch64-darwin.M-K6P79MG3J6.users.enniomara = {};
  den.hosts.x86_64-darwin.Ennios-MacBook-Pro.users.enniomara = {};
  den.homes.x86_64-linux."marae@pcczc65196q9" = {};
  den.homes.x86_64-linux."vagrant@linux-box" = {};

  den.aspects.M-K6P79MG3J6 = {
    includes = [
      me.determinate
      den.provides.mutual-provider
    ];

    darwin = {
      system.primaryUser = "marae";
    };

    provides.marae = {
      includes = [
        (me.aws {
          secureStore = "keychain";
          extraConfig = ''
            UrlAction: open-url-in-container
            ConfigProfilesUrlAction: open-url-in-container
            UrlExecCommand:
              - /Applications/Firefox.app/Contents/MacOS/firefox
              - "%s"
          '';
        })
        (me.open-url-via-ssh {
          # i only want the sshWithBrowser command available
          enableAutomaticBrowserOverride = false;
        })
      ];
    };
  };

  den.aspects."marae@pcczc65196q9" = {
    includes = [
      me.agentForwardingTmux
    ];

    provides.marae = {
      includes = [
        (me.aws {
          secureStore = "file";
          # if url opening doesn't work, make sure that the GUI services in
          # ubuntu are not started (i.e. when a user is logged in through
          # the gui)
          extraConfig = ''
            UrlAction: open
          '';
        })
        (me.open-url-via-ssh {
          # I want to automatically open in my laptop's browser, instead of
          # having to override the BROWSER variable
          enableAutomaticBrowserOverride = true;
        })
      ];
    };
  };

  den.aspects.marae = den.lib.parametric.exactly {
    includes = [
      den.provides.hostname
      me.darwin-common
      me.home-common
      me.development
      me.axis
    ];
  };
  den.aspects.enniomara = {
    includes = [
      den.provides.hostname
      me.darwin-common
      me.home-common
      me.development
      me.personal
    ];
  };
}
