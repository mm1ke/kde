# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

KMNAME="kdepim"
KMNOMODULE="true"
inherit kde4-meta

DESCRIPTION="Common libraries for KDE PIM apps"
KEYWORDS=""
IUSE="debug"

DEPEND="
	app-crypt/gpgme
	>=app-office/akonadi-server-1.3.60
	$(add_kdebase_dep kdelibs 'semantic-desktop')
	$(add_kdebase_dep kdepimlibs 'akonadi')
"
RDEPEND="${DEPEND}
	app-crypt/gnupg
	$(add_kdebase_dep kdepim-runtime)
"

# @Since >4.4.76 merged here
add_blocker akonadi
add_blocker libkdepim
add_blocker libkleo
add_blocker libkpgp
add_blocker messagecomposer
add_blocker messagecore
add_blocker messagelist
add_blocker messageviewer
add_blocker templateparser

KMEXTRA="
	akonadi/
	incidenceeditors/
	libkdepim/
	libkdepimdbusinterfaces/
	libkleo/
	libkpgp/
	messagecomposer/
	messagecore/
	messagelist/
	messageviewer/
	templateparser/
"

KMEXTRACTONLY="
	kdgantt1/
	kleopatra/
	kmail/
	knode/org.kde.knode.xml
	korganizer/korgac/org.kde.korganizer.KOrgac.xml
	korganizer/org.kde.korganizer.Korganizer.xml
	ontologies/
"

KMSAVELIBS="true"

#src_prepare() {
#	kde4-meta_src_prepare
#
#	sed -n -e '/qt4_generate_dbus_interface(.*org\.kde\.kmail\.\(kmail\|mailcomposer\)\.xml/p' \
#		-e '/add_custom_target(kmail_xml /,/)/p' \
#		-i kmail/CMakeLists.txt || die "uncommenting xml failed"
#}

src_configure() {
	mycmakeargs=(
		# Set the dbus dirs, otherwise it searches in KDEDIR
		-DAKONADI_DBUS_INTERFACES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/interfaces"
		-DAKONADI_DBUS_SERVICES_INSTALL_DIR="${EPREFIX}/usr/share/dbus-1/services"
	)

	kde4-meta_src_configure
}
