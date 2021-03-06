#!/bin/bash
set -x

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

# load common settings
if [ -z ${hpx_src_dir} ] ; then
    . ${scriptdir}/buildbot_common.sh
fi

workdir=/dev/shm/src
if [ "${host}" == "centaur" ] || [ "${host}" == "cyclops" ] || [ "${host}" == "delphi" ] || [ "${host}" == "grover" || [ "${host}" == "talapas" ] ; then
    workdir=${sourcedir}/boost
fi

mkdir -p ${workdir}
cd ${workdir}
if [ ! -d boost_1_69_0 ] ; then
    if [ ! -f boost_1_69_0.tar.bz2 ] ; then
        wget https://sourceforge.net/projects/boost/files/boost/1.69.0/boost_1_69_0.tar.bz2
    fi
    tar -xjf boost_1_69_0.tar.bz2
fi

# track the output
set -x

cd ${workdir}/boost_1_69_0
if [ ${mycc} == "clang" ] ; then
    ./bootstrap.sh --prefix=${boost_path} --with-toolset=clang
else
    ./bootstrap.sh --prefix=${boost_path} --with-toolset=gcc
fi

# there will be some boost errors.  Don't fail!

if [ ${mycc} == "icc" ] ; then
    ./b2 ${makej} install toolset=intel address-model=64
elif [ ${mycc} == "clang" ] ; then
    ./b2 ${makej} install toolset=clang address-model=64
else
    ./b2 ${makej} install cxxflags="-std=c++11 ${mycxxflags}"
fi

