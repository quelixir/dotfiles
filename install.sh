echo "Transferring dotfiles..."
cp -r ./.config/. ~/.config/.

echo "Updating..."

sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

sudo dnf update -y
sudo dnf install -y fedora-workstation-repositories

echo "Installing graphics drivers..."
sudo dnf install -y akmod-nvidia
sudo dnf install -y xorg-x11-drv-nvidia-cuda

echo "Installing and setting up ZSH/OMZ..."
sudo dnf install -y zsh
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cat << EOF >> ~/.zshrc
export GPG_TTY=$(tty)
alias lg='echo "foo" | gpg --sign -u "nks@schlobohm.one" > /dev/null; lazygit'
EOF

echo "Installing Lazygit..."
sudo dnf copr enable atim/lazygit -y
sudo dnf install -y lazygit

echo "Installing Google Chrome..."
sudo dnf config-manager setopt google-chrome.enabled=1
sudo dnf install -y fedora-workstation-repositories
sudo dnf install -y google-chrome-stable

echo "Installing Visual Studio Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
dnf check-update
sudo dnf install -y code

echo "Installing pipx..."
sudo dnf install -y pipx
pipx ensurepath
sudo pipx ensurepath --global # optional to allow pipx actions with --global argument

echo "Installing Poetry (downstream of pipx)..."
pipx install poetry

echo "Installing and setting up Neovim..."
sudo dnf install -y neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +'PlugInstall --sync' +qa

echo "Installing and setting up Starship..."
curl -sS https://starship.rs/install.sh | sudo sh
echo 'eval "$(starship init zsh)"' >> ~/.zshrc
starship preset catppuccin-powerline -o ~/.config/starship.toml

echo "Installing other packages..."
sudo dnf install -y btop newsboat yt-dlp

