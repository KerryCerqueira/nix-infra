{
  flake.nixosModules.mushu = {config, ...}: {
    boot = {
      initrd.luks.devices = {
        cryptroot.crypttabExtraOpts = [
          "tpm2-device=auto"
          "tpm2-measure-pcr=yes"
        ];
        cryptswap.crypttabExtraOpts = [
          "tpm2-device=auto"
          "tpm2-measure-pcr=yes"
        ];
      };
      zswap.enable = true;
    };
    disko.devices.disk.mushu-nvme = {
      type = "disk";
      device = "/dev/disk/by-id/nvme-Skhynix_BC501_NVMe_128GB_SAK6422T11451B879X56";
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
  };
}
