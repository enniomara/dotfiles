{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.nixpkgs-unstable.vscode;
    profiles = {
      nix = {};
      default = {
        enableUpdateCheck = false;
        userSettings = {
          "workbench.colorTheme" = "One Dark Pro";
          "editor.fontFamily" = "Iosevka NFM, Menlo, Monaco, 'Courier New', monospace";
          "editor.fontSize" = 16;

          # copilot
          "github.copilot.chat.codesearch.enabled" = true;
          "github.copilot.chat.agent.thinkingTool" = true;
          "github.copilot.nextEditSuggestions.enabled" = true;
          "chat.agent.enabled" = true;

          "extensions.experimental.affinity" = {
            "asvetliakov.vscode-neovim" = 1;
          };
          "vscode-neovim.ctrlKeysForNormalMode" = [
            # default keys
            "a"
            "b"
            "c"
            "d"
            "e"
            "f"
            "h"
            "i"
            "j"
            "k"
            "l"
            "m"
            "o"
            "r"
            "t"
            "u"
            "v"
            "w"
            "x"
            "y"
            "z"
            "/"
            "]"
            "right"
            "left"
            "up"
            "down"
            "backspace"
            "delete"
            # I use ctrl - s to save
            "s"
          ];
        };
        extensions = with pkgs.nix-vscode-extensions.vscode-marketplace; [
          asvetliakov.vscode-neovim
          github.copilot
          github.copilot-chat
          github.vscode-pull-request-github
          zhuangtongfa.material-theme
          golang.go
          jnoortheen.nix-ide
          ms-python.python
        ];
      };
    };
  };
}
