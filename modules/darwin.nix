{me, ...}: {
  me.darwin-common = {
    includes = [
      me.hammerspoon
      me.karabiner
      me.betterTouchTool
      me.macContainers
    ];

    darwin = {
      nix.extraOptions = ''
        experimental-features = nix-command flakes
      '';

      homebrew = {
        enable = true;
        casks = [
          "spotify"
          "obsidian"
          "telegram"
          "ticktick"
          "monitorcontrol" # allows to control brigtness of external monitor
          "raycast"
          "tailscale"
        ];
      };

      security.pam.services.sudo_local = {
        # Allow touchid to authorize sudo
        enable = true;
        reattach = true;
        touchIdAuth = true;
      };

      system = {
        defaults = {
          NSGlobalDomain = {
            InitialKeyRepeat = 15; # * 15ms
            KeyRepeat = 2; # * 15ms
            ApplePressAndHoldEnabled = false; # Turn off accent menu on hold
            AppleInterfaceStyleSwitchesAutomatically = true; # auto dark mode
          };

          dock = {
            autohide = false;
            appswitcher-all-displays = true;
            tilesize = 33;
          };

          finder = {
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true; # by default finder hides files starting with . (dot)
            ShowPathbar = true; # show the breadcrunb
          };

          trackpad = {
            Clicking = true; # tap to click
            FirstClickThreshold = 0; # light clicking, default is medium
          };
        };

        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };
      };
    };
  };
}
