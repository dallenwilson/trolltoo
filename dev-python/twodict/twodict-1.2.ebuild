# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Simple two way ordered dictionary for Python"
HOMEPAGE="https://github.com/MrS0m30n3/twodict"
LICENSE="Unlicense"

SRC_URI="https://github.com/MrS0m30n3/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64 x86"

SLOT="0"
DEPEND=""
RDEPEND="${PYTHON_DEPS}"
