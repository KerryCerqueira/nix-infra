{
  self,
  ...
}: {
  flake.homeModules.julie = {pkgs, ...}: {
    imports = with self.homeModules; [
      libreoffice
    ];
    programs = {
      home-manager.enable = true;
      firefox.enable = true;
    };
    home = {
      username = "julie";
      homeDirectory = "/home/julie";
      stateVersion = "23.11";
    };
  };
}
