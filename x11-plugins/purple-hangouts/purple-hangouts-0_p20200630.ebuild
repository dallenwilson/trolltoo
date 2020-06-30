# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="Hangouts Plugin for libpurple"
HOMEPAGE="https://bitbucket.org/EionRobb/purple-hangouts"

COMMIT="5db1007d9ae740c59c363a8918d658289069e675"
SRC_URI="https://github.com/EionRobb/purple-hangouts/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

KEYWORDS="~amd64"
S="${WORKDIR}/EionRobb-${PN}-${COMMIT_ID}"

LICENSE="GPL-3+"
SLOT="0"

RDEPEND="
	dev-libs/glib:2
	dev-libs/json-glib
	dev-libs/protobuf-c:=
	net-im/pidgin
	sys-libs/zlib"

DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	default

	# Does not respect CFLAGS
	sed -i Makefile -e 's/-g -ggdb//g' || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		PKG_CONFIG="$(tc-getPKG_CONFIG)"
}

src_install() {
	emake \
		PKG_CONFIG="$(tc-getPKG_CONFIG)" \
		DESTDIR="${ED}" \
		install

	einstalldocs
}
