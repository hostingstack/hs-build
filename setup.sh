#!/bin/bash

set -e

BASEDIR=$(readlink -f .)

echo " * Installing packages..."
sudo apt-get install -y pbuilder mr bundler ruby1.9.1-full grml-debootstrap build-essential alien fakeroot wget

echo " * Setting up pbuilder..."
cat <<EOF | sudo tee /etc/pbuilder/hsrc
DISTRIBUTION=testing
BASETGZ=/var/cache/pbuilder/hs/$HOSTNAME/\$DISTRIBUTION-base.tgz
BUILDPLACE=/var/cache/pbuilder/hs/$HOSTNAME/\$DISTRIBUTION-build/
APTCACHE="/var/cache/pbuilder/hs/$HOSTNAME/\$DISTRIBUTION-aptcache/"
AUTO_DEBSIGN=no
BUILDUSERID=499
EXTRAPACKAGES="apt-utils"
HOOKDIR=/etc/pbuilder/hs/hooks/
SRCDIR=${BASEDIR}/src/
BINDMOUNTS="${BASEDIR}/src"
OTHERMIRROR="deb file://${BASEDIR}/src ./"
ALLOWUNTRUSTED=yes
CCACHEDIR=
EOF

sudo mkdir -p /etc/pbuilder/hs/hooks/
cat <<EOF | sudo tee /etc/pbuilder/hs/hooks/D05pre
#!/bin/sh
cd ${BASEDIR}/src && apt-ftparchive packages . > Packages && apt-get update
EOF
sudo chmod a+rx /etc/pbuilder/hs/hooks/D05pre

mkdir src || true
echo -n>src/Packages
sudo pbuilder --create --configfile /etc/pbuilder/hsrc

echo " * Cloning further repositories..."
echo $PWD/.mrconfig >> ~/.mrtrust
mr checkout

echo " * Building dependencies..."*
(cd src/thrift && mr run build)

