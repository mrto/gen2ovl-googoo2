# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin-2 eutils

VERSION="936" #every bump, new version

DVDARCHIVE="dvdarchive-2.3-beta.sh"

DESCRIPTION="Video Disk Recorder - Extended recordings menu Plugin"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-extrecmenu"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz
	mirror://gentoo/${DVDARCHIVE}.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"

src_prepare() {

	cd "${WORKDIR}"
	epatch "${FILESDIR}/${DVDARCHIVE%.sh}-configfile.patch"

	cd "${S}"
	if grep -q fskProtection /usr/include/vdr/timers.h; then
		einfo "Enabling parentalrating option"
		sed -i "s:#WITHPINPLUGIN:WITHPINPLUGIN:" Makefile
	fi

	vdr-plugin-2_src_prepare

	if has_version ">=media-video/vdr-1.7.18"; then
		sed -e "s:Read(f):Read():" -i mymenueditrecording.c
	fi

#	if has_version ">=media-video/vdr-1.7.27"; then
#		epatch "${FILESDIR}/vdr-1.7.27.diff"
#	fi
}

src_install() {
	vdr-plugin-2_src_install

	cd "${WORKDIR}"
	newbin ${DVDARCHIVE} dvdarchive.sh

	insinto /etc/vdr
	doins "${FILESDIR}"/dvdarchive.conf
}
