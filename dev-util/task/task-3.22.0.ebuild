# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module bash-completion-r1 || exit

go-module_set_globals

DESCRIPTION="Task runner & build tool that aims to be simpler and easier to use than GNU Make"
HOMEPAGE="https://github.com/go-task/task"
LICENSE="MIT BSD Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip"

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/go-task/${PN^}.git"
else
	SRC_URI="https://github.com/go-task/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz
			https://gitlab.com/jerm-ebuilds/distfiles/-/raw/main/${PN}-deps-${PV}.tar.xz"
	KEWORDS="~amd64"
fi

IUSE=""
#https://github.com/go-task/task/archive/refs/tags/v3.19.0.tar.gz

BDEPEND="
	>=dev-lang/go-1.17.0
"
DEPEND=""
RDEPEND=""

src_unpack() {
	go-module_src_unpack
}

src_compile() {
	#GOBIN=$(pwd)/temp/bin go install github.com/go-task/task/v3/cmd/task@
	#ego env GOBIN "${WORKDIR}/bin"
	ego build -o task cmd/task/task.go || die "task build failed"
}

src_install() {
	dobin task
	dodoc -r docs/docs

	newbashcomp completion/bash/${PN}.bash ${PN}

	insinto /usr/share/zsh/site-functions/
	doins completion/zsh/_task

	insinto /usr/share/fish/vendor-completions.d/
	doins completion/fish/task.fish
}
