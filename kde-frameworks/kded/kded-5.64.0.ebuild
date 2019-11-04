# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

ECM_QTHELP="false"
ECM_TEST="false"
PVCUT=$(ver_cut 1-2)
QTMIN=5.12.3
inherit ecm kde.org

DESCRIPTION="Central daemon of KDE workspaces"
LICENSE="LGPL-2+"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE="+man"

BDEPEND="
	man? ( >=kde-frameworks/kdoctools-${PVCUT}:5 )
"
DEPEND="
	>=kde-frameworks/kconfig-${PVCUT}:5
	>=kde-frameworks/kcoreaddons-${PVCUT}:5
	>=kde-frameworks/kcrash-${PVCUT}:5
	>=kde-frameworks/kdbusaddons-${PVCUT}:5
	>=kde-frameworks/kinit-${PVCUT}:5
	>=kde-frameworks/kservice-${PVCUT}:5
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtgui-${QTMIN}:5
	>=dev-qt/qtwidgets-${QTMIN}:5
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_find_package man KF5DocTools)
	)

	ecm_src_configure
}
