# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=2

inherit vdr-plugin git-2

EGIT_REPO_URI=${XBMC_EGIT_REPO_URI:-git://github.com/opdenkamp/xbmc.git}

DESCRIPTION="VDR plugin: VNSI Streamserver Plugin"
HOMEPAGE="https://github.com/opdenkamp/xbmc"
SRC_URI=""
KEYWORDS=""
LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND=">=media-video/vdr-1.6
	sys-libs/zlib"

RDEPEND="${DEPEND}"

src_prepare() {
	S="${WORKDIR}/${VDRPLUGIN}-${PV}/xbmc/pvrclients/vdr-vnsi/vdr-plugin-${VDRPLUGIN}"
	cd "${S}"
	vdr-plugin_src_prepare

	fix_vdr_libsi_include recplayer.c
	fix_vdr_libsi_include receiver.c
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins ${VDRPLUGIN}/allowed_hosts.conf
	diropts -gvdr -ovdr
}