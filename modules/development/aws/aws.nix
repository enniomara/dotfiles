{
  me.aws = {
    # what secure store to use (file, keychain)
    secureStore,
    # any extra config added to the aws-sso config file
    extraConfig,
  }: {
    homeManager = {pkgs, ...}: {
      home.file = {
        awsSSOConfig = {
          # source = ./aws-sso-config.yaml;
          target = ".aws-sso/config.yaml";
          text =
            pkgs.lib.strings.concatStrings
            (
              pkgs.lib.strings.intersperse "\n" [
                (builtins.readFile ./aws-sso-config.yaml)
                ''
                  SecureStore: ${secureStore}
                ''
                extraConfig
              ]
            );
        };
      };

      home.packages = with pkgs; [
        awscli2
        aws-sso-cli
      ];
    };
  };
}
