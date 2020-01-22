#!/bin/bash -e

usage() {
    echo "Usage: $0 <absolute-path>"
    kill -INT $$
}

patch_templates() {
    set +e
    grep -rIl VT1 $1 | xargs sed -i -e 's/VT1/VBT1/g'
    grep -rIl VT2 $1 | xargs sed -i -e 's/VT2/VBT2/g'
    set -e
}

if [ $# -gt 1 ] ; then
    usage
fi

if [ $# -lt 1 ] ; then
    usage
fi

[ "$1" != "${1#/}" ] || usage

basedir=$1
srcdir=${basedir}/phylanx/tools/buildbot/src
echo "Using base directory as: ${basedir}"
#kill -INT $$

set -x

mkdir -p ${basedir}
cd ${basedir}

# First, get phylanx
if [ ! -d ${basedir}/phylanx ] ; then
    git clone \
    --branch master \
    --depth 1 \
    --recurse-submodules \
    git@github.com:STEllAR-GROUP/phylanx.git
else
    cd ${basedir}/phylanx
    git fetch
    git fetch --tags --force
    git checkout master
    git pull
fi

# Now, update the buildbot scripts
cd ${basedir}/phylanx/tools/buildbot
git fetch
git fetch --tags --force
git checkout master
git pull

mkdir -p ${srcdir}

# Next, update the HPX source
cd ${srcdir}
if [ ! -d ${srcdir}/hpx ] ; then
    git clone \
    --branch master \
    --depth 1 \
    git@github.com:STEllAR-GROUP/hpx.git
else
    cd ${srcdir}/hpx
    git fetch
    git fetch --tags --force
    git checkout master
    git pull
fi

# Also get the apex source
cd ${srcdir}/hpx
if [ ! -d apex ] ; then
    git clone \
    --branch develop \
    --depth 1 \
    git@github.com:khuck/xpress-apex apex
else
    cd ${srcdir}/hpx/apex
    git fetch
    git fetch --tags --force
    git checkout develop
    git pull
fi

# Next, get blaze
cd ${srcdir}
if [ ! -d ${srcdir}/blaze-head ] ; then
    git clone \
    --depth 1 \
    --branch master \
    https://bitbucket.org/blaze-lib/blaze.git blaze-head
else
    cd ${srcdir}/blaze-head
    git fetch
    git fetch --tags --force
    git checkout master
    git pull
fi
# Patch the blaze code
cd ${srcdir}
#patch_templates blaze-head

# Next, get blaze_tensor
cd ${srcdir}
if [ ! -d ${srcdir}/blaze_tensor ] ; then
    git clone https://github.com/STEllAR-GROUP/blaze_tensor.git
else
    cd ${srcdir}/blaze_tensor
    git fetch
    git fetch --tags --force
    git checkout master
    git pull
fi
# Patch the blaze_tensor code
#patch_templates blaze_tensor

# Next, get pybind
cd ${srcdir}
if [ ! -d ${srcdir}/pybind ] ; then
    filename=v2.2.2.tar.gz
    if [ ! -f ${filename} ] ; then
        wget https://github.com/pybind/pybind11/archive/${filename}
    fi
    tar -xzf ${filename}
fi

# Finally, get high-five
cd ${srcdir}
if [ ! -d ${srcdir}/HighFive-1.5 ] ; then
    filename=v1.5.tar.gz
    # force new download of high5
    if [ ! -f ${srcdir}/${filename} ] ; then
        wget https://github.com/BlueBrain/HighFive/archive/${filename}
    fi
    tar -xzf ${filename}
fi

