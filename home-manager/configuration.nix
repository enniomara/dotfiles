{
  config,
  pkgs,
  ...
}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages =
  #   [ pkgs.vim
  #   ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # let nix darwin manage nix
  nix.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh.enable = true; # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  homebrew = {
    enable = true;
    casks = [
      "bettertouchtool"
      "hammerspoon"
      "karabiner-elements"

      "ghostty"
      "spotify"
      "obsidian"
      "telegram"
      "ticktick"
      "monitorcontrol" # allows to control brigtness of external monitor
      "raycast"
      "tailscale"
    ];
  };

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.iosevka
  ];

  system.activationScripts.postUserActivation.text = ''
    # Following line should allow us to avoid a logout/login cycle
    /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
  '';
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
}
