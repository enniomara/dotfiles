{
  me.fish = {
    darwin = {pkgs, ...}: {
      programs.fish.enable = true;
      environment.shells = [pkgs.fish];
    };
    homeManager.programs.fish = {
      enable = true;
      shellInit =
        # fish
        ''
          # Configure less to behave consistently across environments
          # -M, prompt more in the screen
          # -q quiet, do not ring bell
          # -i ignore case
          # -R color output
          set -g -x LESS 'MqiR'
          set -g -x MANPAGER 'nvim +Man!' # instead of less
          set -g -x EDITOR 'nvim'
          set -g fish_greeting # disable greeting
        '';
      shellInitLast =
        # fish
        ''
          function fish_user_key_bindings
              # Execute this once per mode that emacs bindings should be used in
              fish_default_key_bindings -M insert

              # Then execute the vi-bindings so they take precedence when there's a conflict.
              # Without --no-erase fish_vi_key_bindings will default to
              # resetting all bindings.
              # The argument specifies the initial mode (insert, "default" or visual).
              fish_vi_key_bindings --no-erase insert
          end
        '';

      shellAliases = {
        g = "git";
        gs = "git status";
        ga = "git add";
        gco = "git checkout";
        "gc!" = "git commit --verbose --amend";
        gc = "git commit --verbose";
        glog = "git log --oneline --decorate --graph";
        ccat = "cat";
        cat = "bat";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        la = "ls -lAh";
        k = "kubectl";
      };
    };
  };
}
