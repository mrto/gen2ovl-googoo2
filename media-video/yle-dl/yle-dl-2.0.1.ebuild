# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="CLI tool for downloading media from finnish VoD services Yle Areena, Elävä Arkisto & YleX Areena"
HOMEPAGE="http://users.tkk.fi/~aajanki/rtmpdump-yle/"
SRC_URI="${HOMEPAGE}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=media-video/rtmpdump-2.4
	dev-python/pycrypto"

src_prepare() {

	sed -i "s:prefix=:prefix?=:" Makefile || die "Failed to sed prefix in makefile"

}

src_install() {

	einstall DESTDIR="${D}" prefix="/usr"
	dodoc README* ChangeLog

}
