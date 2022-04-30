# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake udev

COMMIT="d81e0f5bc2aeff2bc6350df691a13f899645932f"
SRC_URI="https://git.sr.ht/~grimler/Heimdall/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64"
S="${WORKDIR}/Heimdall-${COMMIT}"

DESCRIPTION="Tool suite used to flash firmware onto Samsung devices"
HOMEPAGE="https://git.sr.ht/~grimler/Heimdall/"

LICENSE="MIT"
SLOT="0"
IUSE="gui"

RDEPEND="
	sys-libs/zlib
	virtual/libusb:1=
	gui? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
	)"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_configure() {
	local mycmakeargs=(
		-DDISABLE_FRONTEND=$(usex !gui)
	)
	cmake_src_configure
}

src_install() {
	dobin "${BUILD_DIR}"/bin/heimdall
	use gui && dobin "${BUILD_DIR}"/bin/heimdall-frontend
	udev_dorules heimdall/60-heimdall.rules
	dodoc README.md Linux/README
}
