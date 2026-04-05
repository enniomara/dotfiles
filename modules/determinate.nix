{inputs, ...}: {
  me.determinate = {
    darwin = {
      imports = [
        inputs.determinate.darwinModules.default
      ];

      determinateNix = {
        enable = true;
      };
    };
  };
}
