# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

go-module_set_globals

DESCRIPTION="Arduino command line interface (git source)"
HOMEPAGE="https://arduino.github.io/arduino-cli"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"

GH_DISTFILES="https://github.com/jersa/gentoo-ebuilds/blob/main/distfiles/"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/arduino/${PN}.git"
	SRC_URI="${GH_DISTFILES}${PN}-deps-${PV}.1.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.2.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.3.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.4.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.5.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.6.tar.xz"
else
	SRC_URI="https://github.com/arduino/${PN^}/archive/${PV}.tar.gz -> ${P}.tar.gz
			${GH_DISTFILES}${PN}-deps-${PV}.1.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.2.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.3.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.4.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.5.tar.xz
			${GH_DISTFILES}${PN}-deps-${PV}.6.tar.xz"

fi

# eventually add these
#IUSE="tests grpc"

BDEPEND="
	>=dev-util/task-0.17.0
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
	task build || die "task build failed"
}

# src_compile() {
# 	"${WORKDIR}/bin/task build" || die "task build failed"
# }

src_install() {
	dobin ${PN}
	default
}
