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

## Usage

macOS and Debian/Ubuntu are supported.

> [!NOTE]
> You need `brew` for macOS:
> `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

**Installation**
```bash
git clone git@github.com:Abdomash/.dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
./scripts/install.sh --build-neovim # optional, otherwise it installs neovim binaries
```

**Add to your shell config (e.g. `~/.bashrc`)**
```bash
export PATH="$HOME/.dotfiles/bin:$PATH"
source "$HOME/.dotfiles/scripts/aliases.sh"
```

**`stow` Usage**
- `stow <package>` symlinks a package
- `stow -D <package>` removes a package

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
