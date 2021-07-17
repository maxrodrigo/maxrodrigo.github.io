---
title: How to Install Alpine Linux on Raspberry Pi
---

## Preparation

1. [Download](https://alpinelinux.com/downloads/) the Raspberry Pi **armv7** build.
1. Identify you memory card name: `lsblk`.
    ```sh
    lsblk
    NAME        MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
    mmcblk0     179:0    0  59.5G  0 disk
    ├─mmcblk0p1 179:1    0   174K  0 part
    ├─mmcblk0p2 179:2    0   1.4M  0 part
    └─mmcblk0p3 179:3    0 130.7M  0 part
    ```
1. Partition and format the memory card. `mkfs.vfat` is available installing `dosfstools`.
    ```sh
    sudo parted /dev/mmcblk0 --script -- mklabel msdos
    sudo parted /dev/mmcblk0 --script -- mkpart primary fat32 1MiB 100%
    sudo mkfs.fat -F32 -I /dev/mmcblk0
    ```
1. Mount the new partition.
    ```sh
    sudo mount /dev/mmcblk0p1 /mnt/sd
    ```
1. Unpack the Alpine package onto the partition.
    ```sh
    sudo tar xf alpine-rpi-**-armv7.tar.gz -C /mnt/sd --no-same-owner
    ```
1. Copy the `usercfg.txt` file to the memory card.

    ```sh
    sudo cp usercfg.txt /mnt/sd
    ```

    ```txt
    # Enable mini UART as serial port (/dev/ttyS0).
    # Also, fixes VideoCore IV (aka the GPU or the VPU) frequency to 250MHz.
    enable_uart=1

    # give the GPU the least amount of RAM it can get by with (16MB).
    # This also triggers the Pi to use a cutdown version of the firmware (start_cd.elf).
    gpu_mem=16

    # Turn off audio and bluetooth.  (Note "dt" stands for device tree
    dtparam=audio=off,pi3-disable-bt
    ```
1. Copy an answer file (optional).

    During the setup process
    an [answer file](https://docs.alpinelinux.org/user-handbook/0.1a/Installing/setup_alpine.html#_answer_files) can be provided
    to automate the configuration process.

1. Unmount.
    ```sh
    sudo umount /mnt/sd
    ```

## Alpine Installation

1. Log in into Alpine with the default username and password.

    Default Alpine login credentials are username `root` with **empty password**.

1. Run setup.

    ```sh
    setup-alpine
    ```

    Alternatively to the interactive mode,
    an answer file can be provided to automate the configuration process.
    See preparation.

    ```sh
    setup-alpine -f /media/mmcblk0p1/alpine-setup.txt
    ```

1. Create a new partition with the free space.

    ```sh
    apk add cfdisk
    cfdisk /dev/mmcblk0
    ```

    Resize the FAT32 partition to 1GB and use the remaining space to create a new primary bootable partition where Alpine Linux is installing in sys mode.

    Format and mount the new partition.

    **Note:** If the new partition doesn't exists, reboot and rerun `setup-alpine`.

    ```sh
    apk add e2fsprogs
    mkfs.ext4 /dev/mmcblk0p2
    mount /dev/mmcblk0p2 /mnt
    ```

1. Install the system files.

    ```sh
    setup-disk -m sys /mnt
    ```
    If you get `ext4 is not supported . Only supported are: vfat` error, run with `FORCE_BOOTFS` set.

    ```sh
    FORCE_BOOTFS=1 setup-disk -m sys /mnt
    ```

1. Remount old partition in RW. An update in the first partition is required for the next reboot.

    ```sh
    mount -o remount,rw /media/mmcblk0p1
    ```
1. Clean up the boot folder in the first partition to drop unused files.

    ```sh
    rm -f /media/mmcblk0p1/boot/*
    cd /mnt
    rm boot/boot
    ```

1. Move the image and `init ram` for Alpine Linux into the right place.

    ```sh
    mv boot/* /media/mmcblk0p1/boot
    rm -Rf boot
    mkdir media/mmcblk0p1 # It's the mount point for the first partition on the next reboot
    ```

1. Update `/etc/fstab`:

    ```sh
    echo "/dev/mmcblk0p1 /media/mmcblk0p1 vfat defaults 0 0" >> etc/fstab
    sed -i '/cdrom/d' etc/fstab
    sed -i '/floppy/d' etc/fstab
    ```
1. Enable edge repository.

     ```sh
     sed -i '/edge/s/^#//' /mnt/etc/apk/repositories
     ```

1. For the next boot, indicate that the root filesystem is on the second partition. If the cmdline.txt file contains a line that starts with /root, then use sed:

    ```sh
    sed -i 's/$/ root=\/dev\/mmcblk0p2 /' /media/mmcblk0p1/cmdline.txt
    ```

1. Make sure that appropriate `cgroups` are enabled

    ```sh
    sed -i "s/$/ cgroup_enable=cpuset cgroup_enable=memory cgroup_memory=1/" /media/mmcblk0p1/cmdline.txt
    ```
1. If using `chrony`, allow the system clock to be stepped in the first three updates if its offset is larget than 1 second.

    ```sh
    echo "makestep 1.0 3" >> /etc/chrony/chrony.conf
    ```
    
3. Reboot
