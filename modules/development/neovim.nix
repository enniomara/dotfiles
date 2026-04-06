{...}: {
  me.neovim.homeManager = {pkgs, ...}: {
    programs.neovim = {
      enable = true;
      package = pkgs.nixpkgs-unstable.neovim-unwrapped;
      plugins = [
        (pkgs.vimPlugins.nvim-treesitter.withPlugins (
          plugins:
            with plugins; [
              astro
              bash
              c
              cpp
              comment
              css
              fish
              diff
              dockerfile
              elixir
              git_rebase
              go
              gomod
              graphql
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
              terraform
              typst
              yaml
              xml
              zig
            ]
        ))

        # do not attempt to manage treesitter parsers through nix. Lazy.nvim
        # takes ownership of packpath, so nix's configuration method does not
        # work, as it puts the parsers in the packpath
        # https://github.com/folke/lazy.nvim/issues/402
        # https://github.com/folke/lazy.nvim/issues/516
        pkgs.vimPlugins.lazy-nvim
      ];
      extraPackages = with pkgs; [
        # bash
        nodePackages.bash-language-server
        shellcheck # used by bashls
        shfmt # used by bashls

        # elixir
        elixir
        elixir-ls

        pkgs.nixpkgs-unstable.nixd
        alejandra
        clojure-lsp

        lua-language-server

        # sql
        sqlfluff

        # rust
        rust-analyzer

        # yaml
        yaml-language-server
        python3Packages.cfn-lint
        yamllint
      ];
    };
  };
}
