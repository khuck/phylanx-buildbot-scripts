#module load mpi/openmpi-2.1_gcc-7.3
#module load gcc/7.1
#module load python/3.3.4
module load cmake
module load python/3.6.4
module list
# export CMAKE=/usr/local/packages/cmake/3.9.3
# PATH=/usr/local/packages/cmake/3.9.3/bin:$PATH

# special flags for some library builds
export mycflags="-fPIC -march=knl"
export mycxxflags="-fPIC -march=knl"
export myldflags="-fPIC -march=knl -latomic -Wl,--allow-multiple-definition"
export mycc=gcc
export mycxx=g++
export myfc=gfortran

export CC=${mycc}
export CXX=${mycxx}
export F90=${myfc}
export CFLAGS=${mycflags}
export FFLAGS=${mycflags}
export CXXFLAGS=${mycxxflags}
export LDFLAGS=${myldcflags}

export host=grover
arch=`arch`_knl
uname=`uname`

if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export basedir=$( dirname "${scriptdir}" )
export myarch=${host}-${arch}-${uname}-gcc
export buildtype=Release
export malloc=tcmalloc
export contrib=${basedir}/build-${myarch}/contrib
export malloc_path=/usr/local/packages/gperftools/2.5
export activeharmony_path=/usr/local/packages/activeharmony/4.6.0-knl-gcc-6.1
export otf2_path=/usr/local/packages/otf2-2.0
export papi_path=/usr/local/packages/papi/papi-knl/5.5.0/
export boost_path=/usr/local/packages/boost/1.65.0-knl-gcc7_avx
export BOOST_ROOT=${boost_path}
export BOOST_DIR=${boost_path}
#export LAPACK_ROOT=/usr/local/packages/lapack/3.7.1-gcc
#export BLAS_ROOT=/usr/local/packages/lapack/3.7.1-gcc
#export LAPACK_ROOT=${LAPACK_DIR}
#export BLAS_ROOT=${BLAS_DIR}
#export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:${LAPACK_ROOT}/lib64/pkgconfig
export hwloc_path=/usr/local/packages/hwloc/1.11.5

# export MPICC=mpicc
# export MPICXX=mpicxx

echo ""
echo "NB: "
echo "basedir is set to ${basedir}."
echo "  All paths are relative to that base."
echo "myarch is set to ${myarch}."
echo "  Build output will be in ${basedir}/build-${myarch}."
echo ""
echo "CC = `which $mycc`"
echo "CXX = `which $mycxx`"
#echo "MPICC = `which mpicc`"
#echo "MPICXX = `which mpicxx`"
