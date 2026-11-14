{
  flake.nixosModules.kerry-claudius = {config, ...}: let
    kerry = config.users.users.kerry;
  in {
    sops.secrets."kerry/ageKeys" = {
      path = "${kerry.home}/.config/sops/age/keys.txt";
      owner = "kerry";
      mode = "0400";
    };
  };
  deployments.nixosModules.kerry-claudius = ["claudius"];
}
