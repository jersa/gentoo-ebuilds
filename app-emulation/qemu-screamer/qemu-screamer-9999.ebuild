# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# inherit meson

DESCRIPTION="Audio-enabled fork of QEMU for PowerPC guests"
HOMEPAGE="https://github.com/mcayland/qemu/tree/screamer"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mcayland/qemu.git"
	EGIT_BRANCH='screamer'
	EGIT_CLONE_TYPE='shallow'
else
	EGIT_REPO_URI="https://github.com/mcayland/qemu.git"
	EGIT_BRANCH='screamer'
	EGIT_CLONE_TYPE='shallow'
fi

PATCHES=(
	"${FILESDIR}/screamer_curl.patch"
	"${FILESDIR}/screamer_meson.patch"
)

KEYWORDS="~amd64"
LICENSE="GPL-2 LGPL-2 BSD-2"
SLOT="0"
IUSE=""

BDEPEND="
	dev-lang/perl
	dev-util/meson
	sys-apps/texinfo
	virtual/pkgconfig
	sys-libs/ncurses
	x11-libs/pixman"

RDEPEND="${BDEPEND}"
DEPEND="${RDEPEND}"

# this only builds the ppc qemu_softmmu_target

src_configure() {
	local my_econf=(
		--target-list="ppc-softmmu"
	)

	econf "${my_econf[@]}"
}

src_compile() {
	cd build || exit
	emake
}

src_test() {
	return
}

src_install() {
	newbin build/qemu-system-ppc qemu-system-ppc-screamer
	into /
}
