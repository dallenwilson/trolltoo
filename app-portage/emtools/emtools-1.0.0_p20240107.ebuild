# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="bb16da2ee354a0b3175a7d68691060deb07d3226"

DESCRIPTION="D. Wilson's collection of bash scripts for managing his Gentoo system(s)"
HOMEPAGE="https://github.com/dallenwilson/emtools"
SRC_URI="https://github.com/dallenwilson/emtools/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	app-eselect/eselect-repository
	app-portage/gentoolkit
	sys-kernel/genkernel
	app-portage/eix
	sys-boot/grub
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/emtools-${COMMIT}"

src_install() {
	dobin emconfigkernel
	dobin emmakekernel

	dobin emsync
	dobin emfetch
	dobin emupdate

	dobin emtidy
	dobin emwhen
	dobin emgcc

	insinto /etc
	doins emtools.conf
}
