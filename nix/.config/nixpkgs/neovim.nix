{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    plugins = [
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        plugins: with plugins; [
          astro
          bash
          comment
          css
          diff
          dockerfile
          git_rebase
          go
          gomod
          html
          javascript
          jq
          json
          jsonc
          latex
          lua
          make
          markdown
          nix
          python
          regex
          ruby
          tsx
          typescript
          yaml
        ]
      ))
      # pkgs.vimPlugins.nvim-treesitter.withAllGrammars
      pkgs.vimPlugins.packer-nvim
    ];
  };
}
