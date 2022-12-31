# Copyright 2018-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod

COMMIT="50c1b120b06a3b0805e23ca9a4dbd274d74bb305"

DESCRIPTION="ReatlTek 8821ce wifi driver"
HOMEPAGE="https://github.com/tomaspinho/rtl8821ce/"
SRC_URI="https://github.com/tomaspinho/rtl8821ce/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kernel_linux"
RESTRICT="bindist"

COMMON="kernel_linux? ( >=sys-libs/glibc-2.36 )"
DEPEND="
	${COMMON}
	dev-util/pahole
	kernel_linux? (	virtual/linux-sources virtual/pkgconfig	)
	"
RDEPEND="${COMMON}"

REQUIRED_USE="kernel_linux"

S="${WORKDIR}/rtl8821ce-${COMMIT}"

PATCHES=( "${FILESDIR}"/use-correct-kernel.patch )

pkg_setup() {
	export DISTCC_DISABLE=1
	export CCACHE_DISABLE=1

	linux-mod_pkg_setup
	export KVER="${KV_FULL}"

	MODULE_NAMES="8821ce(net/wireless)"
	BUILD_TARGETS="clean modules"
}

src_prepare() {
	if kernel_is lt 4 14 0 ; then
		eerror "You must build this against 4.14.0 or higher kernels."
	fi
	default
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install

	# Make it load
	insinto /etc/modules-load.d/
	doins -r "${FILESDIR}/rtl8821ce.conf"
}

pkg_preinst() {
	linux-mod_pkg_preinst
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "This ebuild will be removed from overlay trolltoo at some point after 2023-02-01."
	elog "The in-kernel rtw88 driver's support for the 8821ce chipset has come a long way,"
	elog "and I no longer need to maintain an ebuild for this driver for my own use."
}

pkg_postrm() {
	linux-mod_pkg_postrm
}
