{
  inputs,
  den,
  lib,
  me,
  ...
}: {
  imports = [
    inputs.den.flakeModule
    (inputs.den.namespace "me" true)
  ];

  den.default = {
    homeManager.home.stateVersion = lib.mkDefault "25.05";

    darwin = {
      system.stateVersion = lib.mkDefault 4;
    };

    includes = [
      den.provides.define-user
      me.nix
      me.nix-registries
    ];
  };

  den.schema.user.classes = lib.mkDefault ["homeManager"];
  den.ctx.user.includes = [den._.mutual-provider];
}
