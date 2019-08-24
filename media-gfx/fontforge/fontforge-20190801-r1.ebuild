# Copyright 2004-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit python-single-r1 xdg

DESCRIPTION="postscript font editor and converter"
HOMEPAGE="http://fontforge.github.io/"
SRC_URI="https://github.com/fontforge/fontforge/releases/download/${PV}/fontforge-${PV}.tar.gz"

LICENSE="BSD GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="iconv debug cairo truetype-debugger gif gtk jpeg png +python readline test tiff svg unicode X woff2 spiro"

RESTRICT="!test? ( test )"

REQUIRED_USE="
	cairo? ( png )
	gtk? ( cairo )
	python? ( ${PYTHON_REQUIRED_USE} )
	test? ( png python )
"

RDEPEND="
	dev-libs/glib
	dev-libs/libltdl:0
	dev-libs/libxml2:2=
	>=media-libs/freetype-2.3.7:2=
	cairo? (
		>=x11-libs/cairo-1.6:0=
		x11-libs/pango:0=
	)
	gif? ( media-libs/giflib:0= )
	jpeg? ( virtual/jpeg:0 )
	png? ( media-libs/libpng:0= )
	tiff? ( media-libs/tiff:0= )
	truetype-debugger? ( >=media-libs/freetype-2.3.8:2[fontforge,-bindist(-)] )
	gtk? ( >=x11-libs/gtk+-3.10:3 )
	python? ( ${PYTHON_DEPS} )
	readline? ( sys-libs/readline:0= )
	unicode? ( media-libs/libuninameslist:0= )
	X? (
		x11-libs/libX11:0=
		x11-libs/libXi:0=
		>=x11-libs/pango-1.10:0=[X]
	)
	!media-gfx/pfaedit
	woff2? ( media-libs/woff2 )
	spiro? ( media-libs/libspiro )
"
DEPEND="${RDEPEND}
	X? ( x11-base/xorg-proto )
"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	local myeconfargs=(
		--disable-static
		--enable-fontforge-extras
		$(use_enable truetype-debugger freetype-debugger "${EPREFIX}/usr/include/freetype2/internal4fontforge")
		$(use_enable python python-extension)
		$(use_enable python python-scripting)
		--enable-tile-path
		$(use_with cairo)
		$(use_with gif giflib)
		$(use_with jpeg libjpeg)
		$(use_with png libpng)
		$(use_with readline libreadline)
		$(use_with spiro libspiro)
		$(use_with tiff libtiff)
		$(use_with unicode libuninameslist)
		$(use_with X x)
		$(use_enable woff2 woff2)
		$(use_with iconv iconv)
		$(use_enable debug debug)
	)
	if use gtk; then
		# broken AC_ARG_ENABLE usage
		# https://bugs.gentoo.org/681550
		myeconfargs+=( --enable-gdk=gdk3 )
	fi
	econf "${myeconfargs[@]}"
}
