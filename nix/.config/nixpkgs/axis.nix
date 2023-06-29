{ ... }:
{
  imports = [
    ./work/aws.nix # aws sso configuration
  ];

  programs.zsh.sessionVariables = {
    GOPRIVATE = "gittools.se.axis.com";
  };

  programs.git = {
    userName = "Ennio Mara";
    userEmail = "marae@axis.com";
    extraConfig = {
      url = {
        "ssh://marae@gittools.se.axis.com:29418/" = {
          insteadOf = "https://gittools.se.axis.com/gerrit/a/";
        };
      };
    };
  };
}
