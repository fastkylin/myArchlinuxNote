 #We need an U disk which including a live system. we cat use command fdisk and dd to creat a live. After Start Archlinux from U disk. Chechking the Network connection. just use ip link to see the name of netcard.
-
- [STEP ONE](#one)

- [STEP TWO](#two)

- [OTHER](#other)


<h1 id="one">STEP ONE<h1>

- updating time of system

		timedatectl set-ntp true

- create partions for Arch

		fdisk -l 
		fdisk /dev/sdx

##BIOS	MBR

|/mnt|/dev/sdx1|
|-|-|

##UEFI	GPT
<table>
<tr align="center">
<td>/mnt/boot or /mnt/efi</td><td>/dev/sdx1</td><td>EFI system partition</td>
</tr>
<tr align="center"> 
<td>/mnt</td><td>/dev/sdx2</td><td>ext4 file system</td>
</tr>
</table>

- next format the partition

		mkfs.ext4 /dev/sdx1

- and now mount the partition on /mnt
		
		mount /dev/sdx1 /mnt

- pulling the base of arch to /mnt
		
		pacstrap /mnt base

- generating fstab file
		
		genfstab -U /mnt >> /mnt/etc/fstab

- changing root to /mnt
		
		arch-chroot /mnt
- set timezone

		ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

- generat /etc/adjtime

    		hwclock --systohc

- set locale
<table><tr  align="center"><th>filename</th><th>content</th></tr>
<tr align="center"><td>/etc/locale.gen</td><td>en_US.UTF-8 UTF-8<br>zh_CN.UTF-8 UTF-8</td></tr>
</table>

- run locale-gen
		
		locale-gen
- set /etc/locale.conf

<table><tr  align="center"><th>filename</th><th>content</th></tr>
<tr align="center"><td>/etc/locale.conf</td><td>LANG=en_US.UTF-8</td></tr>
</table>


- set hostname

<table><tr  align="center"><th>filename</th><th>content</th></tr>
<tr align="center"><td>/etc/hostname</td><td>myhostname</td></tr>
</table>

- set hosts

<table><tr  align="center"><th>filename</th><th>content</th></tr>
<tr align=""><td>/etc/hosts</td><td>127.0.0.1	localhost
<br>::1		localhost<br>127.0.0.1 myhostname.localdomain myhostname</td></tr>
</table>

- install linux
	
		pacman -S linux linux-firmware
		
- creat initramfs

		mkinitcpio -p linux

- set root password

		passwd

- install some important packages

		pacman -S networkmanager net-tools
		systemctl enbale NetworkManager

- install  ucode

		pacman -S amd-ucode	# if your cpu is amd
		pacman -S intel-ucode	# if your cpu is intel

- install grub

    		pacman -S grub 

- set grub

		grub-install --target=i386-pc /dev/sdx	# if you use BIOS to start system
		grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB	# if you are EFI


- grub-mkconfig

   		 grub-mkconfig -o /boot/grub/grub.cfg


lastly, you can logout /mnt. just use exit or CTRL+D. and you need umont /mnt, next reboot Archlinux.





<h1 id="two">STEP TWO<h1>

- check the network 

    if you lost connection of Internet, you maybe use ip link to check netcard, and ip link eth0 up&dhcpcd eth0

		ping google.com

- pull the mirrrors

    		pacman -Syy 

- install xorg

    		pacman -S xorg
		
- install xterm xrandr

		pacman -S xterm xorg-xinit xorg-xrandr
		
- (option)install awesome 

		pacman -S awesome

- (oprion)add an user for desktop 

		useradd -m -g users -G wheel -s /sbin/nologin username

- (option)install lightdm
		
		pacman -S lightdm lightdm-gtk-greeter

- (option)install sddm

		pacman -S sddm sddm-kcm
		systemctl enable sddm

- (option)install xfce4

		pacman -S xfce4 xfce4-goodies
		
- (option)install audio package

    		pacman -S alsa-utils pulseaudio pulseaudio-alsa

- (option)install fcitx

    		pacman -S fcitx fcitx-rime fcitx-im kcm-fcitx

##we can set LANG 


<table><tr  align="center"><th>filename</th><th>content</th></tr>
<tr align=><td>/etc/username/.xporfile</td><td>export LANG=en_US.UTF-8<br>export LC_ALL=en_US.UTF-8<br>export GTK_IM_MODULE=fcitx<br>export QT_IM_MODULE=fcitx<br>export XMODIFIERS="@im=fcitx"</td></tr>
</table>


<h1 id="other">OTHER<h1>

- amdgpu

		pacman -S xf86-video-ati xf86-video-amdgpu
		
- 1080p

		xrandr --newmode "1920x1080_60.00" 173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
		xrandr --addmode monitorPort "1920x1080_60.00"
		xrandr --output monitorPort --mode "1920x1080_60.00"		

