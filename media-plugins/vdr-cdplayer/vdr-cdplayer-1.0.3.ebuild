# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="4"

inherit vdr-plugin eutils

DESCRIPTION="VDR : CD-Player plugin with CDDB and CD-Text support"
HOMEPAGE="http://www.uli-eckhardt.de/vdr/cdplayer.en.html"
SRC_URI="http://www.uli-eckhardt.de/vdr/download/${P}.tgz"

KEYWORDS="~amd64 ~x86"

SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0
	>=dev-libs/libcdio-0.8.0
	>=media-libs/libcddb-1.3.0"

src_compile() {
	append-ldflags $(no-as-needed)
	vdr-plugin_src_compile
}

src_install() {
	vdr-plugin_src_install

	insinto /etc/vdr/plugins/${VDRPLUGIN}
	doins "${S}"/contrib/cd.mpg
	dodoc "${S}"/contrib/cd.jpg
	dodoc "${S}"/contrib/convert.sh
	fowners -R vdr:vdr /etc/vdr/plugins/${VDRPLUGIN}
}

