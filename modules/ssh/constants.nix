{...}: {
  flake.lib.constants = {
    publicKeys = {
      "kerry@claudius" = builtins.readFile ./public-keys/kerry_claudius.pub;
      "kerry@muncher" = builtins.readFile ./public-keys/kerry_muncher.pub;
      "kerry@napoleon" = builtins.readFile ./public-keys/kerry_napoleon.pub;
      "kerry@panza" = builtins.readFile ./public-keys/kerry_panza.pub;
      "kerry@sebastiao" = builtins.readFile ./public-keys/kerry_sebastiao.pub;
      "root@claudius" = builtins.readFile ./public-keys/root_claudius.pub;
      "root@napoleon" = builtins.readFile ./public-keys/root_napoleon.pub;
      "root@sebastiao" = builtins.readFile ./public-keys/root_sebastiao.pub;
    };
  };
}
