{
  den,
  me,
  ...
}: {
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
