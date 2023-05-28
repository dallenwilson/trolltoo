# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="ffa5e620a9369dfe4e06e2551f2de4bdab1a21c6"

DESCRIPTION="D. Wilson's collection of bash scripts for managing his Gentoo system(s)"
HOMEPAGE="https://github.com/dallenwilson/emtools"
SRC_URI="https://github.com/dallenwilson/emtools/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	app-eselect/eselect-repository
	app-portage/gentoolkit
	sys-kernel/genkernel
	app-portage/eix
	sys-boot/grub
	"
RDEPEND="${DEPEND}"
BDEPEND=""

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
