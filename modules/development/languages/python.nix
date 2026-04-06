{
  me.languages._.python = {
    homeManager = {pkgs, ...}: {
      home.packages = [
        pkgs.uv
      ];

      programs.mise = {
        globalConfig = {
          tools = {
            python = "3.12";
          };
        };
      };

      programs.neovim = {
        extraPackages = with pkgs; [
          pyright
          ruff
        ];
      };

      programs.vscode = {
        profiles = {
          default = {
            extensions = with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
              ms-python.python
            ];
          };
        };
      };
    };
  };
}
