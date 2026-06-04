# my nix files (for nixos-minimal)

This comes with a configured verison of sway and kitty as a terminal

more epic configs at https://github.com/samurainen2/voidfiles

**install**

```bash
rm -f /etc/nixos/configuration.nix
cp ~/Nix-Files/nixos/configuration.nix /etc/nixos/ # This assumes you have cloned it in ~/ or $HOME
cp ~/Nix-Files/nixos/pkgs.nix /etc/nixos/ # this file contains your persistent packages
sudo nixos-rebuild switch # rebuild and apply changes
```

# install nixos liveISO

**note this is how i install nixos minimal**

1.0: checking disks

```bash
lsblk
```

It should return somthing like this. We are gonna use ``nvme0n2`` in this example

```
NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINTS
nvme0n1     259:0    0  512G  0 disk 
├─nvme0n1p1 259:1    0   512M  0 part /boot
└─nvme0n1p2 259:2    0  511G  0 part /

nvme0n2     259:3    0    1T  0 disk 
└─nvme0n2p1 259:4    0    1T  0 part
```

1.1: creating partitions

use ``cfdisk`` get a nice TUI where you can create your partitions
you will need to create 3 partitions

p1 size ~1 - 2G this is gonna be our ``Boot`` partition, in [ Type ] choose ``EFI system``
p2 size ~2 - 10G this is gonna be our ``swap`` partition, in [ Type ] choose ``Linux Swap``
p3 size how much you like this will be our ``/root`` partition (leave it on ``Linux file system``)

**REMEMBER SELECT [ WRITE ] BEFORE CLOSING**

1.2: Formating the partitons

```bash
sudo mkfs.fat -F 32 /dev/nvme0n2p1
sudo mkfs.ext4 /dev/nvme0n2p3
sudo mkswap /dev/nvme0n2p2
```

1.3: Mounting partitions

  1.3.1: Create Mount locations

  ```bash
  sudo mkdir -p /mnt/fs
  sudo mkdir -p /mnt/fs/boot
  ```

  1.3.2: Mount partitions

  ```bash
  sudo mount /dev/nvme0n2p3 /mnt/fs
  sudo mount /dev/nvme0n2p1 /mnt/fs/boot
  ```

  1.3.3: Enable swap

  ```bash
  sudo swapon /dev/nvme0n2p2
  ```

1.4: Create ``configuration.nix``

```bash
sudo nixos-generate-config
```

1.5: Install my nix config(s)

  1.5.1: Install git

  ```bash
  sudo vim /etc/nixos/configuration.nix
  ```

  find enviroment.systemPackages and add ``git``

  rebuild

  ```bash
  sudo nixos-rebuild switch
  ```

  test if it installed correctly
  
  ```bash
  git --version
  ```
  1.5.2: Clone this repo

  ```bash
  git clone --depth 1 https://github.com/syntaxMORG0/Nix-Files.git
  cd ~/Nix-Files
  ```

  1.5.3: Change ownership

  ```bash
  sudo chown root ./nixos
  ```

  1.5.4: Remove default ``configuration.nix``

  **NOTE DO NOT REMOVE ``hardware-configruration.nix``!!**
  
  ```bash
  sudo rm -f /mnt/fs/nixos/configuration.nix
  ```

  1.5.5: Install new config(s)

  ```bash
  sudo cp ./nixos/configuration.nix /mnt/fs/etc/nixos/
  sudo cp ./nixos/pkgs.nix /mnt/fs/etc/nixos/
  ```

  1.5.6: Modify the configuration to your likeing

  ```bash
  sudo vim /mnt/fs/etc/nixos/configuration.nix
  # if you want to add packages edit the pkgs.nix file
  ```

1.6: Install nixos

```bash
sudo nixos-install --root /mnt/fs
```

At the end of the install you will be prompted with setting a **root password**
after the install your machine will reboot
