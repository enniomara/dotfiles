{ pkgs, ... }:
{
  home.packages = [
    pkgs.tmux
  ];

  xdg.configFile."tmux/tmux.conf".text = pkgs.lib.strings.concatStrings (
    pkgs.lib.strings.intersperse "\n" (
      with pkgs.tmuxPlugins; [
        (builtins.readFile (pkgs.substituteAll {
          src = ../tmux/.tmux.conf;
          sessionizerPath = ../tmux/bin/tmux-sessionizer;
        }))
        # load my custom theme
        (builtins.readFile ../tmux/.tmux-theme.conf)

        # install plugins - last
        ''
          run-shell ${sensible.rtp}
          run-shell ${prefix-highlight.rtp}
          run-shell ${better-mouse-mode.rtp}
          run-shell ${yank.rtp}
          run-shell ${pain-control.rtp}
        ''
      ]
    )
  );
}
