# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

go-module_set_globals

DESCRIPTION="Arduino command line interface"
HOMEPAGE="https://arduino.github.io/arduino-cli"
SRC_URI="https://github.com/arduino/${PN}/archive/refs/tags/${PV}.tar.gz arduino-cli-deps-0.29.0.tar.xz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build -v || die "go build failed"
}

src_install() {
	dobin ${PN}
	default
}
