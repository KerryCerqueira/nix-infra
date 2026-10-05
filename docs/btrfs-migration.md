# Filesystem Migration Guide

## Purpose

When making filesystem changes that affect e.g. user filesystems, it's
generally a bad idea to do these things from within a user session that
depends on them. These can either be effected from a live USB
environment or from a root tty session. This document provides
instruction for the latter in a btrfs system.

## Replacing Root Level Mounts and Home Directories

Begin a tty session (usually ctrl-f4) from the display manager and run

```sh
loginctl terminate-user kerry
pgrep -u kerry
```

The second command must print nothing. Then mount the btrfs top level:

```sh
mkdir -p /mnt/top
mount -o subvol=/ /dev/mapper/cryptroot /mnt/top
```

Swap `cryptroot` with whatever label you gave your root partition in
your disk configuration. Now you have a namespace for creating any new
subvolumes you'd want to make:

```sh
btrfs subvolume create /mnt/top/@kerry
btrfs subvolume create /mnt/top/@kerry/.cache
```

Migrate the old data and verify integrity:

```sh
cp -a --reflink=always /mnt/top/@home/kerry/. /mnt/top/@kerry/
rsync -aHAXn --delete --itemize-changes /mnt/top/@home/kerry/ /mnt/top/@kerry/
```

If rsync reports only attribute differences, rerun it without -n. Create
a snapshots subvolume with the right ownership if you need one:

```sh
btrfs subvolume create /mnt/top/@kerry/.snapshots
chmod 0750 /mnt/top/@kerry/.snapshots
```

Note that this is done after verification with rsync, otherwise `--delete` would
wipe it.

After this is done you can deploy your new config as a boot generation:

```sh
git config --global --add safe.directory /path/to/flake
nixos-rebuild boot --flake /path/to/flake#host
git config --global --unset safe.directory /path/to/flake
```

The git config is to allow root to use the untrusted git repository. Then reboot
and verify:

```sh
findmnt /home/kerry
btrfs subvolume show /home/kerry
btrfs subvolume show /home/kerry/.cache
systemctl status <your-audit-unit>
```

## Migrating unprivileged data

These instructions are useful for creating unprivileged subvolumes within say, a
home directory. This workflow would need to be repeated if say, a subvolume were
declared in home to exclude a path from home snapshots.

First, quiesce the user from a root tty as before:

```sh
loginctl terminate-user kerry
pgrep -u kerry
```

Then move the migrating data sideways:

```sh
mv \
    /home/kerry/path/to/data \
    /home/kerry/path/to/data.old
```

Create the subvolume at the real path and declare its ownership.

```sh
btrfs subvolume create /home/kerry/path/to/data
chown kerry:users /home/kerry/path/to/data
chmod 0755 /home/kerry/path/to/data
```

reflink copy the data over:

```sh
cp -a --reflink=always \
    /home/kerry/path/to/data.old/. \
    /home/kerry/path/to/data/
```

Confirm the boundary. Should show distinct device numbers.

```sh
btrfs subvolume show /home/kerry/path/to/data
stat -c '%d %n' /home/kerry /home/kerry/path/to/data
```

Clean up:

```sh
ionice -c3 rm -rf /home/kerry/path/to/data.old
```
