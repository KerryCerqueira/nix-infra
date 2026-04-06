{
  flake.homeModules."kerry@claudius" = {config, ...}: {
    programs.ssh.matchBlocks."*".identityFile = "~/.ssh/id_ed25519";
    sops.secrets = {
      "ssh/identity/private" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519";
      };
      "ssh/identity/public" = {
        path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      };
    };
  };
}
