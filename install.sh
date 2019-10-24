#!/bin/bash
## Install required packages after installing Ubuntu 18.04

APP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "[INIT_LL][INFO] App cloned to ${APP_DIR}"

echo '[INIT_LL][INPUT] Please run as root / sudo - CAUTION!'
echo 'This will install numerous packages and ruby2.3 (and set it as your primary ruby version)'
echo 'Please press Ctrl+C to cancel or press ENTER to continue'
read

echo '[INIT_LL][INFO] Updating sources file - backup in /root/sources.list.orig'
  cp /etc/apt/sources.list /root/sources.list.orig
  cat <<EOM > /etc/apt/sources.list
deb http://gb.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse
# deb-src http://gb.archive.ubuntu.com/ubuntu/ bionic main restricted universe multiverse

deb http://gb.archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src http://gb.archive.ubuntu.com/ubuntu/ bionic-updates main restricted universe multiverse

deb http://gb.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src http://gb.archive.ubuntu.com/ubuntu/ bionic-backports main restricted universe multiverse

 deb http://archive.canonical.com/ubuntu bionic partner
# deb-src http://archive.canonical.com/ubuntu bionic partner

deb http://security.ubuntu.com/ubuntu bionic-security main restricted universe multiverse
# deb-src http://security.ubuntu.com/ubuntu bionic-security main restricted universe multiverse
EOM

echo '[INIT_LL][INFO] Updating system'
  apt update
  apt upgrade

echo '[INIT_LL][INFO] Installing essential packages'
  apt install -yf ntfs-3g ntfs-3g-dev make gcc build-essentials xdotool xclip ubuntu-restricted-* linux-firmware libimage-exiftool-perl libgmp-dev
  apt install -yf libmysqlclient-dev mysql-client mysql-utilities openssh-server sshpass
  apt install -yf vim ncdu htop nbtscan curl gparted imagemagick git terminator cowsay xcowsay gimp pina kazam vlc guake gnome-tweak-tool chrome-gnome-shell simplescreenrecorder
  apt-install -yf ruby ruby-dev ruby-bundler

echo '[INIT_LL][INFO] Installing secondary package managers'
  apt install -yf snap flatpak
  apt install -yf gnome-software-plugin-flatpak
  flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo '[INIT_LL][INFO] Installing more essential packages'
  snap install slack --classic
  snap install atom --classic

echo '[INIT_LL][INFO] Installing up-to-date Ruby'
  apt install -yf devtools imagemagick xdotool xclip ntfs-3g ntfs-3g-dev vlc gparted gimp pinta kazam cowsay xcowsay guake
  apt-add-repository ppa:brightbox/ruby-ng
  apt update
  apt install -yf ruby2.3 ruby2.3-dev ruby-bundler
  gem install bundler

echo '[INIT_LL][INFO] Syncing filesystem'
  sync
  updatedb
  sync

echo '-------------------------------------------------------------------------------------'

echo '[INIT_LL][INPUT] Would you like to install less essential packages? [y/n]'
select pkg_yn in 'y' 'n'; do
  case $pkg_yn in
    y ) apt install -yf telegram-desktop ; snap install android-studio --classic ;;
    n ) break;;
  esac
  echo ''
done

echo '[INIT_LL][INPUT] Would you like to install Gyazo? [y/n]'
select gyazo_yn in 'y' 'n'; do
  case $gyazo_yn in
    y ) curl -s https://packagecloud.io/install/repositories/gyazo/gyazo-for-linux/script.deb.sh | bash ; apt install gyazo ;;
    n ) break ;;
  esac
  echo ''
done

echo '[INIT_LL][INPUT] Would you like to instal Virtualisation? [y/n]'
select virt_yn in 'y' 'n'; do
  case $virt_yn in
    y ) apt install -yf virtualbox virtualbox-ext-pack virtualbox-guest-additions-iso virtualbox-guest-utils virtualbox-guest-x11 ;;
    n ) break ;;
  esac
  echo ''
done


echo '-------------------------------------------------------------------------------------'

echo '[INIT_LL][INFO] Symlinking init executables to /usr/local/bin'
  ln -s ${APP_DIR}/init_llts /usr/local/bin/init_llts
  ln -s ${APP_DIR}/init_llice /usr/local/bin/init_llice

echo '[INIT_LL][INFO] Cleaning up'
  apt remove --purge ubuntu-web-launchers -yf
  apt autoremove
  apt clean
  updatedb
  sync

echo ''
echo '[INIT_LL][INFO] FINISHED!!!'
echo ''
echo '[INIT_LL][INFO] Post-Install Checklist:'
echo '1) Enable proprietary drivers in Additional Drivers tab of Software & Updates'
echo '2) Set up keyboard shortcuts (Terminator, Gyazo)'
echo '3) Make sure to set up required partitions in /etc/fstab'
echo '4) Install Google Chrome via https://www.google.co.uk/chrome'
echo '5) Gnome tweaks & extensions @ https://extensions.gnome.org/'
echo '6) Install XLL from git repo: https://github.com/EmpyDoodle/xll_support.git'
echo ''
echo '[INIT_LL][INFO] To run your workstation profile, simply run $ init_llts or $ init_llice'
