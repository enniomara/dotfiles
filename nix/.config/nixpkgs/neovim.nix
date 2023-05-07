{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = [
      # do not attempt to manage treesitter parsers through nix. Lazy.nvim
      # takes ownership of packpath, so nix's configuration method does not
      # work, as it puts the parsers in the packpath
      # https://github.com/folke/lazy.nvim/issues/402
      # https://github.com/folke/lazy.nvim/issues/516
      pkgs.vimPlugins.lazy-nvim
    ];
  };
}
