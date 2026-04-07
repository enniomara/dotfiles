{
  me.languages._.node = {
    homeManager = {pkgs, ...}: {
      programs.mise = {
        enable = true;
        globalConfig = {
          tools = {
            nodejs = "22";
          };
        };
      };

      programs.neovim = {
        extraPackages = with pkgs; [
          prettierd # ts/html/css etc
          nodePackages.prettier
          vscode-langservers-extracted # eslint
          nodePackages.typescript-language-server
        ];
      };

      programs.vscode = {
        profiles = {
          default = {
            extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
              ms-playwright.playwright
              orta.vscode-jest
            ];
          };
        };
      };
    };
  };
}
