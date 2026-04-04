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
    darwin.system.stateVersion = lib.mkDefault 4;
  };

  den.schema.user.classes = lib.mkDefault ["homeManager"];

  den.hosts.aarch64-darwin.M-K6P79MG3J6.users.marae = {};
  den.hosts.aarch64-darwin.M-K6P79MG3J6.users.enniomara = {};

  den.aspects.marae = {
    includes = [
      den.provides.hostname
      me.darwin-common
      me.development
    ];
  };
  den.aspects.enniomara = {
    includes = [
      den.provides.hostname
      me.darwin-common
      me.development
    ];
  };
}
