#!/usr/bin/env bash

set -euo pipefail

NVIM_VERSION="v0.11.5"
NVIM_SRC_DIR="${HOME}/neovim"

if [[ -d "$NVIM_SRC_DIR/.git" ]]; then
  git -C "$NVIM_SRC_DIR" fetch --depth 1 origin "$NVIM_VERSION"
  git -C "$NVIM_SRC_DIR" checkout "$NVIM_VERSION"
else
  git clone --depth 1 --branch "$NVIM_VERSION" https://www.github.com/neovim/neovim.git "$NVIM_SRC_DIR"
fi

make -C "$NVIM_SRC_DIR" CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make -C "$NVIM_SRC_DIR" install
