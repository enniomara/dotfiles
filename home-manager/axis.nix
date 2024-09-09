{ ... }:
{
  programs.zsh.sessionVariables = {
    GOPRIVATE = "gittools.se.axis.com,github.com/axteams-one";
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

  home.file = {
    PublicKey = {
      source = ../ssh_work_key.pub;
      target = ".ssh/id_ed25519.pub";
    };
  };
}
