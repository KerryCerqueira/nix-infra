# Notes on Deployment
## Key Generation

Each host needs a host ssh key to establish its cryptographic identity to
clients. This key is also what will be used to decrypt system level secrets with
sops-nix. Each user also needs a ssh key to perform ssh connections and decrypt
user level secrets.

```sh
ssh-keygen -t ed25519 -C "<hostname>" -f ssh_host_ed25519_key
ssh-keygen -t ed25519 -C "<user>@<hostname>" -f id_ed25519

```

The user key unlike the system key is deployed by sops itself during the boot
process by encrypting it in the system `secrets.yaml` and deploying it to
`/home/<user>/.config/sops/age`. Make sure to make the user the owner of the
keyfile for home-manager to pick it up when declaring `sops.secrets`.

You'll then need to produce age targets from the ssh keys you used earlier to
add them to the sops.yaml file, e.g.

```{yaml}
age_keys:
  # System-level secrets on <host>
  - &host age1234abcd
  # User's secrets on sigmund
  - &user_host age5678efgh
creation_rules:
  - path_regex: ^nixos/hosts/<host>/_hardware/secrets.yaml$
    key_groups:
      - age:
        - *host
  - path_regex: ^nixos/hosts/<host>/_home/<user>/secrets.yaml$
    key_groups:
      - age:
        - *user_host
        - *user_master
```

To do that you can use `ssh-to-age`, available in nixpkgs, by e.g.

```sh
ssh-to-age < ssh_host_ed25519_key.pub
```

You'll also need an age key for the user to run e.g. sops edit:

```{sh}
age-keygen -o keys.txt
```

If the user needs a declarative login password, its hash can be deployed by
sops. To get the hash save the password into a file (say `pwd.txt`) and run

```sh
cat pwd.txt | mkpasswd -s
```

If the user needs a declarative syncthing ID, you can generate a keypair with

```sh
syncthing generate --home=./myconfig
```

You can then find the keypair in `./myconfig/key.pem` etc.

You'll also probably need API keys for various services, generated through some
web interface. Here's a list of the ones I use:

- Tavily
- Huggingface
- OpenAI
- github access tokens

Add each of these to the appropriate user secrets file.

## Building the System

### Traditional `filesystems` options
When booting into the liveUSB environment to deploy a new host, you'll first need
to format (e.g. with `gparted`) and mount the filesystem as it will be structured
in the final deployment. As a reminder, use

```sh
lsblk -f
```

to see which devices/labels are available, and then you can mount them like so:

```sh
# mounting by label
mount /dev/disk/by-label/NIXOS_ROOT /mnt/path
# mounting by UUID
mount /dev/disk/by-uuid/<UUID> /mnt/path
# mount by device
mount /dev/sda2 /mnt/path
```

These mounts need to match your filesystem declaration relative to `/mnt`.

After mounting the volumes, copy the host ssh key to
`/mnt/etc/ssh/ssh_host_ed25519_key` and make it only accessible by root:

```sh
sudo chmod 0600 /etc/ssh/ssh_host_ed25519_key
```

Then you can install your system with

```{sh}
sudo nixos-install  \
  NIX_CONFIG="extra-experimental-features = pipe-operators nix-command flakes" \
  --flake "github:kerrycerqueira/nix-infra#<your-host>
```

### With `disko`

The formatting and mounting step simplifies to

```{sh}
sudo nix \
  NIX_CONFIG="extra-experimental-features = pipe-operators nix-command flakes" \
  run github:nix-community/disko/latest -- \
  --mode destroy,format,mount \
  --flake github:KerryCerqueira/nix-infra#<your-host>
```

If you specified disk encryption, this is when your encryption passwords will be
specified. If you're encrypting multiple volumes and want them to unlocked by the
same password challenge, setting the same password for each volume will enforce
this. Then deploy your SSH key and install as before.

## Post Install Boot Hardening

To have booted into a nixOS liveUSB, you would've had to disable secure boot. To
make use of it again follow these steps.

First, make sure secure boot is disabled and set a BIOS administrator password.
This input should be present:
```{nix}
lanzaboote = {
  url = "github:nix-community/lanzaboote";
  inputs.nixpkgs.follows = "nixpkgs";
};
```

And these options should be included in a nixOS configuration:

```{nix}
boot = {
  loader.systemd-boot.enable = lib.mkForce false;
  lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };
};
```

Next enrol your secure boot keys, invoke a system rebuild so
lanzaboot can sign the boot chain, and verify that everything got signed:

```{sh}
nix shell nixpkgs#sbctl
sbctl create-keys
sudo nixos-rebuild switch ./path/to/your-flake#your-host
sbctl verify
```

The bare `/boot/EFI/nixos/kernel-*.efi` showing unsigned is expected, but
everything else should show up as signed.

Next you should probably enrol microsoft keys so proprietary firmware (e.g.
thunderbolt) signed by microsoft distributed keys is trusted:

```{sh}
sudo sbctl enroll-keys --microsoft
```

This may fail due to filesystem protections on the keys stored in the firmware,
ex. `File is immutable: …/KEK-…`. In this event just brute force the issue by running this command against each path mentioned in the error:

```{sh}
sudo nix shell nixpkgs#e2fsprogs --command chattr -i /path/to/key`
```

Until the `sbctl` command above works. At this point `bootctl status` should
report secure boot in user mode. Reboot into the BIOS, and switch secure boot into
deployed mode. Verify that everything's working with another `bootctl status`.

### Set up disk decryption via TPM

In the event that your system uses disk decryption and is equipped with a TPM, you
may use it to automatically decrypt your disks upon a successful trusted boot.
First, it may be a good idea to perform a firmware update with `fwupd` before this
procedure as firmware changes disturb the secure boot chain. Due to the PCR level
chosen, TPM enrolment must be done *after* enrolling secure boot keys:

```{sh}
sudo systemd-cryptenroll \
    --tpm2-device=auto \
    --tpm2-pcrs=7 \
    /dev/disk/by-partlabel/your-disk
```

This will prompt you for the disk passphrase. Do this for every encrypted volume.
Verify with `sudo systemd-cryptenroll /dev/disk/by-partlabel/your-disk`.

### TMP/BIOS Resealing

BIOS and firmware updates may invalidate the TPM measurement. This command run
against encrypted volumes reseals the TPM:

```{sh}
sudo systemd-cryptenroll \
    --wipe-slot=tpm2 \
    /dev/disk/by-partlabel/your-disk
sudo systemd-cryptenroll \
    --tpm2-device=auto \
    --tpm2-pcrs=7 \
    /dev/disk/by-partlabel/your-disk
```

## Non-declarative setup
- Set gnome keyboard shortcuts, interface settings, and add google and
microsoft accounts
- Configure gnome extensions
- Set keepassxc interface settings and initialize ssh-agent
- Log into firefox sync, log browser into github, gmail, and outlook
- Log into thunderbird accounts
- Configure keepassxc firefox extension
- run `gh auth login`
- Set background image and profile image
- Log into steam
- deploy git config
- Enrol biometric data, e.g. fingerprints
