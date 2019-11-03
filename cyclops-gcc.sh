module load gcc/7.3 cmake/3.15.4 python/3.8.0 openmpi/4.0.1-gcc7.3

# special flags for some library builds
export mycflags="-fPIC"
export mycxxflags="-fPIC"
export myldflags="-fPIC"
export mycc=gcc
export mycxx=g++

export host=cyclops
arch=`arch`
uname=`uname`

if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export basedir=$( dirname "${scriptdir}" )
export myarch=${host}-${arch}-${uname}-${mycc}
export buildtype=Release
#export malloc=tcmalloc
export malloc=system
export contrib=${basedir}/build-${myarch}/contrib
export malloc_path=/usr/local/packages/gperftools/2.5
export activeharmony_path=/usr/local/packages/activeharmony/4.6.0-${arch}
export otf2_path=/usr/local/packages/otf2/2.0-ppc64le
export papi_path=/usr/local/packages/papi/5.5.1
export boost_path=${basedir}/buildbot/build-${myarch}/boost-1.65.1
export BOOST_DIR=${boost_path}
export BOOST_ROOT=${boost_path}
export LAPACK_DIR=/usr/local/packages/lapack/3.7.1-gcc
#export BLAS_ROOT=/usr/local/packages/ATLAS/3.10.3
export BLAS_DIR=/usr/local/packages/lapack/3.7.1-gcc
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/packages/lapack/3.7.1-gcc/lib64/pkgconfig
export LAPACK_ROOT=${LAPACK_DIR}
export BLAS_ROOT=${BLAS_DIR}
export blaze_cmake_extras="-DBLAS_LIBRARIES=${BLAS_DIR}/lib64/libblas.so -DLAPACK_LIBRARIES=${LAPACK_DIR}/lib64/liblapack.so"
export cmake_extras=" -DHWLOC_ROOT=/usr/local/packages/hwloc/1.8 -DHPX_WITH_RDTSCP=OFF -DHPX_WITH_DEPRECATION_WARNINGS=Off "

export MPICC=mpicc
export MPICXX=mpicxx

echo ""
echo "NB: "
echo "basedir is set to ${basedir}."
echo "  All paths are relative to that base."
echo "myarch is set to ${myarch}."
echo "  Build output will be in ${basedir}/build-${myarch}."
echo ""
echo "CC = `which $mycc`"
echo "CXX = `which $mycxx`"
echo "MPICC = `which mpicc`"
echo "MPICXX = `which mpicxx`"
