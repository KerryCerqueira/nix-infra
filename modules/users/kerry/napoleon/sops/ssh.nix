{
  flake.homeModules."kerry@napoleon" = {
    programs.ssh.matchBlocks."*".identityFile = "~/.ssh/id_ed25519";
  };
}
