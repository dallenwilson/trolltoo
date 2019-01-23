# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

GIT_REV="fa3de1d98cbf419c289c8e205943d54f82e6e02a"

DESCRIPTION="A cross platform front-end GUI of the popular youtube-dl written in wxPython"
HOMEPAGE="https://github.com/MrS0m30n3/youtube-dl-gui"
SRC_URI="https://api.github.com/repos/MrS0m30n3/youtube-dl-gui/tarball/${GIT_REV} -> ${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="ffmpeg"

RDEPEND="${PYTHON_DEPS}
	dev-python/wxpython:*[${PYTHON_USEDEP}]
	net-misc/youtube-dl
	ffmpeg? ( media-video/ffmpeg )"
DEPEND="${RDEPEND}"

S="${WORKDIR}/MrS0m30n3-${PN}-${GIT_REV:0:7}"
