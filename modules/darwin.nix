{me, ...}: {
  me.darwin-common = {
    includes = [
      me.hammerspoon
      me.karabiner
      me.betterTouchTool
      me.macContainers
    ];

    darwin = {
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
