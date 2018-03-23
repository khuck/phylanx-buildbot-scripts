#!/bin/bash -e

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

if [ -z ${buildtype} ] ; then
    buildtype=RelWithDebInfo
fi

if [ -z ${myarch} ] ; then
    echo "myarch is not set. Please source the appropriate settings in the ${scriptdir} directory.";
    kill -INT $$

fi

export nprocs=2
osname=`uname`
hostname=`hostname`
if [ ${osname} == "Darwin" ]; then
    nprocs=`sysctl -n hw.ncpu`
else
    nprocs=`nproc --all`
fi

let one_half=$nprocs/4
# laptops and so forth can go full steam ahead...
if [ $nprocs -lt 16 ] ; then
    let one_half=$nprocs/2
fi
# The KNL gets bogged down with 68 concurrent builds...
if [ $nprocs -gt 160 ] ; then
    let one_half=$nprocs/8
fi

makej="-j ${one_half} -l ${nprocs}"

if [ ${hostname} == "taudev" ]; then
    makejtest="-j 2 -l ${nprocs}"
else
    makejtest="-j 4 -l ${nprocs}"
fi

# Assume that the buildbot script directory is in phylanx/tools/buildbot
# of the phylanx project.
tmptop=$( dirname "${scriptdir}" )
top=${tmptop}/buildbot
sourcedir=${top}/src
buildprefix=${top}/build-${myarch}

# Assume that the buildbot script directory is in phylanx/tools/buildbot
# of the phylanx project. We need to go up one more directory to get
# to the project root directory.
phylanx_src_dir=$( dirname "${tmptop}" )
phylanx_build_dir=${buildprefix}/phylanx-${buildtype}
phylanx_install_dir=${buildprefix}/phylanx-${buildtype}-install

pybind_src_dir=${sourcedir}/pybind11-2.2.2
pybind_build_dir=${buildprefix}/pybind-${buildtype}

eigen_src_dir=${sourcedir}/eigen-eigen-5a0156e40feb
eigen_build_dir=${buildprefix}/eigen3-${buildtype}

blaze_src_dir=${sourcedir}/blaze-head
blaze_build_dir=${buildprefix}/blaze-${buildtype}

high5_src_dir=${sourcedir}/HighFive-1.5
high5_build_dir=${buildprefix}/high5-${buildtype}

hpx_src_dir=${sourcedir}/hpx
HPX_ROOT=${buildprefix}/hpx-${buildtype}

# go up one directory
basedir=$(dirname ${scriptdir})
echo "Basedir: ${basedir}"
