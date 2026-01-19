{
  flake.homeModules."kerry@sigmund" = {config, ...}: {
    sops = {
      defaultSopsFile = ./secrets.yaml;
      defaultSopsFormat = "yaml";
      age.keyFile = "${config.home.homeDirectory}/.config/sops/age/kerry_sigmund.age";
    };
  };
}
