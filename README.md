HostingStack build scripts
==========================

Base requirement: Debian wheezy, x86-64.

Preferably as a fast machine, VM is okay. At least 10G+ FREE disk space.


Preparations
------------

  * As a normal user, clone this repository to your Debian installation.
  * Make sure this user can use `sudo`.
  * Run `cd hs-build && ./setup.sh`

This will:

  * Install dependency packages
  * Configure `pbuilder` for building packages
  * Set up `hs-build/.mrconfig` as a trusted config (in `~/.mrtrust`)
  * Check out the HostingStack source code to `./src`
  * Build shipped dependencies (Thrift)


Building packages
-----------------

Run `mr run build`.


Building a demo VM
------------------

  * Preparations above done.
  * Ran `mr run build` once, successfully.
  * Run `./build-vm demo.raw`
    * or, for a VMware VM, run `./build-vm --format vmdk demo.vmdk`
  * Load `demo.img` (or `demo.vmdk`) in a Hypervisor of your choice, and give
    it some time to boot. 3GB RAM minimum.
  * After bootup it will create templates, this will take some minutes.

If you have a Debian mirror near you, also set `--mirror http://url.to.mirror/debian`.


Demo VM Info
------------

The default passwords are `CHANGEME`. This applies to user root (for
SSH), and to the admin account (demo1@hostingstack.org) and the
normal user (demo2@hostingstack.org).

SSL for applications is currently disabled. You can change this by
editing `/etc/hs/httpgateway/hs-httpgateway.conf`.

In a production setup, the various services would be split over multiple
machines.

Important ports:

  * Port 9100, HTTP: Enduser control panel
  * Port 9000, HTTP: Admin dashboard
  * Port 80, HTTP: application port
  * Port 443: HTTP/SSL: application port
  * Port 2200: Enduser SSH
  * Port 22: SSH for management (PAM auth)

Not-so-important ports:

  * Port 9200: internal storage
  * Port 3142: APT cache
  * Redis, PostgreSQL, MySQL run on their default ports
  * Port 9090: HSAgent Thrift server


Legalese
--------

Copyright 2011, 2012 Efficient Cloud Ltd.

Released under the [MIT license](http://www.opensource.org/licenses/mit-license.php).
