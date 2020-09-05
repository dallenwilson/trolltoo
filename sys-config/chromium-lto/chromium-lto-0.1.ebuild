# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="A set of CFLAGS/CXXFLAGS/LDFLAGS for building chromium with LTO enabled."
HOMEPAGE="https://github.com/InBetweenNames/gentooLTO/issues/127"

KEYWORDS="~amd64 ~x86"

SRC_URI=""

LICENSE="GPL-2+"
SLOT="0"
IUSE=""

pkg_preinst() {
	elog "Installing www-client/chromium env overrides."
	doins -r "${FILESDIR}/chromium" "/etc/portage/env/www-client/chromium"

}

