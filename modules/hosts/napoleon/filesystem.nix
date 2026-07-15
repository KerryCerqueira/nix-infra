{inputs, ...}: {
  flake.nixosModules.napoleon = {lib, ...}: {
    imports = [inputs.disko.nixosModules.disko];
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
      # zswap.enable = true;
    };
    environment.etc.crypttab.text = let
      volume = name: id: options:
        "${name} "
        + "/dev/disk/by-id/${id}"
        + " - ${lib.concatStringsSep "," options}";
    in
      lib.concatLines [
        (volume
          "cryptgames"
          "nvme-WD_Blue_SN580_1TB_24152N803860-part1"
          [
            "tpm2-device=auto"
            "discard"
            "no-read-workqueue"
            "no-write-workqueue"
            "nofail"
          ])
        (volume
          "cryptbulk-a"
          "ata-Samsung_SSD_860_QVO_1TB_S4PGNG0KC30284Z-part1"
          [
            "tpm2-device=auto"
            "discard"
            "nofail"
          ])
        (volume
          "cryptbulk-b"
          "ata-Samsung_SSD_860_QVO_1TB_S4PGNG0KC30285B-part1"
          [
            "tpm2-device=auto"
            "discard"
            "nofail"
          ])
      ];
    disko.devices.disk = {
      napoleon-os = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-KXG50ZNV512G_TOSHIBA_885S10HGTP7T";
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
              size = "16G";
              content = {
                type = "luks";
                name = "cryptswap";
                settings.allowDiscards = false;
                content.type = "swap";
              };
            };
            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "cryptroot";
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;
                };
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
      napoleon-games = {
        type = "disk";
        device = "/dev/disk/by-id/nvme-WD_Blue_SN580_1TB_24152N803860";
        content = {
          type = "gpt";
          partitions.games = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptgames";
              initrdUnlock = false;
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = ["-f"];
                subvolumes."@steam" = {
                  mountpoint = "/steam/fast";
                  mountOptions = ["compress=zstd:1" "noatime" "nofail"];
                };
              };
            };
          };
        };
      };
      napoleon-bulk-a = {
        type = "disk";
        device = "/dev/disk/by-id/ata-Samsung_SSD_860_QVO_1TB_S4PGNG0KC30284Z";
        content = {
          type = "gpt";
          partitions.bulk = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptbulk-a";
              initrdUnlock = false;
              settings.allowDiscards = true;
            };
          };
        };
      };
      napoleon-bulk-b = {
        type = "disk";
        device = "/dev/disk/by-id/ata-Samsung_SSD_860_QVO_1TB_S4PGNG0KC30285B";
        content = {
          type = "gpt";
          partitions.bulk = {
            size = "100%";
            content = {
              type = "luks";
              name = "cryptbulk-b";
              initrdUnlock = false;
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [
                  "-f"
                  "-d"
                  "single"
                  "-m"
                  "raid1"
                  "/dev/mapper/cryptbulk-a"
                ];
                subvolumes."@steam" = {
                  mountpoint = "/steam/bulk";
                  mountOptions = ["compress=zstd:1" "noatime" "nofail"];
                };
              };
            };
          };
        };
      };
    };
    systemd.tmpfiles.rules = [
      "d /steam/fast 0755 steam users -"
      "d /steam/bulk 0755 steam users -"
    ];
  };
}
