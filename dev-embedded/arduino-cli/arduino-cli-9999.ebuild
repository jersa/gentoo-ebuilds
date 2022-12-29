# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

go-module_set_globals

DESCRIPTION="Arduino command line interface (git source)"
HOMEPAGE="https://arduino.github.io/arduino-cli"
LICENSE="GPL-3"
SLOT="9999"
KEYWORDS="**amd64"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/arduino/${PN}.git"
	SRC_URI="${PN}-deps-${PV}.tar.xz"
else
	SRC_URI="https://github.com/arduino/${PN^}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
fi

# eventually add these
#IUSE="tests grpc"

BDEPEND="
	>=dev-lang/go-1.17.0
"
DEPEND=""
RDEPEND=""

src_unpack() {
	git-r3_src_unpack
	go-module_src_unpack
}

src_prepare() {
	#go-module_setup_proxy
	#env GOBIN=${WORKDIR}/bin GOPROXY="direct" go get -u github.com/go-task/task/v3/v3@3.19.0
	default
}

src_compile() {
	/var/tmp/portage/dev-embedded/arduino-cli-9999/bin/task build || die "task build failed"
}


# src_compile() {
# 	"${WORKDIR}/bin/task build" || die "task build failed"
# }

src_install() {
	dobin ${PN}
	default
}
