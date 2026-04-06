{
  den,
  me,
  ...
}: {
  den = {
    hosts.aarch64-darwin.M-K6P79MG3J6.users.marae = {};
    hosts.aarch64-darwin.M-K6P79MG3J6.users.enniomara = {};
    hosts.x86_64-darwin.Ennios-MacBook-Pro.users.enniomara = {};
    homes.x86_64-linux."marae@pcczc65196q9" = {};
    homes.x86_64-linux."vagrant@linux-box" = {};

    aspects.M-K6P79MG3J6 = {
      includes = [
        me.determinate
        den.provides.mutual-provider
      ];

      provides.marae = {
        includes = [
          den.provides.primary-user
          (me.aws {
            secureStore = "keychain";
            extraConfig = ''
              UrlAction: open-url-in-container
              ConfigProfilesUrlAction: open-url-in-container
              UrlExecCommand:
                - /Applications/Firefox.app/Contents/MacOS/firefox
                - "%s"
            '';
          })
          (me.open-url-via-ssh {
            # i only want the sshWithBrowser command available
            enableAutomaticBrowserOverride = false;
          })
        ];
      };
    };

    aspects."marae@pcczc65196q9" = {
      includes = [
        me.agentForwardingTmux
      ];

      provides.marae = {
        includes = [
          (me.aws {
            secureStore = "file";
            # if url opening doesn't work, make sure that the GUI services in
            # ubuntu are not started (i.e. when a user is logged in through
            # the gui)
            extraConfig = ''
              UrlAction: open
            '';
          })
          (me.open-url-via-ssh {
            # I want to automatically open in my laptop's browser, instead of
            # having to override the BROWSER variable
            enableAutomaticBrowserOverride = true;
          })
        ];
      };
    };
  };
}
