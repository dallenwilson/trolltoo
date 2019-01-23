# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit autotools

DESCRIPTION="extensions for cinnamon's file-manager nemo"
HOMEPAGE="https://github.com/linuxmint/nemo-extensions"
SRC_URI="https://github.com/linuxmint/nemo-extensions/archive/${PV}.zip -> ${P}.zip"
LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
LICENSE="GPL-2"

#IUSE="dropbox fileroller seahorse share pastebin compare -python rabbitvcs -terminal gtkhash filenamerepairer imageconverter audiotab"
#REQUIRED_USE="terminal? ( python )"

IUSE="fileroller"

MODULES=${IUSE}

DEPEND="( =gnome-extra/nemo-3.6* )
		fileroller? ( app-arch/file-roller )"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
}

src_prepare () {
	for module in ${MODULES}
		do
		if use ${module}
			then
			elog "Preparing ${module}"
			pushd nemo-${module}
			eautoreconf
			popd
		fi
	done
}

src_configure () {
	for module in ${MODULES}
		do
		if use ${module}
		then
			elog "Configuring ${module}"
			pushd nemo-${module}
			econf
			popd
		fi
	done
}

src_compile () {
	for module in ${MODULES}
		do
		if use ${module}
		then
			elog "Compiling ${module}"
			pushd nemo-${module}
			emake
			popd
		fi
	done
}

src_install () {
	for module in ${MODULES}
		do
		if use ${module}
			then
			elog "Installing ${module}"
			pushd nemo-${module}
			emake DESTDIR="${D}" install
			elog "Removing .a and .la files"
			find "${D}" -name "*.a" -exec rm {} + -o -name "*.la" -exec rm {} + || die
			dodoc README
			popd
		fi
	done
}
