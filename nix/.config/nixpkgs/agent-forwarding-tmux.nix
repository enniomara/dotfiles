{ pkgs, ... }:
{
  home.file.sshRc = {
    target = ".ssh/rc";
    text = ''
      #!/bin/bash

      # Fix SSH auth socket location so agent forwarding works with tmux
      if [ ! -S ~/.ssh/ssh_auth_sock ] && [ -S "$SSH_AUTH_SOCK" ]; then
        ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
      fi
    '';
  };

  # contains the public key of my work SSH key
  home.file = {
    PublicKey = {
      target = ".ssh/id_ed25519.pub";
      source = ../../../ssh_work_key.pub;
    };
  };

  xdg.configFile."tmux/tmux.conf".text = pkgs.lib.strings.concatStrings (
    [
      # The lines here are expected to be merged with the rest of the tmux
      # configuration. THey are used to get SSH Agent forwarding in Tmux to
      # work. We need to pin the socket so that tmux can find it when the SSH
      # session is restarted.
      # https://blog.testdouble.com/posts/2016-11-18-reconciling-tmux-and-ssh-agent-forwarding/
      ''
        # Remove SSH_AUTH_SOCK to disable tmux automatically resetting the variable

        set-environment -g 'SSH_AUTH_SOCK' ~/.ssh/ssh_auth_sock
        set -g update-environment "DISPLAY SSH_ASKPASS SSH_AGENT_PID \
                                    SSH_CONNECTION WINDOWID XAUTHORITY"

        # Use a symlink to look up SSH authentication
        setenv -g SSH_AUTH_SOCK $HOME/.ssh/ssh_auth_sock
      ''
    ]
  );
}
