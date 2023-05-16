{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "marae";
  # home.homeDirectory = "/Users/marae";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.11";

  # from https://discourse.nixos.org/t/nvd-simple-nix-nixos-version-diff-tool/12397/31
  home.activation.report-changes = config.lib.dag.entryAnywhere ''
    echo "++++* System Changes ++++++"
    nix store diff-closures $(ls -dv /nix/var/nix/profiles/system-*-link | tail -2)
  '';

  imports = [
    ./shell.nix
    ./tmux.nix
    ./neovim.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.configFile."kitty/kitty.conf".text = pkgs.lib.strings.concatStrings [
    (builtins.readFile ../../../kitty/.config/kitty/kitty.conf)
    (builtins.readFile ../../../kitty/.config/kitty/tokyo-night-kitty.conf)
  ];

  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        line-numbers = "true";
        features = "decorations";
        decorations = {
          commit-decoration-style = "yellow ol";
        };
      };
    };
  };

  home.packages = [
    pkgs.htop

    # pkgs.neovim

    # cli
    pkgs.autojump
    pkgs.fd
    pkgs.jq
    pkgs.ripgrep
    pkgs.tldr
    pkgs.fzf
    pkgs.asdf-vm

    pkgs.gh
    pkgs.lazygit
    pkgs.lazydocker
  ];
}
