# dotfiles

This is my personal dotfiles repository. It contains neovim config and various useful terminal utils.

## Structure

Simple symlink-based dotfiles with Stow.

- `nvim/` -> Neovim config (stow package)
- `tmux/` -> tmux config (stow package)
- `wezterm/` -> WezTerm config (stow package)
- `alacritty/` -> Alacritty config (stow package)
- `bin/` -> executables on PATH
- `scripts/` -> setup/build scripts

## Usage

> [!WARNING]
> You need `brew` for macOS:
> `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

### 1. **Installation**

```bash
git clone git@github.com:Abdomash/.dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
bash ./install.sh --build-neovim
```

### 2. **Add this to your shell config (e.g. `~/.bashrc`)**

```bash
export PATH="$HOME/.dotfiles/bin:$PATH"
source "$HOME/.dotfiles/scripts/aliases.sh"
```

## Scripts

- `install.sh` installs dependencies, stows packages, and verifies the install.
- `scripts/install-deps.sh` installs dependencies on macOS or Debian/Ubuntu.
- `scripts/build-neovim.sh` builds Neovim from source.
- `scripts/aliases.sh` contains shell aliases.

## License

MIT License. See [LICENSE](LICENSE) for more details.
