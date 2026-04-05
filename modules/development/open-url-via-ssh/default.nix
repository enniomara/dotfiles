{
  # Enable support for opening URLs in SSH client's browser, instead of the server's.
  me.open-url-via-ssh = {
    # Whether the BROWSER variable will be automatically overriden to point to the client
    enableAutomaticBrowserOverride,
  }: {
    homeManager = {
      pkgs,
      lib,
      ...
    }: {
      programs.zsh.shellAliases = {
        # exports an alias that wraps around SSH. It starts a server which accepts
        # connections from the ssh client. Used to open URLs in the SSH client
        # instead of the SSH server's browser.
        sshWithBrowser = "function() { ${./ssh-server.sh} \"${./server.py}\" localhost 54821 \"$@\" }";
      };

      programs.zsh.sessionVariables = lib.mkIf enableAutomaticBrowserOverride {
        BROWSER = "${./client.sh} localhost 54821";
      };
    };
  };
}
