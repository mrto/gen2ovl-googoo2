# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

VERSION="1318" # every bump new version

DESCRIPTION="VDR Plugin: browse fast the EPG information without being forced to switch to a channel"
HOMEPAGE="http://projects.vdr-developer.org/projects/show/plg-zappilot"
SRC_URI="mirror://vdr-developerorg/${VERSION}/${P}.tgz"

KEYWORDS="amd64 x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=media-video/vdr-1.6.0"
RDEPEND="${DEPEND}"
