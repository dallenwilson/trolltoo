# trolltoo
My personal ebuild overlay for Gentoo.

It mostly contains ebuilds sourced from other overlays, with source credit in the commit messages. I'm not so handy with masking things and don't like adding huge overlays for one package.

There are also several ebuilds that are available elsewhere, but were broken or outdated; I updated/fixed them for my own use. I've no doubt my copies here will become outdated and broken in turn.

It also contains a few ebuilds I wrote myself, software I needed for which gentoo packages simply weren't available. The driver for the RealTek 8821ce wifi chipset is chief among these, a Gentoo ebuild repackaging the fine work of tomaspinho available at https://github.com/tomaspinho/rtl8821ce for Arch and Ubuntu.

To add with Layman:
you@yourprompthere # layman -o https://raw.githubusercontent.com/dallenwilson/trolltoo/master/overlay.xml -f -a trolltoo
