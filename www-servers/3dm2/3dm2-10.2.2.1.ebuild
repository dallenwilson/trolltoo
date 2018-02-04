# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id: 04b27a2471afc8fc4fa9d00520bd604d1fd69572 $

EAPI=5

case "${PV//./-}" in
	10-2-2-1)
		CV="9.5.5.1"
		;;
esac

DESCRIPTION="3ware 3DM2 CLI Linux from the 10.2.2.1/9.5.5.1 code set 8xxx/95xx/96xx/97xx"
HOMEPAGE="http://www.avagotech.com/support/download-search"
SRC_URI="http://docs.avagotech.com/docs-and-downloads/raid-controllers/raid-controllers-common-files/3DM2_CLI-linux_${PV//./-}_${CV//./-}.zip"
RELNOTES="http://www.lsi.com/downloads/Public/SATA/SATA%20Common%20Files/${PV}_Release_Notes.pdf"

# Note: 3ware gave permission to redistribute the binaries before:
# Ref: https://bugs.gentoo.org/show_bug.cgi?id=60690#c106
#
# Please note that the LSI-tw_cli license does allow redistribution, despite
# being a EULA:
# 2. Grant of Rights
# 2.1 LSI Binary Code. Subject to the terms of this Agreement, LSI grants
# to Licensee a non-exclusive, world-wide, revocable (for breach in
# accordance with Section 7), non-transferable limited license, without
# the right to sublicense except as expressly provided herein, solely to:
# (c) Distribute the LSI Binary Code as incorporated in Licensee's
# Products or for use with LSI Devices to its Subsequent Users;
# (d) Distribute the Explanatory Materials related to LSI Binary Code only
# for use with LSI Devices;
#
# 3. License Restrictions
# 3.1. LSI Binary Code. The Licenses granted in Section 2.1 for LSI Binary
# Code and related Explanatory Materials are subject to the following
# restrictions:
# (a) Licensee shall not use the LSI Binary Code and related Explanatory
# Materials for any purpose other than as expressly provided in Article 2;
# (b) Licensee shall reproduce all copyright notices and other proprietary
# markings or legends contained within or on the LSI Binary Code and
# related Explanatory Materials on any copies it makes; and
LICENSE="LSI-tw_cli"
SLOT="0"

# This package can never enter stable, it can't be mirrored and upstream
# can remove the distfiles from their mirror anytime.
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RESTRICT="mirror strip"
QA_PREBUILT="/opt/3ware/3DM2/3dm2"

# binary packages
DEPEND="app-arch/unzip
	app-arch/tar"
RDEPEND=""

S="${WORKDIR}"

src_unpack() {
	default_src_unpack
	tar -xzpf tdmCliLnx.tgz || die "Embedded unpack failed: ${?}"
}

src_prepare() {
	sed -i \
		-e '/^EmailEnable /s/ .*$/ 1/' \
		-e '/^EmailSender /s/ .*$/ 3dm2/' \
		-e '/^EmailServer /s/ .*$/ localhost/' \
		-e '/^EmailRecipient /s/ .*$/ root/' \
		-e '/^RemoteAccess /s/ .*$/ 0/' \
		3dm2.conf
}

src_install() {
	if false; then
		# Traditional 3ware filesystem layout
		dodir /opt/3ware/3DM2{,/msg,/help}
		exeinto /opt/3ware/3DM2
		case ${ARCH} in
			amd64)
				newexe 3dm2u.x86_64 3dm2
				;;
			x86)
				newexe 3dm2u.x86 3dm2
				;;
		esac
		dosym /opt/3ware/3DM2/3dm2 /usr/sbin/3dm2

		tar -xzpf tdm2Msg.tgz -C "${ED}"/opt/3ware/3DM2/msg
		tar -xzpf tdm2Help.tgz -C "${ED}"/opt/3ware/3DM2/help
	else
		# Modern layout
		case ${ARCH} in
			amd64)
				newsbin 3dm2u.x86_64 3dm2
				;;
			x86)
				newsbin 3dm2u.x86 3dm2
				;;
		esac
		
		tar -xzpf tdm2Msg.tgz
		dodir /usr/share/${PN}/msg
		insinto /usr/share/${PN}/msg
		doins tdm_msg_en tw_msg_en

		mkdir html
		tar -xzpf tdm2Help.tgz -C html
		dodoc -r html

		sed -i \
			-e "/^MsgPath /s| .*$| /usr/share/${PN}/msg|" \
			-e "/^Help /s| .*$| /usr/share/doc/${PF}/html|" \
			3dm2.conf
	fi

	dodir /etc/3dm2
	insinto /etc/3dm2
	doins logo.gif
	insopts "-m0600"
	doins 3dm2.conf

	doman "${FILESDIR}"/"${PN}".8

	newinitd "${FILESDIR}"/"${PN}".initd "${PN}"
}

pkg_postinst() {
	elog "3DM2 listens on https://127.0.0.1:888/ by default."
	ewarn "For security reasons, only local connections are allowed by default."
	elog "This behavior can be modified by setting 'RemoteAccess 1' in"
	elog "/etc/3dm2/3dm2.conf and restarting the service."
	elog
	ewarn "The default passwords for both user and administrator are '3ware'."
	eerror "PLEASE CHANGE THESE PASSWORDS *BEFORE* ENABLING REMOTE ACCESS"
	elog
	elog "Release notes for this version are available at:"
	elog "${RELNOTES}"
}
