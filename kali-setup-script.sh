#! /bin/bash


pkexec bash -c "
echo "deb http://http.kali.org/kali kali-last-snapshot main contrib non-free non-free-firmware" | tee /etc/apt/sources.list &&
apt update &&
apt install flatpak gnome-software gnome-software-plugin-flatpak bc ostree appstream-util gnome-shell-extension-caffeine ttf-mscorefonts-installer &&
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &&
flatpak remote-modify --enable flathub &&
flatpak install flathub -y com.mattjakeman.ExtensionManager com.google.Chrome org.mozilla.firefox org.videolan.VLC com.visualstudio.code org.onlyoffice.desktopeditors com.github.calo001.fondo &&
flatpak override com.github.calo001.fondo --filesystem=xdg-run/gvfsd &&
mkdir -p /usr/local/share/fonts && cd /usr/local/share/fonts &&
git clone https://github.com/supercomputra/SF-Mono-Font.git &&
git clone https://github.com/yell0wsuit/New-York-fonts.git &&
git clone https://github.com/aliifam/BlinkMacSystemFont.git &&
wget https://github.com/CartoDB/cartodb/raw/master/app/assets/fonts/helvetica.ttf && wget https://github.com/CartoDB/cartodb/raw/master/app/assets/fonts/helvetica-bold.ttf &&
mkdir -p /usr/local/share/fonts/ComicMono && cd /usr/local/share/fonts/ComicMono &&
wget https://dtinth.github.io/comic-mono-font/ComicMono.ttf &&
echo '[org/gnome/shell]
enabled-extensions=[\"ubuntu-appindicators@ubuntu.com\", \"dash-to-dock@micxgx.gmail.com\", \"ProxySwitcher@flannaghan.com\", \"caffeine@patapon.info\", \"system-monitor@gnome-shell-extensions.gcampax.github.com\", \"user-theme@gnome-shell-extensions.gcampax.github.com\", \"ding@rastersoft.com\"]' > /etc/dconf/db/local.d/00-extensions &&
chmod 755 /etc/dconf/db/local.d/00-extensions &&
echo '[org/gnome/desktop/interface]
cursor-theme=\"Adwaita\"' > /etc/dconf/db/gdm.d/10-cursor-settings &&
chmod 755 /etc/dconf/db/gdm.d/10-cursor-settings &&
dconf update &&
flatpak override --filesystem=xdg-config/gtk-4.0"

mkdir -p ~/.local/etc && cd ~/.local/etc/ && git clone https://github.com/vinceliuice/WhiteSur-gtk-theme &&
~/.local/etc/WhiteSur-gtk-theme/install.sh -d ~/.local/share/themes -o normal -c Light -t blue -i gnome -l && ~/.local/etc/WhiteSur-gtk-theme/tweaks.sh -F -o normal -c Light -t blue -l
fc-cache -v -f
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Light-blue'
