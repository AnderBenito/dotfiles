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
	ln -sf "${DIR}/${dotfile}" "${HOME}/${dotfile}"
done
