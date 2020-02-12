# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on previous LineageOS 15.1 devel meta ebuild from the vortex overlay

EAPI=7

DESCRIPTION="Meta package providing LineageOS build environment"
HOMEPAGE="https://lineageos.org"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	app-arch/lz4
	app-arch/lzop
	~dev-util/aosp-devel-meta-9
	dev-libs/openssl
	media-gfx/imagemagick
	media-gfx/pngcrush
	media-libs/libsdl
"
