# Copyright 2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils linux-mod linux-info

COMMIT="2b8b4febb760410c01a9d50032ece85eccd7926f"

DESCRIPTION="Driver for it87/it86 series hardware monitoring chips."
HOMEPAGE="https://github.com/gamanakis/it87"
SRC_URI="https://github.com/gamanakis/it87/archive/${COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="kernel_linux"
RESTRICT="bindist"

COMMON="kernel_linux? ( >=sys-libs/glibc-2.6.1 )"
DEPEND="
	${COMMON}
	kernel_linux? ( virtual/linux-sources virtual/pkgconfig )
	"
RDEPEND="${COMMON}"

REQUIRED_USE="kernel_linux"

S="${WORKDIR}/it87-${COMMIT}"

CONFIG_CHECK="HWMON !SENSORS_IT87"

pkg_setup() {
	export DISTCC_DISABLE=1
	export CCACHE_DISABLE=1

	linux-mod_pkg_setup

	MODULE_NAMES="it87(kernel/drivers/hwmon)"
	BUILD_TARGETS="clean modules"
	BUILD_PARAMS="KVERSION=${KV_FULL} CC=$(tc-getCC)"
}

src_install() {
	linux-mod_src_install

	insinto /etc/modules-load.d/
	doins -r "${FILESDIR}/it87.conf"
}

pkg_postinst() {
	einfo "If module it87 fails to load at boot, and a manual insertion with modprobe"
	einfo "results in a device or resource busy error, you likely need to add"
	einfo "'acpi_enforce_resources=lax' to your kernel boot paramaters. Grub users"
	einfo "can do this in /etc/default/grub with the GRUB_CMDLINE_LINUX variable."
	einfo "Details available at: https://github.com/a1wong/it87/issues/1"
}
