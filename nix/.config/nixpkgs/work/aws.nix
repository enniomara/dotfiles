{ pkgs, lib, config, ... }:
let
  cfg = config.services.aws-sso; in
{
  options.services.aws-sso.secureStore = lib.mkOption {
    type = lib.types.enum [ "file" "keychain" ];
    description = "What secure store will be used";
  };

  config = {
    home.file = {
      awsSSOConfig = {
        # source = ./aws-sso-config.yaml;
        target = ".aws-sso/config.yaml";
        text = pkgs.lib.strings.concatStrings
          (
            pkgs.lib.strings.intersperse "\n" ([
              (builtins.readFile ./aws-sso-config.yaml)
              ''
                SecureStore: ${cfg.secureStore}
              ''
            ])
          );
      };
    };

    home.packages = [
      pkgs.aws-sso-cli
    ];
  };
}
