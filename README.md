HostingStack build scripts
==========================

Base requirement: Debian wheezy, amd64
Preferably as a physical machine. At least 10G+ FREE disk space.

WARNING: At this time most of the repositories are not yet public.

Preparations
------------

  * As a normal user, clone this repository to your Debian installation.
  * Make sure this user can use sudo.
  * Run cd hs-build && ./setup.sh

This will:

  * Install dependency packages
  * Configure pbuilder for building packages
  * Set up hs-build/.mrconfig as a trusted config (in ~/.mrtrust)
  * Build shipped dependencies

Building packages
-----------------

Run `mr run build`.


Legalese
--------

Copyright 2011, 2012 Efficient Cloud Ltd.

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).