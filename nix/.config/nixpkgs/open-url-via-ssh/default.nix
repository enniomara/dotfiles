{ lib, config, ... }:
let
  cfg = config.services.open-url-via-ssh; in
{
  options.services.open-url-via-ssh = {
    enable = lib.mkEnableOption "Enable support for openin URLs in SSH client's browser, instead of the server's.";

    automaticBrowserOverride = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the BROWSER variable will be automatically overriden to point to the client";
    };
  };

  config = lib.mkIf cfg.enable {
    programs.zsh.shellAliases = {
      # so that the target environment knows that URLs should be sent to the ssh
      # server
      sshExportBrowser = "export BROWSER=\"${./client.sh} localhost 54821\"";

      # exports an alias that wraps around SSH. It starts a server which accepts
      # connections from the ssh client. Used to open URLs in the SSH client
      # instead of the SSH server's browser.
      sshWithBrowser = "function() { ${./ssh-server.sh} \"${./server.py}\" localhost 54821 \"$@\" }";
    };

    programs.zsh.sessionVariables = lib.mkIf cfg.automaticBrowserOverride {
      BROWSER = "${./client.sh} localhost 54821";
    };
  };
}
