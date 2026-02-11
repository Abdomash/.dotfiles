# dotfiles

This is my personal dotfiles repository. It contains neovim config files alongside various useful terminal utilities.

## Structure

Simple symlink-based dotfiles with GNU Stow.

- `nvim/` -> Neovim config (stow package)
- `tmux/` -> tmux config (stow package)
- `wezterm/` -> WezTerm config (stow package)
- `bin/` -> executables on PATH
- `scripts/` -> setup/build scripts
- `skills/` -> minimal harness-agnostic skills

## Quick Start

macOS and Debian/Ubuntu are supported.

```bash
git clone git@github.com:Abdomash/.dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
./scripts/install.sh
```

To build Neovim from source instead of using the package manager:

```bash
./scripts/install.sh --build-nvim
```

### Add the following to your shell config (e.g. `~/.bashrc`, `~/.zshrc`, etc.):

```bash
export PATH="$HOME/.dotfiles/bin:$PATH"
source "$HOME/.dotfiles/scripts/aliases.sh"
```

### Stow Usage

- symlink a package: `stow <package>`
- remove a package: `stow -D <package>`
- list stowed packages: `stow -S`
- list stow packages: `stow -l`

### Link Usage

- symlink a file/directory: `ln -s <source> <destination>`
- unlink a file/directory: `rm <destination>`

## Scripts

- `scripts/install.sh` installs dependencies, stows packages, and verifies the install.
- `scripts/install-deps.sh` installs dependencies on macOS or Debian/Ubuntu.
- `scripts/build-neovim.sh` builds Neovim from source.
- `scripts/aliases.sh` contains shell aliases.

## Skills

Skills are stored as single `skills/<skill>.md` files and can be symlinked/copied into your favorite harness.

These are minimal, context-agnostic skills to help agents perform common tasks with my stylistic preferences. They are intentionally simple and usable in any context. For example:
- `skills/commit.md` explains how to write a modular, composable git commits.
- `skills/pr.md` explains how to write and format PRs.
- `skills/review-code.md` explains how to conduct a code review.

## License

MIT License. See [LICENSE](LICENSE) for more details.
