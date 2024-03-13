setup_decky_loader() {
  sudo pacman --noconfirm -Sy jq git
  yay -S --noconfirm brew-git

  # Finally installing Decky Loader
  curl -L https://github.com/SteamDeckHomebrew/decky-installer/releases/latest/download/install_release.sh | sh
}

sudo pacman --noconfirm -Sy vulkan-radeon vulkan-mesa-layers
sudo pacman --noconfirm -Sy steam gamescope
sudo pacman --noconfirm -Sy mangohud lib32-mangohud
sudo pacman --noconfirm -Sy lightdm lightdm-gtk-greeter

sudo cp -rf rootfs/usr/* /usr
sudo cp -rf rootfs/etc/* /etc

# Ownering permissions
sudo chmod 777 /usr/bin/jupiter-biosupdate
sudo chmod 777 /usr/bin/steamos-update
sudo chmod 777 /usr/bin/steamos-session-select
sudo chmod 777 /usr/bin/gamescope-session
sudo chmod 777 /usr/bin/return-to-gamemode

# Executable permissions
sudo chmod a+x /usr/bin/gamescope-session
sudo chmod a+x /usr/bin/return-to-gamemode
sudo chmod a+x /usr/libexec/steamos-autologin
sudo chmod a+x /usr/libexec/return-to-gamemode
sudo chmod a+x /usr/share/gamescope-session/gamescope-session-script
sudo chmod a+x /usr/share/applications/return-to-gamemode.desktop
sudo chmod a+x /usr/share/applications/org.valve.gamescope.desktop
sudo gio set /usr/share/applications/org.valve.gamescope.desktop metadata::trusted true

# Enabling autologin and special powers for user
sudo groupadd -r autologin
sudo usermod -a -G autologin $USER
sudo usermod -a -G wheel $USER

# Preparing bluetooth for steamos session
sudo systemctl enable bluetooth
sudo systemctl enable bluetooth-workaround

# Changing display manager
if command -v sddm > /dev/null; then
  sudo systemctl disable sddm
fi

if command -v gdm > /dev/null; then
  sudo systemctl disable gdm
fi

sudo systemctl enable lightdm
sudo systemctl enable steamos-autologin.service

setup_decky_loader

sudo reboot -f
