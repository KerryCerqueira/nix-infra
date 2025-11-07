# Notes on Deployment
## Key Generation

Each host needs an age private key to decrypt its system secrets, and a ssh key.
Generate one with

```sh
nix-shell -p age --run "age-keygen -o <hostname>.age"
ssh-keygen -t ed25519 -C "<hostname>"
```

I'm running with the convention of placing these system level keys in
`/etc/age/` and hardcoding the path into the system config as the sops default
decryption key. Different paths can be specified by setting the environment
variable `SOPS_AGE_KEY_FILE`. The super user must place the keyfile in
`/etc/age`, and be sure to set the correct permissions on the keyfile with

```sh
sudo chmod 0600 /etc/age/<hostname>.age
```

Generate a key for user secrets in the same way. The user key unlike the system
key is deployed by sops itself during the boot process by encrypting it in the
system `secrets.yaml` and deploying it to `/home/<user>/.config/sops/age`. Make
sure to make the user the owner of the keyfile for home-manager to pick it up.

You'll then need to add the age keys to the sops policy file. e.g.

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

If you want to add user secrets before deploying the user encryption key with
a rebuild, you'll need to do it yourself the first time manually, or your first
rebuild will need to be invoked with SOPS_AGE_KEYFILE set. Move the user key to
~/.config/sops/age/keys.txt if you want to do the former.

If the user needs a declarative login password, its hash can be deployed by
sops. To get the hash save the password into a file (say `pwd.txt`) and run

```sh
cat pwd.txt | mkpasswd -s
```

If the user needs a declarative syncthing ID, you can generate a keypair with

```sh
syncthing -generate=myconfig
```

You can then find the keypair in `./myconfig/key.pem` etc.

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

