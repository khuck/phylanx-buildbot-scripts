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

configure_blaze()
{
    if [ ! -d ${blaze_src_dir} ] ; then
        cd ${top}/src
        filename=blaze-3.2.tar.gz
        if [ ! -f ${filename} ] ; then
            wget https://bitbucket.org/blaze-lib/blaze/downloads/${filename}
        fi
        tar -xzf ${filename}
    fi
    echo "Removing old blaze build..."
    rm -rf ${blaze_build_dir}
    mkdir -p ${blaze_build_dir}
    cd ${blaze_build_dir}
    cmake \
    -DCMAKE_BUILD_TYPE=${buildtype} \
    -DCMAKE_INSTALL_PREFIX=. \
    ${blaze_src_dir}
}

build_blaze()
{
    cd ${blaze_build_dir}
    make ${makej}
    make install
}

if [ ${step} == "all" ] || [ ${step} == "configure" ] ; then
    configure_blaze
fi
if [ ${step} == "all" ] || [ ${step} == "compile" ] ; then
    build_blaze
fi
