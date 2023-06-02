#!/bin/bash

echo '--------------------------------------------------'
echo '|                Config Install                  |'
echo '--------------------------------------------------'

#Измените на своё:
username=user
hostname=linuxPC
pass=1111
#Раскомментируйте необходимое:

#ucode=amd-ucode
#ucode=intel-ucode
sleep=5

#setfont cyr-sun16:
setfont cyr-sun16
echo '--------------------------------------------------'
echo '|              Install Arch Linux                |'
echo '--------------------------------------------------'
echo 'Install Arch Linux '$username'@'$hostname'		'
echo '--------------------------------------------------'
echo '--------------------------------------------------'
echo '|             Форматирование диска               |'
echo '--------------------------------------------------'
#sleep:
sleep $sleep

#formating disk:
parted /dev/sda mklabel gpt
sleep=10
parted /dev/sda mkpart primary 1MB 512MB
sleep=10
parted /dev/sda mkpart primary 512MB 2560MB
sleep=10
parted /dev/sda mkpart primary 2560MB 100%
sleep=10
parted /dev/sda set 1 boot on
mkfs.ext4 /dev/sda3
sleep=10
#formating disk:
mkfs.vfat $disk_boot
sleep=5
#раскомментируйте необходимое:
#formating disk:
mkswap $disk_swap
sleep=5
swapon $disk_swap
#mount mnt:
cd
#umount:

#sleep
sleep $sleep
#sleep:
echo '--------------------------------------------------'
echo '|             Монтирование разделов               |'
echo '--------------------------------------------------'
#mount disk:
mount /dev/sda3 /mnt
mkdir /mnt/boot
mkdir /mnt/boot/efi
swapon /dev/sda2
mount /dev/sda1 /mnt/boot/efi
#sleep:
sleep $sleep
#sleep:
echo '--------------------------------------------------'
echo '|             Установка Arch Linux                |'
echo '--------------------------------------------------'
#install arch:
pacstrap -K /mnt base base-devel linux-firmware refind efibootmgr iwd networkmanager micro htop btrfs-progs git ntfs-3g $ucode --noconfirm
#fstab generation:
#genfstab -U -p /mnt >> /mnt/etc/fstab
#chroot:
#mkdir -p /mnt/home/$username/
#раскомментируйте необходимое:
#chroot nvidia:
#cp -f arch-install-btrfs/nvidia/install.sh /mnt/home/$username/
#chroot nvidia:
#cp -f arch-install-btrfs/nvidia/install2.sh /mnt/home/$username/
#chroot nvidia:
#cp -f arch-install-btrfs/nvidia/install3.sh /mnt/home/$username/
#chroot mesa:
#cp -f arch-install-btrfs/amd/install.sh /mnt/home/$username/
#chroot mesa:
#cp -f arch-install-btrfs/amd/install2.sh /mnt/home/$username/
#chroot mesa:
#cp -f arch-install-btrfs/amd/install3.sh /mnt/home/$username/
#sleep:
#sleep $sleep
#chroot /mnt:
#arch-chroot /mnt sh -c "$(cat /mnt/home/$username/install2.sh)" $username $hostname $pass
#sleep:
#sleep $sleep
#echo '--------------------------------------------------'
#echo '|                 Перезагрузка                   |'
#echo '--------------------------------------------------'
#umount -R /mnt/
#reboot
