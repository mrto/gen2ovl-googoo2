# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

inherit vdr-plugin-2

DESCRIPTION="Video Disk Recorder epgsearch plugin"
HOMEPAGE="http://winni.vdr-developer.org/epgsearch"

if [ "${PV}" = "9999" ]; then
	inherit git-2
	EGIT_REPO_URI="git://projects.vdr-developer.org/vdr-plugin-${VDRPLUGIN}.git"
	KEYWORDS=""
else
	case ${P#*_} in
		rc*|beta*)
			MY_P="${P/_/.}"
			SRC_URI="http://winni.vdr-developer.org/epgsearch/downloads/beta/${MY_P}.tgz"
			S="${WORKDIR}/${MY_P#vdr-}"
			;;
		*)
			SRC_URI="http://winni.vdr-developer.org/epgsearch/downloads/${P}.tgz"
			;;
	esac
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE="pcre tre linguas_de"

DEPEND=">=media-video/vdr-1.3.45
	pcre? ( dev-libs/libpcre )
	tre? ( dev-libs/tre )"
RDEPEND="${DEPEND}"

REQUIRED_USE="pcre? ( !tre )
	tre? ( !pcre )"

src_prepare() {
	vdr-plugin-2_src_prepare

	fix_vdr_libsi_include conflictcheck.c

	if has_version ">=media-video/vdr-1.7.28"; then
		sed -i "s:SetRecording(recording->FileName(), recording->Title:SetRecording(recording->FileName:" menu_searchresults.c
	fi

	# disable automagic deps
	sed -i Makefile -e '/^AUTOCONFIG=/s/^/#/'

	if use pcre; then
		einfo "Using pcre for regexp searches"
		sed -i Makefile -e 's:^#REGEXLIB = pcre:REGEXLIB = pcre:'
	fi

	if use tre; then
		einfo "Using tre for unlimited fuzzy searches"
		sed -i Makefile -e 's:^#REGEXLIB = pcre:REGEXLIB = tre:'
	fi

	# install conf-file disabled
	sed -e '/^Menu/s:^:#:' -i conf/epgsearchmenu.conf

	# Get a rid of the broken symlinks
	rm -f README{,.DE} MANUAL
}

src_install() {
	vdr-plugin-2_src_install

	diropts "-m755 -o vdr -g vdr"
	keepdir /etc/vdr/plugins/epgsearch
	insinto /etc/vdr/plugins/epgsearch

	doins conf/epgsearchmenu.conf
	doins conf/epgsearchconflmail.templ conf/epgsearchupdmail.templ

	dodoc conf/*.templ
}

pkg_preinst() {
	has_version "<${CATEGORY}/${PN}-0.9.18"
	previous_less_than_0_9_18=$?
}

pkg_postinst() {
	vdr-plugin-2_pkg_postinst
	if [[ $previous_less_than_0_9_18 = 0 ]] ; then
		elog "Moving config-files to new location /etc/vdr/plugins/epgsearch"
		cd "${ROOT}"/etc/vdr/plugins
		local f
		local moved=""
		for f in epgsearch*.* .epgsearch*; do
			[[ -e ${f} ]] || continue
			mv "${f}" "${ROOT}/etc/vdr/plugins/epgsearch"
			moved="${moved} ${f}"
		done
		elog "These files were moved:${moved}"
	fi
}
