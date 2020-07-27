# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Based on previous aosp-devel-meta ebuild from the vortex overlay.

EAPI=7

DESCRIPTION="Meta package providing AOSP build environment"
HOMEPAGE="https://source.android.com/source/initializing"

LICENSE="metapackage"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="multilib"

# Moved these here to satisfy repoman
DEPEND="
	dev-util/gperf
	sys-devel/bison
	sys-devel/flex
	"

RDEPEND="
	app-crypt/gnupg
	app-arch/zip[-natspec]
	app-arch/unzip
	dev-libs/libxslt
	dev-libs/libxml2
	dev-util/android-tools
	dev-util/ccache
	dev-vcs/git
	media-libs/libsdl
	media-libs/mesa
	net-misc/curl
	net-misc/rsync
	sys-devel/bc
	sys-devel/gcc[cxx]
	multilib? ( sys-libs/ncurses[abi_x86_32] )
	multilib? ( sys-libs/readline[abi_x86_32] )
	multilib? ( sys-libs/zlib[abi_x86_32] )
	sys-process/schedtool
	sys-fs/squashfs-tools
	x11-base/xorg-proto
	x11-libs/libGLw
	x11-libs/libX11
	=x11-libs/wxGTK-3.0.4-r302
"
