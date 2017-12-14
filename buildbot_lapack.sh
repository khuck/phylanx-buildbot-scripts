#!/bin/bash
set -x

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

. ${scriptdir}/buildbot_common.sh
   
workdir=/dev/shm/src

if [ "${host}" == "centaur" ] || [ "${host}" == "delphi" ] || [ "${host}" == "grover" ] || [ "${host}" == "talapas" ] ; then
    workdir=${sourcedir}/lapack
    echo ${workdir}
fi  

mkdir -p ${workdir}
cd ${workdir}

if [ ! -d lapack-3.7.1 ] ; then
    if [ ! -f lapack-3.7.1.tgz ] ; then
        wget http://www.netlib.org/lapack/lapack-3.7.1.tgz
    fi
    tar -xzf lapack-3.7.1.tgz
fi

mkdir -p lapack-3.7.1/build
cd lapack-3.7.1/build
cmake -DCMAKE_INSTALL_PREFIX=${lapack_path} -DBUILD_SHARED_LIBS=ON ..
make ${makej}
make install
cd ..
