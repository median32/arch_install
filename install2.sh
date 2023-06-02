#!/bin/bash

echo '--------------------------------------------------'
echo '|                 Config Install                  |'
echo '--------------------------------------------------'

#Замените на своё:
username=hacker
hostname=world
pass=1811
disk_root=/dev/nvme0n1p5
disk_boot=/dev/nvme0n1p4

echo '--------------------------------------------------'
echo '|Install Arch Linux '$username'@'hostname'       |'
echo '--------------------------------------------------'
#services:
systemctl enable iwd.service
#services:
systemctl enable NetworkManager.service
#mount boot:
mount $disk_boot /boot/efi
#hostname:
echo $hostname >> /etc/hostname
#locale eng:
sed -i 's/#en_US.U/en_US.U/g' /etc/locale.gen
#locale rus:
sed -i 's/#ru_RU.U/ru_RU.U/g' /etc/locale.gen
#locale generation:
locale-gen
#locale conf:
echo LANG=en_US.UTF-8 >> /etc/locale.conf
#locale conf:
echo LANG=ru_RU.UTF-8 >> /etc/locale.conf
#passwd root:
(
    echo $pass
    echo $pass
) | passwd
#add user:
useradd -m -g users -G wheel,video -s /usr/bin/zsh $username
#passwd user:
(
    echo $pass
    echo $pass
) | passwd $username
#sudoers:
sed 's/# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' -i /etc/sudoers
#chown:
chown -R $username:users /home/$username/
#pacman.conf:
sed 's/#ParallelDownloads = 5/ParallelDownloads = 10/' -i /etc/pacman.conf
#pacman.conf:
echo -e '[multilib]\nInclude = /etc/pacman.d/mirrorlist\n' >> /etc/pacman.conf
#install core lqx:
pacman-key --keyserver hkps://keyserver.ubuntu.com --recv-keys 9AE4078033F8024D
#install core lqx:
pacman-key --lsign-key 9AE4078033F8024D
#install core lqx:
echo '[liquorix]' >> /etc/pacman.conf
#install core lqx:
echo 'Server = https://liquorix.net/archlinux/$repo/$arch' >> /etc/pacman.conf
#pacman —Sy:
pacman -Sy
#install core lqx:
pacman -S linux-lqx linux-lqx-headers --noconfirm
#blkid:
uuid=$(blkid -s UUID -o value $disk_root)
#раскомментируйте необходимое:
#refind nvidia:
#echo '"Boot to standard options" "rw root=UUID='$uuid' rootflags=subvol=@ loglevel=0 quiet splash rootfstype=btrfs nvidia-drm.modeset=1"' >> /boot/refind_linux.conf
#refind nvidia:
#echo '"Boot to single-user mode" "rw root=UUID='$uuid' rootflags=subvol=@ loglevel=0 quiet splash rootfstype=btrfs nvidia-drm.modeset=1 single"' >> /boot/refind_linux.conf
#refind mesa:
echo '"Boot to standard options" "rw root=UUID='$uuid' rootflags=subvol=@ loglevel=0 quiet splash rootfstype=btrfs"' >> /boot/refind_linux.conf
#refind mesa:
echo '"Boot to single-user mode" "rw root=UUID='$uuid' rootflags=subvol=@ loglevel=0 quiet splash rootfstype=btrfs single"' >> /boot/refind_linux.conf
#refind:
echo '"Boot with minimal options ro root='$disk_root'"' >> /boot/refind_linux.conf
#refind:
refind-install
#mkinitcpio:
mkinitcpio -P
#install zsh:
echo '--------------------------------------------------'
echo '|            Установка оболочки zsh              |'
echo '--------------------------------------------------'
#zsh:
pacman -S zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions grml-zsh-config --noconfirm
#zsh chsh:
( 
	echo $pass
 ) |chsh -s /usr/bin/zsh
 #zsh chsh root:
( 
	echo $pass
 ) |sudo chsh -s /usr/bin/zsh
#zsh:
cd /root/
wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/.zshrc'
#zsh:
cd /home/$username/
wget 'https://raw.githubusercontent.com/like913/arch-install/master/config/.zshrc'
#chown:
chown -R $username:users .zshrc
#sleep:
sleep $sleep
echo '--------------------------------------------------------------------------------'
echo '|                    Установка пользовательских приложений                     |'
echo '--------------------------------------------------------------------------------'
sh /home/$username/install3.sh $username $pass
#Scc:
pacman -Scc --noconfirm
#exit:
exit
