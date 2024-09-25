{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.services.aws-sso;
in {
  options.services.aws-sso = {
    enable = lib.mkEnableOption "Enable aws-sso-cli";

    secureStore = lib.mkOption {
      type = lib.types.enum ["file" "keychain"];
      description = "What secure store will be used";
    };

    extraConfig = lib.mkOption {
      type = lib.types.str;
      description = "Extra config to pass to aws-sso-cli config";
    };
  };

  config = lib.mkIf cfg.enable {
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
                SecureStore: ${cfg.secureStore}
              ''
              cfg.extraConfig
            ]
          );
      };
    };

    home.packages = [
      pkgs.aws-sso-cli
    ];
  };
}
