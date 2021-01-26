#!/bin/bash -e

usage() {
    echo "Usage: $0 <absolute-path>"
    kill -INT $$
}

if [ $# -gt 1 ] ; then
    usage
fi

if [ $# -lt 1 ] ; then
    usage
fi

[ "$1" != "${1#/}" ] || usage

basedir=$1
srcdir=${basedir}/tools/buildbot/src
echo "Using base directory as: ${basedir}"
#kill -INT $$

set -x

mkdir -p ${basedir}
cd ${basedir}

# First, get phylanx
if [ ! -f ${basedir}/CMakeLists.txt ] ; then
    git clone \
    --branch master \
    --depth 1 \
    --recurse-submodules \
    https://github.com/STEllAR-GROUP/phylanx.git
    # Adjust the top level directory
    basedir=$1/phylanx
    srcdir=${basedir}/tools/buildbot/src
else
    git fetch --force
    git fetch --tags --force
    git checkout master
    git pull
fi

# Now, update the buildbot scripts
cd ${basedir}/tools/buildbot
git fetch --force
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
    https://github.com/STEllAR-GROUP/hpx.git
else
    cd ${srcdir}/hpx
    git fetch --force
    git fetch --tags --force
    git checkout master
    git pull
    git clean -f
fi

# Also get the apex source
cd ${srcdir}/hpx
if [ ! -d apex ] ; then
    git clone \
    --branch develop \
    --depth 1 \
    https://github.com/khuck/xpress-apex.git apex
else
    cd ${srcdir}/hpx/apex
    git fetch --force
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
    git fetch --force
    git fetch --tags --force
    git checkout master
    git pull
fi

# Next, get blaze_tensor
cd ${srcdir}
if [ ! -d ${srcdir}/blaze_tensor ] ; then
    git clone https://github.com/STEllAR-GROUP/blaze_tensor.git
else
    cd ${srcdir}/blaze_tensor
    git fetch --force
    git fetch --tags --force
    git checkout master
    git pull
fi

# Next, get pybind
cd ${srcdir}
if [ ! -d ${srcdir}/pybind ] ; then
    filename=v2.6.1.tar.gz
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

