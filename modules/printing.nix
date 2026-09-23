{
  flake.nixosModules.printing.services.printing.enable = true;
  deployments.nixosModules.printing = [
    "claudius"
    "mushu"
    "panza"
  ];
}
