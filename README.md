# trolltoo
My personal ebuild overlay for Gentoo. It used to be much bigger; It may get a bit smaller.

## Adding this overlay

This overlay is in the [Gentoo repositories](https://overlays.gentoo.org/) listing.

To add it to your system:
```
you@yourprompthere # eselect repository enable trolltoo
you@yourprompthere # emaint sync -r trolltoo
```

If you still use layman::
```
you@yourprompthere # layman -a trolltoo
```

## Only unmask packages you use from this repository

You likely added this overlay to get a few specific packages, but you don't know what else may be in here, or may be added in the future. Best-practice (Based on [Masking installed but unsafe ebuild repositories](https://wiki.gentoo.org/wiki/Ebuild_repository#Masking_installed_but_unsafe_ebuild_repositories)) is to only allow what you came here for:

In `/etc/portage/package.mask/trolltoo`, block all packages from this repository by default:

```plain
*/*::trolltoo
```

In `/etc/portage/package.unmask/trolltoo`, allow specific packages from this repository:

```plain
net-misc/gstm::trolltoo
```

They will likely also need to be added to `/etc/portage/package.accept_keywords/`, as well.
