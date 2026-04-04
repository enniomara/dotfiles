{pkgs, ...}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  # environment.systemPackages =
  #   [ pkgs.vim
  #   ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # this configuration makes nixpkgs use the system configuration (configured
  # by the flake), instead of using the configuration from GH. Not what I want.
  # I want 'nixpkgs#<prog>' to always fetch the latest nixpkgs version. For
  # pinned version i usually use 'home#<prog>'.
  nixpkgs.flake.setFlakeRegistry = false;
  nixpkgs.flake.setNixPath = false;

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

  fonts.packages = [
    pkgs.nerd-fonts.fira-code
  ];

  security.pam.services.sudo_local = {
    # Allow touchid to authorize sudo
    enable = true;
    reattach = true;
    touchIdAuth = true;
  };
}
