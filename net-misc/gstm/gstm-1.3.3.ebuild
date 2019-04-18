# Copyright 2019 Dallen Wilson
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="gSTM is a front-end for managing ssh tunneled port redirections"
HOMEPAGE="https://github.com/dallenwilson/gstm"
SRC_URI="https://github.com/dallenwilson/gstm/releases/download/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=x11-libs/gtk+-3.24.1
	dev-libs/libxml2
	>=dev-util/intltool-0.35.0
	"
RDEPEND="
	${DEPEND}
	net-misc/openssh
	"
BDEPEND=""
