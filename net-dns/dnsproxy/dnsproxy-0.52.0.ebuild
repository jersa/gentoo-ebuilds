# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module || exit

DESCRIPTION="A simple DNS proxy server that supports all existing DNS protocols"
HOMEPAGE="https://github.com/AdguardTeam/dnsproxy"
LICENSE="Apache-2.0 Unlicense MIT BSD"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
RESTRICT="strip"

SRC_URI="https://github.com/AdguardTeam/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
		# https://gitlab.com/jerm-ebuilds/distfiles/-/raw/main/${PN}-deps-${PV}.tar.xz"

IUSE=""

BDEPEND="
	>=dev-lang/go-1.19.0
"
DEPEND=""
RDEPEND=""
PATCHES=( "${FILESDIR}/dnsproxy-makefile.patch" )

src_unpack() {
	go-module_src_unpack
}
src_configure() {
	GOFLAGS="-x -mod=vendor"
}

src_install() {
	dosbin dnsproxy
	dodoc README.md
	docompress -x config.yaml.dist
	dodoc config.yaml.dist
}

# src_test() {
# 	einfo "Skipping tests..."
# }
