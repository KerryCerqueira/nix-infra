{
  flake.nixosModules.napoleon = {
    pkgs,
    lib,
    ...
  }: {
    boot.plymouth = {
      theme = "colorful_loop";
      themePackages = lib.mkDefault (with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["colorful_loop"];
        })
      ]);
    };
  };
}
