{inputs, ...}: {
  flake.nixosModules.sebastiao = {...}: {
    imports = [inputs.disko.nixosModules.disko];
    boot.initrd.luks.devices.cryptroot = {
      crypttabExtraOpts = [
        "tpm2-device=auto"
        "tpm2-measure-pcr=yes"
      ];
    };
    disko.devices.disk.sebastiao-nvme = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-UMIS_RPETJ1T24MMW1QDQ_SS1D71552X1RC5C209P9";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["umask=0077"];
            };
          };
          swap = {
            size = "63032M";
            content = {
              type = "luks";
              name = "cryptswap";
              settings.allowDiscards = false;
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
          };
          root = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptroot";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes = {
                  "@" = {
                    mountpoint = "/";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@nix" = {
                    mountpoint = "/nix";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@var" = {
                    mountpoint = "/var";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = ["compress=zstd" "noatime"];
                  };
                };
              };
            };
          };
        };
      };
    };
    zramSwap = {
      enable = true;
      algorithm = "zstd";
      memoryPercent = 100;
    };
  };
}
