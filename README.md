docbook-pkg
===========

Package builder for DocBook.

This project is used to create packages out of DocBook schemas and
stylesheets. It does not contain the sources themselves, but needs
them to be built.  They need to be copied at some specific place, but
never check them in!

As we do not want to modify DocBook sources, we cannot add the public
import URIs within the source files themselves, so we cannot use
[XProject](http://expath.org/modules/xproject/) and we need to provide
an explicit expath-pkg.xml descriptor.  Look into `build.sh` for build
instructions (normally just invoking `build.sh` in that directory is
all you need).
