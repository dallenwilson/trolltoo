# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Displays the system activity in a very special way ;-)"
HOMEPAGE="https://sourceforge.net/projects/hotbabe"
SRC_URI="mirror://sourceforge/${PN/-}/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}"/${P}-makefile.patch )

src_install() {
	emake DESTDIR="${D}" install

	newman ${PN}.1 ${PN}.6
}
