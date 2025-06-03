```bash

# graphics drivers - refer: https://rpmfusion.org/Howto/NVIDIA#Current_GeForce.2FQuadro.2FTesla
$ sudo dnf update -y # and reboot if you are not on the latest kernel
$ sudo dnf install akmod-nvidia # rhel/centos users can use kmod-nvidia instead
$ sudo dnf install xorg-x11-drv-nvidia-cuda #optional for cuda/nvdec/nvenc support

# zsh
$ sudo dnf install zsh
$ sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
$ cat << EOF >> ~/.zshrc
export GPG_TTY=$(tty)
alias lg='echo "foo" | gpg --sign -u "nks@schlobohm.one" > /dev/null; lazygit'
EOF

# starship
$ curl -sS https://starship.rs/install.sh | sh
$ echo 'eval "$(starship init zsh)"' >> ~/.zshrc

# lazygit
$ sudo dnf copr enable atim/lazygit -y
$ sudo dnf install lazygit

# google chrome
$ sudo dnf install fedora-workstation-repositories
$ sudo dnf config-manager setopt google-chrome.enabled=1
$ sudo dnf install google-chrome-stable

# vscode
$ sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
$ echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\nautorefresh=1\ntype=rpm-md\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo > /dev/null
$ dnf check-update
$ sudo dnf install code

# pipx
$ sudo dnf install pipx
$ pipx ensurepath
$ sudo pipx ensurepath --global # optional to allow pipx actions with --global argument

# poetry (downstream of pipx)
$ pipx install poetry

# misc
$ sudo dnf install btop neovim newsboat
```
