#!/bin/bash -e

steps=all
if [ $# -eq 3 ] ; then
    buildtype=$1
    step=$2
fi
echo "Component Blaze, buildtype ${buildtype}, step ${step}"

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
    cd ${top}/src
    # force new download of blaze
    rm -rf blaze-head

    # Tar file method
    #filename=HEAD.tar.gz
    #filename=blaze-3.4.tar.gz
    #rm -f ${filename}
    #wget https://bitbucket.org/blaze-lib/blaze/get/${filename}
    #wget https://bitbucket.org/blaze-lib/blaze/downloads/blaze-3.4.tar.gz
    #echo "expanding tar file..."
    #tar -xzf ${filename}
    #mv blaze-lib-blaze-* blaze-head
    #mv blaze-3.4 blaze-head

    # Git method
    git clone --depth 1 --branch master https://bitbucket.org/blaze-lib/blaze.git blaze-head
    #git clone --depth 100 --branch master https://bitbucket.org/blaze-lib/blaze.git blaze-head

    cd blaze-head
    #git checkout fd397e60717c4870d942055496d5b484beac9f1a
    cd ..

    echo "Removing old blaze build..."
    rm -rf ${blaze_build_dir}
    mkdir -p ${blaze_build_dir}
    cd ${blaze_build_dir}
    set -x
    cmake \
    -DCMAKE_CXX_COMPILER=`which ${mycxx}` \
    -DCMAKE_C_COMPILER=`which ${mycc}` \
    -DCMAKE_BUILD_TYPE=${buildtype} \
    -DLAPACK_DIR=${LAPACK_ROOT} \
    -DBLAS_DIR=${BLAS_ROOT} \
    -DCMAKE_INSTALL_PREFIX=. \
    -DBLAZE_SMP_THREADS=HPX \
    -DHPX_DIR=${HPX_ROOT}/lib/cmake/HPX \
    ${blaze_cmake_extras} \
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
