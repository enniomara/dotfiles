{ ... }:
{
  programs.zsh.shellAliases = {
    # so that the target environment knows that URLs should be sent to the ssh
    # server
    sshExportBrowser = "export BROWSER=\"${./client.sh} localhost 54821\"";

    # exports an alias that wraps around SSH. It starts a server which accepts
    # connections from the ssh client. Used to open URLs in the SSH client
    # instead of the SSH server's browser.
    sshWithBrowser = "function() { ${./ssh-server.sh} \"$@\" }";
  };
}
