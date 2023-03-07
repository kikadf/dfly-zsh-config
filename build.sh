#!/bin/sh
# Install script to DragonFly Zsh config

_D_zsh_confdir="$HOME/.config/zsh.d"
mkdir build

msg() {
    echo ">>> $@"
}

# manjaro-zsh-config
# https://gitlab.manjaro.org/packages/community/manjaro-zsh-config/-/blob/master/PKGBUILD
# https://github.com/Chrysostomus/manjaro-zsh-config
build_mzc() {
    msg "Build manjaro-zsh-config..."
    cd build
    git clone https://github.com/Chrysostomus/manjaro-zsh-config
    cd manjaro-zsh-config
    install -D -m644 .zshrc -t "${HOME}/"
	install -D -m644 manjaro-zsh-config -t "${_D_zsh_confdir}/"
	install -D -m644 manjaro-zsh-prompt -t "${_D_zsh_confdir}/"
	install -D -m644 zsh-maia-prompt -t "${_D_zsh_confdir}/"
	install -D -m644 p10k.zsh -t "${_D_zsh_confdir}/"
	install -D -m644 p10k-portable.zsh -t "${_D_zsh_confdir}/"
	install -D -m644 command-not-found.zsh -t "${_D_zsh_confdir}/functions/"
	install -d "${_D_zsh_confdir}/scripts"
	cp -r base16-shell "${_D_zsh_confdir}/scripts/"
	chmod a+x "${_D_zsh_confdir}/scripts/base16-shell/"*
	msg "manjaro-zsh-config done."
}


# zsh-history-substring-search


# zsh-theme-powerlevel10k


