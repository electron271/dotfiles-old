# dotfiles
My personal dotfiles, designed to be adaptable and simple!

## Installation
#### Dependencies:
- (recommended) Arch Linux
- Kitty
- XMonad
- Xmobar
- zsh + ohmyzsh
- Nerd Fonts
- Neofetch
- Neovim

```bash
# Recommended method, will install to ~/.dotfiles
git clone https://github.com/electron271/dotfiles.git ~/.dotfiles
# You can also use this to pick a specific directory
git clone https://github.com/electron271/dotfiles.git <directory>

# Run the install script
./install.sh
```
> **NOTE:**
> You can also run `git clone https://github.com/electron271/dotfiles.git` to just clone it to `dotfiles`

### Uninstallation
There is not currently an uninstall script, but you can remove the symlinks, then get your config files from the `~/.old_dotfiles` directory.
