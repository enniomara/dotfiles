{ ... }:
{
  home.file = {
    PublicKey = {
      source = ../../../ssh_personal_key.pub;
      target = ".ssh/id_ed25519.pub";
    };
  };
}
