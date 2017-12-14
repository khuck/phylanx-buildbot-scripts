#module load openmpi/gcc/64/1.10.1
#module load mpich/ge/gcc/64/3.2rc2
#module load intel-mpi
module load cmake
module load python3
module load gcc
module list

# special flags for some library builds
# export mycflags="-fPIC -mavx512f -mavx512cd -mavx512bw -mavx512dq -mavx512vl -mavx512ifma -mavx512vbmi"
# export mycxxflags="-fPIC -mavx512f -mavx512cd -mavx512bw -mavx512dq -mavx512vl -mavx512ifma -mavx512vbmi"
export mycflags="-fPIC"
export mycxxflags="-fPIC"
export myldflags="-fPIC"
export mycc=gcc
export mycxx=g++
export myfc=gfortran


export host=talapas
arch=`arch`
uname=`uname`

if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export basedir=$( dirname "${scriptdir}" )
export myarch=${host}-${arch}-${uname}-gcc

#export basedir=${HOME}/src/phylanx
#export myarch=${host}-${arch}-${uname}-gcc
export buildtype=Release
export malloc=tcmalloc
export malloc_path=/usr/local/packages/gperftools/2.5
#export malloc_path=/projects/tau/mmonil/package/gperftools/2.6.3
export activeharmony_path=/usr/local/packages/activeharmony/4.6.0
export hwloc_path=${basedir}/buildbot/build-${myarch}/hwloc-1.11.5
export otf2_path=${basedir}/buildbot/build-${myarch}/otf2
#export otf2_path=/projects/tau/mmonil/package/otf2/2.0/linux_x86_64
export papi_path=/packages/papi/5.5.1
export boost_path=${basedir}/buildbot/build-${myarch}/boost-1.65.0
#export boost_path=/projects/tau/mmonil/package/boost/1.61.0/linux_x86_64
export BOOST_DIR=${boost_path}
export BOOST_ROOT=${boost_path}
export lapack_path=${basedir}/buildbot/build-${myarch}/lapack-3.7.1
#export LAPACK_ROOT=/projects/tau/mmonil/package/lapack/3.7.1_gcc7.2
#export BLAS_ROOT=/projects/tau/mmonil/package/lapack/3.7.1_gcc7.2
export LAPACK_ROOT=${lapack_path}
export BLAS_ROOT=${lapack_path}
#export LAPACK_ROOT=${LAPACK_DIR}
#export BLAS_ROOT=${BLAS_DIR}
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:${lapack_path}/lib64/pkgconfig
#export hwloc_path=/projects/tau/mmonil/package/hwloc/1.11.4/linux_x86_64


echo ""
echo "NB: "
echo "basedir is set to ${basedir}."
echo "  All paths are relative to that base."
echo "myarch is set to ${myarch}."
echo "  Build output will be in ${basedir}/build-${myarch}."
echo ""
