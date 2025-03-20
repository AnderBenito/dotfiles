#!/bin/bash
# install.sh
# symlink you dotfiles to appropriate places

DIR=$HOME/dotfiles

DOTFILES=(
	".zshrc"
	".config/nvim"
	".config/nvim_vscode"
)

for dotfile in "${DOTFILES[@]}";do
	rm -rf "${HOME}/${dotfile}"

	TARGET_DIR="${HOME}/$(dirname "${dotfile}")"

	# Ensure the directory exists
	mkdir -p "${TARGET_DIR}"

	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
