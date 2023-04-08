# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

go-module_set_globals

DESCRIPTION="Arduino command line interface (git source)"
HOMEPAGE="https://arduino.github.io/arduino-cli"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

SRC_URI="https://github.com/arduino/${PN^}/archive/${PV}.tar.gz -> ${P}.tar.gz
		https://gitlab.com/jerm-ebuilds/distfiles/-/raw/main/${PN}-deps-${PV}.tar.xz"

# eventually add these
#IUSE="tests grpc"

BDEPEND="
	>=dev-util/task-3.21.0
	>=dev-lang/go-1.17.0
"
DEPEND=""
RDEPEND=""

src_unpack() {
	# git-r3_src_unpack
	go-module_src_unpack
}

src_prepare() {
	#go-module_setup_proxy
	#env GOBIN=${WORKDIR}/bin GOPROXY="direct" go get -u github.com/go-task/task/v3/v3@3.19.0
	default
}

src_compile() {
	task build || die "task build failed"
}

# src_compile() {
# 	"${WORKDIR}/bin/task build" || die "task build failed"
# }

src_install() {
	dobin ${PN}
	default
}
