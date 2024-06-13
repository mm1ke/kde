# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

KFMIN=6.3.0
PVCUT=$(ver_cut 1-3)
QTMIN=6.7.1
inherit ecm plasma.kde.org

DESCRIPTION="Friendly onboarding wizard for Plasma"

LICENSE="GPL-2+"
SLOT="6"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	>=dev-qt/qtbase-${QTMIN}:6[gui,network,widgets]
	>=dev-qt/qtdeclarative-${QTMIN}:6[widgets]
	>=dev-qt/qtsvg-${QTMIN}:6
	>=kde-frameworks/kconfig-${KFMIN}:6
	>=kde-frameworks/kconfigwidgets-${KFMIN}:6
	>=kde-frameworks/kcoreaddons-${KFMIN}:6
	>=kde-frameworks/kdbusaddons-${KFMIN}:6
	>=kde-frameworks/ki18n-${KFMIN}:6
	>=kde-frameworks/kio-${KFMIN}:6
	>=kde-frameworks/kirigami-${KFMIN}:6
	>=kde-frameworks/kjobwidgets-${KFMIN}:6
	>=kde-frameworks/knewstuff-${KFMIN}:6
	>=kde-frameworks/kservice-${KFMIN}:6
	>=kde-frameworks/ksvg-${KFMIN}:6
	>=kde-frameworks/kwindowsystem-${KFMIN}:6
	>=kde-plasma/libplasma-${PVCUT}:6
"
RDEPEND="${DEPEND}"