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
    homeManager.home.stateVersion = lib.mkDefault "23.05";

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

  den.aspects.marae = {
    includes = [
      den.provides.hostname
      me.darwin-common
      me.home-common
      me.development
      me.axis
      me.languages._.go
      me.languages._.node
      me.languages._.python
    ];
  };
  den.aspects.enniomara = {
    includes = [
      den.provides.hostname
      me.darwin-common
      me.home-common
      me.development
      me.personal
      me.languages._.node
    ];
  };
}
