{self, ...}: {
  flake.homeModules.shell = {
    imports = with self.homeModules; [
      shell-utils
      fish
      zsh
    ];
  };
}
