#!/bin/bash
set -x

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

. ${scriptdir}/buildbot_common.sh
   
workdir=/dev/shm/src

if [ "${host}" == "centaur" ] || [ "${host}" == "delphi" ] || [ "${host}" == "grover" ] || [ "${host}" == "talapas" ] ; then
    workdir=${sourcedir}/otf2
    echo ${workdir}
fi  

mkdir -p ${workdir}
cd ${workdir}

if [ ! -d otf2-2.0 ] ; then
    if [ ! -f otf2-2.0.tar.gz ] ; then
	wget http://www.vi-hps.org/upload/packages/otf2/otf2-2.0.tar.gz
    fi
    tar -xzf otf2-2.0.tar.gz
fi

mkdir -p otf2-2.0/build
cd otf2-2.0/build
../configure --prefix=${otf2_path} --enable-shared
make ${makej}
make install
cd ..
