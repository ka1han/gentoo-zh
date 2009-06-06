# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

ESVN_REPO_URI="http://tint2.googlecode.com/svn/trunk"
inherit subversion toolchain-funcs

DESCRIPTION="tint2 is a lightweight panel/taskbar based on ttm code"
HOMEPAGE="http://tint2.googlecode.com"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/glib:2
	x11-libs/cairo
	x11-libs/pango
	x11-libs/libX11
	x11-libs/libXinerama
	media-libs/imlib2"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/xineramaproto
	dev-util/pkgconfig"

src_prepare() {
	mv src/* .
	sed -i \
		-e 's/^\(install: install-\)\(strip\)$/\1no\2/' \
		-e 's/\.\./\./g' \
		Makefile || die "failed sed Makefile"
}

src_compile() {
	emake CC="$(tc-getCC)" LDFLAGS="${LDFLAGS}" CFLAGS="${CFLAGS}" ||die
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc ChangeLog README tintrc* doc/tint2*
}