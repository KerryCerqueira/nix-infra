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
ssh-to-age < ssh_host_ed25519_key
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

Add each of these to the appropriate user secrets file.

## Building the System

When booting into the liveUSB environment to deploy a new host, you'll first
need to mount the filesystem as it will be structured in the final deployment.
As a reminder, use

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

After mounting the filesystem, copy the host ssh key to
`/mnt/etc/ssh/ssh_host_ed25519_key` and make it only accessible by root:

```sh
sudo chmod 0600 /etc/age/<hostname>.age
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
- Add empty `extra.lua` to `~/.config/nvim/lua/extra/`
- deploy git config
