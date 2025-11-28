{pkgs, ...}: let
  # Tab accepts suggestion. Vim doesn't. Make it like Vim.
  makeTabBehaveLikeVimKeybindings = [
    {
      key = "tab";
      command = "-acceptSelectedSuggestion";
      when = "suggestWidgetHasFocusedSuggestion && suggestWidgetVisible && textInputFocus";
    }
    {
      key = "tab";
      command = "selectNextSuggestion";
      when = "suggestWidgetHasFocusedSuggestion && suggestWidgetVisible && textInputFocus";
    }
    {
      key = "shift+tab";
      command = "selectPrevSuggestion";
      when = "suggestWidgetHasFocusedSuggestion && suggestWidgetVisible && textInputFocus";
    }
  ];
in {
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
          # disables highlights when cursor is over a word as it's distracting
          "editor.occurrencesHighlight" = "off";
          "editor.scrollBeyondLastLine" = false; # vscode scrolls the editor all the way up even if the file has ended. Make it more like vim

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
        # let the release extensions be primarily checked. If it doesn't exist
        # there then the latest version will be checked. The first value in the
        # with statement is overshadowed by the second.
        extensions = with pkgs.nix-vscode-extensions.vscode-marketplace;
        with pkgs.nix-vscode-extensions.vscode-marketplace-release; [
          asvetliakov.vscode-neovim
          github.copilot
          github.copilot-chat
          github.vscode-pull-request-github
          zhuangtongfa.material-theme
          golang.go
          jnoortheen.nix-ide
          ms-python.python
          yzhang.markdown-all-in-one
          ms-vscode-remote.remote-ssh
        ];

        keybindings =
          [
            # https://github.com/vscode-neovim/vscode-neovim/issues/2434#issuecomment-2846191267
            {
              key = "ctrl+u";
              command = "vscode-neovim.send";
              args = "<C-u>";
              when = "editorTextFocus && neovim.ctrlKeysNormal.u && neovim.init && neovim.mode != 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
            }
            {
              key = "ctrl+d";
              command = "vscode-neovim.send";
              args = "<C-d>";
              when = "editorTextFocus && neovim.ctrlKeysNormal.d && neovim.init && neovim.mode != 'insert' && editorLangId not in 'neovim.editorLangIdExclusions'";
            }
          ]
          ++ makeTabBehaveLikeVimKeybindings;
      };
    };
  };
}
