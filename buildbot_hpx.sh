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

if [ -z ${basedir+x} ] ; then
    echo "basedir is not set. Please source the appropriate settings in the ${scriptdir} directory.";
    kill -INT $$
fi

# get the common settings
. ${scriptdir}/buildbot_common.sh

if [ -z ${buildtype} ] ; then
    echo "buildtype not set."
    kill -INT $$
fi

if [ -z ${HPX_ROOT} ] ; then
    echo "HPX_ROOT not set."
    kill -INT $$
fi

if [ ! -d $(dirname ${HPX_ROOT}) ] ; then
    echo "$(dirname ${HPX_ROOT}) does not exist."
    kill -INT $$
fi

get_source()
{
    if [ ! -d ${hpx_src_dir} ] ; then
        cd $(dirname ${hpx_src_dir})
        #git clone https://github.com/STEllAR-GROUP/hpx.git
        git clone --depth 1 https://github.com/STEllAR-GROUP/hpx.git -b master
    fi
    cd ${hpx_src_dir}
    #git reset --hard
    git fetch
    git fetch --tags --force
    git checkout master
    git pull
    #git checkout stable
    if [ -d apex ] ; then
        cd apex
        git fetch --tags
        git checkout develop
        git pull
        cd ..
    fi
}

configure_it()
{
    echo "Deleting old build..."
    rm -rf ${HPX_ROOT}
    mkdir -p ${HPX_ROOT}
    cd ${HPX_ROOT}

    if [ ${malloc} == "jemalloc" ] ; then
        alloc_opts="-DJEMALLOC_ROOT=${malloc_path} -DHPX_WITH_MALLOC=jemalloc"
    elif [ ${malloc} == "tcmalloc" ] ; then
        alloc_opts="-DTCMALLOC_ROOT=${malloc_path} -DHPX_WITH_MALLOC=tcmalloc"
    else
        alloc_opts="-DHPX_WITH_MALLOC=system"
    fi
    papi_opts=""
    otf2_opts=""
    activeharmony_opts=""
    if [ "${papi_path}" == "" ] ; then
        papi_opts="-DAPEX_WITH_PAPI=FALSE"
    else
        papi_opts="-DAPEX_WITH_PAPI=TRUE -DPAPI_ROOT=${papi_path}"
    fi
    if [ "${otf2_path}" == "" ] ; then
        otf2_opts="-DAPEX_WITH_OTF2=FALSE"
    else
        otf2_opts="-DAPEX_WITH_OTF2=TRUE -DOTF2_ROOT=${otf2_path}"
    fi
    if [ "${activeharmony_path}" == "" ] ; then
        activeharmony_opts="-DAPEX_WITH_ACTIVEHARMONY=FALSE"
    else
        activeharmony_opts="-DAPEX_WITH_ACTIVEHARMONY=TRUE -DACTIVEHARMONY_ROOT=${activeharmony_path}"
    fi
    #apex_opts="-DHPX_WITH_APEX=TRUE ${activeharmony_opts} ${otf2_opts} ${papi_opts} -DHPX_WITH_APEX_NO_UPDATE=true -DHPX_WITH_APEX_TAG=develop"
    apex_opts="-DHPX_WITH_APEX=TRUE -DHPX_WITH_APEX_TAG=develop ${activeharmony_opts} ${otf2_opts} ${papi_opts}"
    export CC=${mycc}
    export CXX=${mycxx}
    export FC=${myfc}
    export CFLAGS=${mycflags}
    export CXXFLAGS=${mycxxflags}
    export LDFLAGS=${myldflags}

    high_count=""
    if [ $nprocs -gt 64 ] ; then
        high_count="-DHPX_WITH_MAX_CPU_COUNT=${nprocs} "
    fi

    #MPICC=""
    if [ "x$MPICC" = "x" ] ; then
        mpi_opt="-DHPX_WITH_PARCELPORT_MPI=OFF"
    else
        mpi_opt="-DHPX_WITH_PARCELPORT_MPI=ON"
    fi

    set -x
    cmake \
    -DCMAKE_CXX_COMPILER=`which ${mycxx}` \
    -DCMAKE_C_COMPILER=`which ${mycc}` \
    -DCMAKE_BUILD_TYPE=${buildtype} \
    -DBOOST_ROOT=${boost_path} \
    -DHPX_WITH_FETCH_ASIO=ON \
    ${alloc_opts} \
    -DHWLOC_ROOT=${hwloc_path} \
    -DCMAKE_INSTALL_PREFIX=. \
    -DHPX_WITH_THREAD_IDLE_RATES=ON \
    ${mpi_opt} \
    -DHPX_WITH_PARCEL_COALESCING=OFF \
    -DHPX_WITH_TOOLS=OFF \
    -DHPX_WITH_TESTS=ON \
    -DHPX_WITH_EXAMPLES=OFF \
    -DHPX_WITH_THREAD_MANAGER_IDLE_BACKOFF=OFF \
    -DHPX_WITH_PARCELPORT_LIBFABRIC=OFF \
    ${apex_opts} \
    ${cmake_extras} \
    ${high_count} \
    ${hpx_src_dir}
}

build_it()
{
    cd ${HPX_ROOT}
    make ${makej}
}

if [ ${step} == "all" ] || [ ${step} == "configure" ] ; then
    #get_source
    configure_it
fi
if [ ${step} == "all" ] || [ ${step} == "compile" ] ; then
    build_it
fi
