#!/usr/bin/bash

RED="\e[31m"
GREEN="\e[32m"
BOLDGREEN="\e[1;32m"
ENDCOLOR="\e[0m"

USER=$(whoami)

CURR_DIR=`pwd`

print(){
    echo -e "${BOLDGREEN}>>>>>>> $1 ${ENDCOLOR}"
}

# Update System
# =============
print "Updating"
sudo apt update

print "Upgrading"
sudo apt full-upgrade -y


# Install Programs
# ================
for APT in $(cat apt.config); do
    print "Installing ${APT}.apt"
    sudo apt install $APT -y
done

for SNAP in $(cat snap.config); do
    print "Installing ${SNAP}.snap"
    sudo snap install $SNAP --classic
done

print "Installing VSCode Extensions"
for EXT in $(cat vscode_extensions.config); do
    echo test
    code --install-extension $EXT
done

print "Installing Ghostty"
sudo snap install zig --classic --beta
sudo apt install libgtk-4-dev libadwaita-1-dev -y
git clone https://github.com/ghostty-org/ghostty /home/$USER/Downloads/ghostty
cd /home/$USER/Downloads/ghostty
git checkout `git tag | sort -r | head -1`
sudo zig build -p /usr -Doptimize=ReleaseFast
cd $CURR_DIR
sudo rm -rf /home/$USER/Downloads/ghostty

print "Install Chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

print "Downloading SecLists"
sudo git clone https://github.com/danielmiessler/SecLists.git /usr/share/seclists

print "Installing Pop_os Shell"
git clone https://github.com/pop-os/shell.git /home/$USER/Downloads/shell
cd /home/$USER/Downloads/she
sudo npm install --global typescript
make local-install -y
gsettings reset-recursively org.gnome.desktop.wm.keybindings
cd $CURR_DIR
rm -rf /home/$USER/Downloads/shell

# Configure Directories
# =====================
print "Creating /home/$USER/Projects"
mkdir /home/$USER/Projects

print "Creating /home/$USER/.ovpn"
mkdir /home/$USER/.ovpn

print "Creating /home/$USER/hacky_hack_hack"
mkdir /home/$USER/hacky_hack_hack

print "Creating /home/$USER/Tools"
mkdir /home/$USER/Tools

print "Remove unused dirs."
rm -rf /home/$USER/Videos
rm -rf /home/$USER/Templates
rm -rf /home/$USER/Public
rm -rf /home/$USER/Music

# Setup zsh
# =========
print "Setting up zsh"
sudo chsh --shell /bin/zsh $USER
sudo chsh --shell /bin/zsh
sudo git clone https://github.com/zsh-users/zsh-autosuggestions /usr/share/zsh-autosuggestions
sudo cp ../misc/zshrc.sh /home/$USER/.zshrc
sudo cp ../misc/zsh_aliases.sh /home/$USER/.zsh_aliases

# Add custom scripts
# ==================
print "Add IPA"
print "Adding IPA"
sudo cp ../misc/ipa.py /usr/local/sbin/ipa
sudo chmod +x /usr/local/sbin/ipa

print "Add venvy"
print "Adding venvy"
sudo cp ../misc/venvy.sh /usr/local/sbin/venvy
sudo chmod +x /usr/local/sbin/venvy

# Setup user environment
# ======================
print  "Set to dark theme + set background"
cp ../misc/dark_debian.png ~/Pictures/
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.background picture-uri file:////home/$USER/Pictures/dark_debian.png
gsettings set org.gnome.login-screen logo /home/$USER/Pictures/dark_debian.png
gsettings set org.gnome.desktop.session idle-delay 0

print "Setup dock"
gsettings set org.gnome.shell favorite-apps "['org.gnome.Terminal.desktop', 'org.gnome.Nautilus.desktop', 'code_code.desktop']"
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 16
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false

# Setup GitHub Shit
# =================
git config --global user.name "bradmanfordson"
git config --global user.email $email
ssh-keygen -q -t ed25519 -N "" -C "$email" -f /home/$USER/.ssh/github_keys
eval "$(ssh-agent -s)"
ssh-add /home/$USER/.ssh/github_keysls
