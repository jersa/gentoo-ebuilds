# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="A graphical logout/suspend/reboot/shutdown dialog for wayland"
HOMEPAGE="https://github.com/loserMcloser/waylogout"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/loserMcloser/${PN^}.git"
else
	SRC_URI="https://github.com/loserMcloser/${PN^}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

LICENSE="MIT"
SLOT="0"
IUSE="+gdk-pixbuf +man"

BDEPEND="
	man? ( >=app-text/scdoc-1.9.2 )
	gdk-pixbuf? ( x11-libs/gdk-pixbuf:2 )
	virtual/pkgconfig
"
DEPEND="
	dev-libs/wayland
	dev-libs/wayland-protocols
	x11-libs/libxkbcommon
	x11-libs/cairo
	media-fonts/fontawesome
"
RDEPEND="${DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_feature gdk-pixbuf gdk-pixbuf)
		$(meson_feature man man-pages)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
}
