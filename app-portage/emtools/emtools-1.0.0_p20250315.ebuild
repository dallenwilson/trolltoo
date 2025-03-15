# Copyright 2019-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

COMMIT="dc8f7a49d1f0dc9218e5d9a511d1276350b51dd9"

DESCRIPTION="D. Wilson's collection of bash scripts for managing his Gentoo system(s)"
HOMEPAGE="https://github.com/dallenwilson/emtools"
SRC_URI="https://github.com/dallenwilson/emtools/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="
	app-eselect/eselect-repository
	app-portage/gentoolkit
	sys-kernel/installkernel[ugrd,grub]
	app-portage/eix
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
