# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit font

MY_PN="Meslo-Font"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Meslo LG is a customized version of Apple’s Menlo-Regular font"
HOMEPAGE="https://github.com/andreberg/Meslo-Font"
SRC_URI="https://github.com/andreberg/Meslo-Font/archive/refs/tags/v${PV}.tar.gz -> ${MY_P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~loong ~riscv ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	default
	unpack "${S}/dist/v${PV}/Meslo LG v${PV}.zip"
	unpack "${S}/dist/v${PV}/Meslo LG DZ v${PV}.zip"
}

src_install() {
	FONT_SUFFIX="ttf"

	FONT_S="${WORKDIR}/Meslo LG v${PV}" font_src_install
	FONT_S="${WORKDIR}/Meslo LG DZ v${PV}" font_src_install

	dodoc "${WORKDIR}/Meslo LG v${PV}/About Meslo LG v${PV}.pdf"
	dodoc "${WORKDIR}/Meslo LG DZ v${PV}/About Meslo LG DZ v${PV}.pdf"
}
