# trolltoo
My personal ebuild overlay for Gentoo.

It mostly contains ebuilds sourced from other overlays, with source credit in the commit messages. I'm not so handy with masking things, and don't like adding large overlays for only one package.

There are also several ebuilds that are available elsewhere, but were broken or outdated; I updated/fixed them for my own use. I've no doubt my copies here will become outdated and broken in turn.

Lastly are the ebuilds I wrote myself, software I needed for which gentoo packages simply weren't available.
- A driver (usually used by lm-sensors) for the it87/it86 series of hardware monitor chips, supporting more chips than the in-tree kernel driver. The ebuild uses sources maintained by gamanakis (https://github.com/gamanakis/it87), though there are many, many forks available. If you have an AMD socket AM4 mainboard or a Ryzen processor, this driver is for you!
- The rtl8821ce wifi/bluetooth kernel driver from source originally provided by RealTek when the 8821ce chipset was released. The ebuild uses sources maintained by tomaspinho (https://github.com/tomaspinho/rtl8821ce) which target Arch and Ubuntu but work perfectly fine for Gentoo as well. The in-tree rtw88 driver will see support for this chipset with kernel 5.9, at which point this ebuild will be masked.
- Gnome SSH Tunnel Manager, updated for Gtk3 and maintained by myself at https://github.com/dallenwilson/gstm

This overlay is in the Layman listing. To add with Layman:
you@yourprompthere # layman -a trolltoo
