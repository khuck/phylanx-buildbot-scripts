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
if [ -z ${high5_src_dir} ] ; then
    . ${scriptdir}/buildbot_common.sh
fi

get_high5()
{
    cd ${top}/src
    filename=v1.5.tar.gz
    # force new download of high5
    rm -f ${filename}
    rm -rf HighFive-1.5
    wget https://github.com/BlueBrain/HighFive/archive/${filename}
    echo "expanding tar file..."
    tar -xzf ${filename}
}

configure_high5()
{
    echo "Removing old high5 build..."
    rm -rf ${high5_build_dir}
    mkdir -p ${high5_build_dir}
    cd ${high5_build_dir}
    set -x
    export LDFLAGS=${HDF5_LDFLAGS}
    cmake \
    -DCMAKE_CXX_COMPILER=`which ${mycxx}` \
    -DCMAKE_C_COMPILER=`which ${mycc}` \
    -DCMAKE_BUILD_TYPE=${buildtype} \
    -DHDF5_ROOT=${HDF5_ROOT} \
    -DCMAKE_INSTALL_PREFIX=. \
    ${high5_cmake_extras} \
    ${high5_src_dir}
}

build_high5()
{
    cd ${high5_build_dir}
    make ${makej}
}

install_high5()
{
    cd ${high5_build_dir}
    make install
}

if [ ${step} == "all" ] || [ ${step} == "configure" ] ; then
    #get_high5
    configure_high5
fi
if [ ${step} == "all" ] || [ ${step} == "compile" ] ; then
    build_high5
fi
if [ ${step} == "all" ] || [ ${step} == "install" ] ; then
    install_high5
fi
