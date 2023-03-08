#!/bin/sh
# Install script to DragonFly Zsh config

_D_zsh_confdir="$HOME/.config/zsh.d"
mkdir build

# Small functions
msg() {
	echo ">>> $@"
}

patching() {
	for _patch in $(ls ../../patches/"$1"/); do
		patch -p1 $_patch
	done
}

cleaning() {
	msg "Clean build directory..."
	rm -rf build
}

# manjaro-zsh-config
# https://gitlab.manjaro.org/packages/community/manjaro-zsh-config/-/blob/master/PKGBUILD
# https://github.com/Chrysostomus/manjaro-zsh-config
build_mzc() {
	msg "Build manjaro-zsh-config..."
	cd build
	git clone https://github.com/Chrysostomus/manjaro-zsh-config
	cd manjaro-zsh-config
	patching manjaro-zsh-config
	install -D -m644 .zshrc -t "${HOME}/"															# patched
	install -D -m644 manjaro-zsh-config -t "${_D_zsh_confdir}/"					# patched
	install -D -m644 manjaro-zsh-prompt -t "${_D_zsh_confdir}/"					# patched
	install -D -m644 p10k.zsh -t "${_D_zsh_confdir}/"
	install -D -m644 p10k-portable.zsh -t "${_D_zsh_confdir}/"
	install -D -m644 command-not-found.zsh -t "${_D_zsh_confdir}/"			# patched
	msg "...manjaro-zsh-config done." && cd ../..
}

# zsh-history-substring-search
# https://github.com/zsh-users/zsh-history-substring-search
build_hss() {
	msg "Build history-substring-search..."
	cd build
	git clone https://github.com/zsh-users/zsh-history-substring-search
	cd zsh-history-substring-search
	install -D -m644 zsh-history-substring-search.zsh -t "${_D_zsh_confdir}/"
	msg "...history-substring-search done." && cd ../..
}

# zsh-theme-powerlevel10k
# https://github.com/romkatv/powerlevel10k
# https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=zsh-theme-powerlevel10k-git
build_p10k() {
	msg "Build powerlevel10k theme..."
	cd build
	git clone https://github.com/romkatv/powerlevel10k
	cd powerlevel10k/gitstatus
	./build -w
	cd ..
	find powerlevel10k -type f -exec install -D '{}' "${_D_zsh_confdir}/zsh-theme-{}" ';'
	make -C ${_D_zsh_confdir}/zsh-theme-powerlevel10k zwc minify
	msg "...powerlevel10k theme done." && cd ../..
}

# Work
msg "Start build Dragonfly zsh config:"
build_mzc
build_hss
build_p10k
cleaning
msg "Ready."

exit 0
