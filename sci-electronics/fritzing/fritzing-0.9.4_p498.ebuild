# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

# v0.9.4 = CD-498. Apparently.
APP_CODE="CD-498"

# Borrow the parts db from the ubuntu release
UBUNTU_RELEASE="fritzing-a1ffcea08814801903b1a9515b18cf97067968ae-master-498.bionic.linux.AMD64"

inherit qmake-utils xdg-utils

DESCRIPTION="Electronic Design Automation"
HOMEPAGE="http://fritzing.org/"
SRC_URI="https://github.com/fritzing/fritzing-app/archive/${APP_CODE}.tar.gz -> ${P}.tar.gz
		https://github.com/fritzing/fritzing-app/releases/download/CD-498/fritzing-a1ffcea08814801903b1a9515b18cf97067968ae-master-498.bionic.linux.AMD64.tar.bz2"

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
	>=dev-libs/libgit2-0.28.1"

S="${WORKDIR}/${PN}-app-${APP_CODE}"

DOCS="README.md"

PATCHES=(
	"${FILESDIR}/disable-static-libgit2.patch"
)

src_prepare() {
	local lang translations=

	# fix build with newer quazip - bug #597988
	sed -i -e "s/#include <quazip/&5/" src/utils/folderutils.cpp || die
	sed -i -e "s|/usr/include/quazip|&5|" -e "s/-lquazip/&5/" phoenix.pro || die

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

	default
}

src_configure() {
	eqmake5 DEFINES=QUAZIP_INSTALLED phoenix.pro
}

src_install() {
	INSTALL_ROOT="${D}" default

	insinto /usr/share/fritzing/fritzing-parts/
	doins -r "${WORKDIR}/${UBUNTU_RELEASE}/fritzing-parts"/*
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}
