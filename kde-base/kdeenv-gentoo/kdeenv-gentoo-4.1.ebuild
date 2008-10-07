# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit multilib

DESCRIPTION="Gentoo KDE env files."
HOMEPAGE="http://kde.gentoo.org/"
SLOT="4.1"

KEYWORDS="~amd64 ~x86"
IUSE="kdeprefix"
LICENSE="LGPL-2.1"

PDEPEND="kde-base/kdelibs"

src_install() {
	if use kdeprefix; then
		KDEDIR="/usr/kde/${SLOT}"

		dodir /etc/env.d
		dodir /etc/revdep-rebuild

		# List all the multilib libdirs
		local _libdir _libdirs
		for _libdir in $(get_all_libdirs); do
			_libdirs="${_libdirs}:${KDEDIR}/${_libdir}"
		done
		_libdirs=${_libdirs#:}

		cat <<-EOF > "${T}"/42kdepaths
PATH="${KDEDIR}/bin"
ROOTPATH="${KDEDIR}/sbin:${KDEDIR}/bin"
LDPATH="${_libdirs}"
MANPATH="${KDEDIR}/share/man"
CONFIG_PROTECT="${KDEDIR}/share/config ${KDEDIR}/env ${KDEDIR}/shutdown /usr/share/config"
XDG_DATA_DIRS="/usr/share:${KDEDIR}/share:/usr/local/share"
COLON_SEPARATED="XDG_DATA_DIRS"
EOF
	else	# Not using kdeprefix and so things are a lot simpler
		cat <<-EOF > "${T}"/42kdepaths
CONFIG_PROTECT="usr/share/config"
XDG_DATA_DIRS="/usr/share:/usr/local/share"
COLON_SEPARATED="XDG_DATA_DIRS"
EOF
	fi
	doenvd "${T}"/42kdepaths

	# Make sure 'source /etc/profile' doesn't hose the PATH - only needed
	# with KDE installed into the KDE prefix
	if use kdeprefix; then
		KDEDIR="/usr/kde/${SLOT}"
		dodir /etc/profile.d
		cat <<-'EOF' > "${D}"/etc/profile.d/42kdereorderpaths.sh
if [ -n "${KDEDIR}" ]; then
	export PATH=${KDEDIR}/bin:$(echo ${PATH} | sed "s#${KDEDIR}/s\?bin:##g")
	export ROOTPATH=${KDEDIR}/sbin:${KDEDIR}/bin:$(echo ${PATH} | sed "s#${KDEDIR}/s\?bin:##g")
fi
EOF

		cat <<-EOF > "${D}/etc/revdep-rebuild/50-kde-${SLOT}"
SEARCH_DIRS="${KDEDIR}/bin ${KDEDIR}/lib*"
EOF
	fi
}
