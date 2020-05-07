#!/bin/bash -e

steps=all
if [ $# -eq 3 ] ; then
    buildtype=$1
    step=$2
fi
echo "Component HPX, buildtype ${buildtype}, step ${step}"

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

# load common settings
if [ -z ${blaze_src_dir} ] ; then
    . ${scriptdir}/buildbot_common.sh
fi

get_blazetensor()
{
    cd ${top}/src
    rm -rf blaze_tensor
    git clone https://github.com/STEllAR-GROUP/blaze_tensor.git
}

configure_blazetensor()
{
    echo "Removing old blazetensor build..."
    rm -rf ${blazetensor_build_dir}
    mkdir -p ${blazetensor_build_dir}
    cd ${blazetensor_build_dir}
    set -x
    cmake \
    -DCMAKE_CXX_COMPILER=`which ${mycxx}` \
    -DCMAKE_C_COMPILER=`which ${mycc}` \
    -DCMAKE_BUILD_TYPE=${buildtype} \
    -Dblaze_DIR=${blaze_build_dir}/share/blaze/cmake \
    -DHPX_DIR=${HPX_ROOT}/lib/cmake/HPX \
    -DCMAKE_INSTALL_PREFIX=. \
    ${blazetensor_src_dir}
}

build_blazetensor()
{
    cd ${blazetensor_build_dir}
    make ${makej}
    make install
}

if [ ${step} == "all" ] || [ ${step} == "configure" ] ; then
    #get_blazetensor
    configure_blazetensor
fi
if [ ${step} == "all" ] || [ ${step} == "compile" ] ; then
    build_blazetensor
fi
