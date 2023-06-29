{ pkgs, ... }:
{
  home.file = {
    awsSSOConfig = {
      source = ./aws-sso-config.yaml;
      target = ".aws-sso/config.yaml";
    };
  };

  home.packages = [
    pkgs.aws-sso-cli
  ];
}
