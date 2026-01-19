{
  flake.homeModules."kerry@sigmund" = {config, ...}: {
    programs.ssh.matchBlocks."*".identityFile = "~/.ssh/id_ed25519";
    sops = {
      secrets = {
        "ssh/identity/public" = {
          path = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
        };
        "ssh/identity/private" = {
          path = "${config.home.homeDirectory}/.ssh/id_ed25519";
        };
      };
    };
  };
}
