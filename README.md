# trolltoo
My personal ebuild overlay for Gentoo.

It mostly contains ebuilds sourced from other overlays, with source credit in the commit messages. I'm not so handy with masking things, and don't like adding large overlays for only one package.

There are also several ebuilds that are available elsewhere, but were broken or outdated; I updated/fixed them for my own use. I've no doubt my copies here will become outdated and broken in turn.

Lastly are the ebuilds I wrote myself, software I needed for which gentoo packages simply weren't available.
- RealTek 8821ce wifi/bluetooth kernel driver, using the fine work of tomaspinho (https://github.com/tomaspinho/rtl8821ce) which targets Arch and Ubuntu but works perfectly fine for Gentoo as well.
- Gnome SSH Tunnel Manager, updated for Gtk3 and maintained by myself at https://github.com/dallenwilson/gstm

To add with Layman:
you@yourprompthere # layman -o https://raw.githubusercontent.com/dallenwilson/trolltoo/master/overlay.xml -f -a trolltoo
