# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit udev

DESCRIPTION="udev rules for connecting to Android devices with ADB"
HOMEPAGE="https://github.com/M0Rf30/android-udev-rules"
#SRC_URI="https://raw.githubusercontent.com/M0Rf30/android-udev-rules/main/51-android.rules"
SRC_URI="https://github.com/M0Rf30/android-udev-rules/archive/refs/heads/main.zip"
RESTRICT="mirror"
LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64"

# Source directory; the dir where the sources can be found (automatically
# unpacked) inside ${WORKDIR}.  The default value for S is ${WORKDIR}/${P}
# If you don't need to change it, leave the S= line out of the ebuild
# to keep it tidy.
S="${WORKDIR}/${PN}-main"

BDEPEND="app-arch/unzip"
RDEPEND="virtual/udev
	dev-util/android-tools
	acct-group/android"
DEPEND="${RDEPEND}"

src_prepare() {

	# use the group name 'android', which is already present in Gentoo's uid-gid.txt, instead of 'adbusers'
	sed -i -e 's/GROUP=\"adbusers\"/GROUP=\"android\"/' 51-android.rules
	eapply_user
}

src_compile() {
	# cannot be empty
	:
}

src_install() {
	#insinto /lib/udev/rules.d/
	#doins 51-android.rules
	udev_dorules 51-android.rules
}

pkg_postinst() {
	udev_reload

	ewarn "Users who need access to Android devices using adb "
	ewarn "will need to be added to the android group."
}

pkg_postrm() {
	udev_reload
}
