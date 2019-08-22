# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PARTS_P="${PN}-parts-${PV}"

inherit qmake-utils eutils xdg-utils

DESCRIPTION="Electronic Design Automation"
HOMEPAGE="http://fritzing.org/"
SRC_URI="https://github.com/fritzing/fritzing-app/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/fritzing/fritzing-parts/archive/${PV}.tar.gz -> ${PARTS_P}.tar.gz"

LICENSE="CC-BY-SA-3.0 GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtconcurrent:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtserialport:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	>=dev-libs/quazip-0.7.2"
DEPEND="${RDEPEND}
	>=dev-libs/boost-1.55
	>=dev-libs/libgit2-0.25.0"

S="${WORKDIR}/${PN}-app-${PV}"

DOCS="readme.md"

src_prepare() {
	local lang translations=

	# fix build with newer quazip - bug #597988
	sed -i -e "s/#include <quazip/&5/" src/utils/folderutils.cpp || die
	sed -i -e "s|/usr/include/quazip|&5|" -e "s/-lquazip/&5/" phoenix.pro || die

	# Get a rid of the bundled libs
	# Bug 412555 and
	# https://code.google.com/p/fritzing/issues/detail?id=1898
	rm -rf src/lib/quazip/ pri/quazip.pri src/lib/boost* || die

	# Fritzing expects libgit2 to be at "../libgit2/".
	# Remove that check and use standard system locations.
	epatch "${FILESDIR}/${PV}-remove-libgit2-checks.patch"

	# Update libgit2 function call to allow use with versions >=libgit2-0.25.0
	# Fix found and supplied by tenspd137 on github issue #1: https://github.com/dallenwilson/trolltoo/issues/1
	epatch "${FILESDIR}/${PV}-update-libgit2-functions.patch"

	# Fritzing checks for a 'bad' version of Boost (1.54), using Debian-specific methods (dpkg).
	# Remove that check, ebuild requires >=1.55 to handle that problem.
	epatch "${FILESDIR}/${PV}-remove-bad-boost-check.patch"

	# Fritzing doesn't need zlib
	sed -i -e 's:LIBS += -lz::' -e 's:-lminizip::' phoenix.pro || die

	# Somewhat evil but IMHO the best solution
	for lang in $L10N; do
		lang=${lang/linguas_}
		[[ -f "translations/${PN}_${lang}.qm" ]] && translations+=" translations/${PN}_${lang}.qm"
	done
	if [[ -n "${translations}" ]]; then
		sed -i -e "s:\(translations.extra =\) .*:\1	cp -p ${translations} \$(INSTALL_ROOT)\$\$PKGDATADIR/translations\r:" phoenix.pro || die
	else
		sed -i -e "s:translations.extra = .*:\r:" phoenix.pro || die
	fi

	# Not sure if Fritzing bug, compile-screwup here in ebuild, or intentional
	# but Fritzing looks for it's parts in whatever directory you launch it from,
	# ignoring -f path/to/parts option completely. Add start-script and patch
	# desktop entry to use it.
	epatch "${FILESDIR}/${PV}-add-start-script.patch"

	default
}

src_configure() {
	eqmake5 DEFINES=QUAZIP_INSTALLED phoenix.pro
}

src_install() {
	INSTALL_ROOT="${D}" default

	insinto /usr/share/fritzing/parts
	doins -r "${WORKDIR}/${PARTS_P}"/*

	# Install new launch script
	exeinto /usr/bin
	doexe "$S/fritzing.sh"
}

pkg_postinst() {
	# The QA Notice told me to
	xdg_desktop_database_update

}

pkg_postrm() {
	# The QA Notice told me to
	xdg_desktop_database_update
}
