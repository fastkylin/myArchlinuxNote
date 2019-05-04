We need an U disk which including a live system.
we cat use command fdisk and dd to creat a live.

After Start Archlinux from U disk
Chechking the Network connection.
just use ip link to see the name of netcard.

PART ONE

updating time of system
# timedatectl set-ntp true
create partions for Arch
#fdisk -l 
#fdisk /dev/sdx

##BIOS	MBR
##	/mnt    /dev/sdx1  

##UEFI	GPT
##	/mnt/boot or /mnt/efi   /dev/sdx1  EFI system partition
##	/mnt 	/dev/sdx2    

next format the partition
#mkfs.ext4 /dev/sdx1

and now mount the partition on /mnt
#mount /dev/sdx1 /mnt

pulling the base of arch to /mnt
#pacstrap /mnt base

generating fstab file
# genfstab -U /mnt >> /mnt/etc/fstab

changing root to /mnt
#arch-chroot /mnt


#set timezone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#generat /etc/adjtime
hwclock --systohc

#set locale
##	file	/etc/locale.gen
##		en_US.UTF-8 UTF-8
##		zh_CN.UTF-8 UTF-8

#run locale-gen
locale-gen

#set LANG
##	file	/etc/locale.conf
##		LANG=en_US.UTF-8

#set hostname
##	file	/etc/hostname
##		myhostname

#set hosts
##	file	/etc/host
##		127.0.0.1	localhost
##		::1		localhost
##		127.0.1.1	myhostname.localdomain	myhostname

#creat initramfs
mkinitcpio -p linux

#set root password
passwd

#install some important pockages
pacman -S networkmanager net-tools
 
systemctl enbale NetworkManager

#install  ucode 
pacman -S amd-ucode	# if your cpu is amd
pacman -S intel-ucode	# if your cpu is intel

#install grub
pacman -S grub 

#set grub
grub-install --target=i386-pc /dev/sdx	# if you use BIOS to start system
grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB	# if you are EFI


#grub-mkconfig
grub-mkconfig -o /boot/grub/grub.cfg


lastly, you can logout /mnt. just use exit or CTRL+D. and you need umont /mnt,okey just reboot to Archlinux





PART TWO

#check the network 
# if you lost connection of Internet, you maybe use ip link to check netcard, and ip link eth0 uo$$dhcpcd eth0
ping google.com

#pull the mirrrors
pacman -Syy 

#install xorg
pacman -S xorg

#add an user for desktop 

#install kde environment
pacman -S plasma kde-applications

#install sddm
pacman -S sddm sddm-kcm
systemctl enable sddm

#install audio package
pacman -S alsa-utils pulseaudio pulseaudio-alsa

#install fcitx
pacman -S fcitx fcitx-rime fcitx-im kcm-fcitx

##we can set LANG 
##	file	/home/<username>/.xprofile
##		export LANG=en_US.UTF-8
##		export LC_ALL=en_US.UTF-8
##		export GTK_IM_MODULE=fcitx
##		export QT_IM_MODULE=fcitx
##		export XMODIFIERS="@im=fcitx"








