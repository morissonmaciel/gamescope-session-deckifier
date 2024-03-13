_gitdir=gamescope-session-deckifier
pkgname=${_gitdir}-git
pkgver=r1.6835776
pkgrel=1
pkgdesc="Gamescope session for running Steam OS Deck interface with Decky Loader support."
arch=('any')
url="https://github.com/morissonmaciel/${_gitdir}"
license=('GPL')
depends=('gamescope' 'mangohud' 'lib32-mangohud' )
provides=('gamescope-session-deckifier')
makedepends=('git' 'jq')
source=("${_gitdir}::git+${url}.git")
md5sums=('SKIP')

pkgver() {
	# cd "$srcdir/${_gitdir}"
	# printf "r%s.%s" "$(git rev-list --count HEAD)" "$(git rev-parse --short HEAD)"
	printf "${pkgver}"
}

package() {
	# cd "$srcdir/${_gitdir}"
	cp -rv "rootfs/${srcdir}/${_gitdir}/usr/**" ${pkgdir}/usr

	# Ownering permissions
	sudo chmod 777 /usr/bin/jupiter-biosupdate
	sudo chmod 777 /usr/bin/steamos-update
	sudo chmod 777 /usr/bin/steamos-session-select
	# sudo chmod 777 /usr/bin/gamescope-session
	# sudo chmod 777 /usr/bin/return-to-gamemode

	# Enabling autologin and special powers for user
	sudo groupadd -r autologin
	sudo usermod -a -G autologin $USER
	sudo usermod -a -G wheel $USER

	# Preparing bluetooth for steamos session
	sudo systemctl enable bluetooth
	sudo systemctl start bluetooth --now
}