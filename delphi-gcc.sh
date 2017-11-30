module load gcc/7.1
#module load python/3.3.4
module load python/3.6.0
module list
export CMAKE=/usr/local/packages/cmake/3.9.3
PATH=/usr/local/packages/cmake/3.9.3/bin:$PATH

export mycc=gcc
export mycxx=g++
export myfc=gfortran

export host=delphi
arch=`arch`
uname=`uname`

if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi
export basedir=$( dirname "${scriptdir}" )
export myarch=${host}-${arch}-${uname}-gcc
export buildtype=Release
export malloc=tcmalloc
#export malloc_path=/usr/local/packages/gperftools/2.5
export malloc_path=/usr/local/packages/gperftools/git-gcc7
export activeharmony_path=/usr/local/packages/activeharmony/4.6.0-gcc
export otf2_path=/usr/local/packages/otf2-2.1
export papi_path=/usr/local/packages/papi/papi-knl/5.5.0/
#export boost_path=${basedir}/buildbot/build-${myarch}/boost-1.65.0
export boost_path=/usr/local/packages/boost/1.65.0-gcc7
export BOOST_DIR=${boost_path}
export BOOST_ROOT=${boost_path}
export LAPACK_ROOT=/usr/local/packages/lapack/3.7.1-gcc
export BLAS_ROOT=/usr/local/packages/lapack/3.7.1-gcc
export LAPACK_ROOT=${LAPACK_DIR}
export BLAS_ROOT=${BLAS_DIR}
export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:${LAPACK_ROOT}/lib64/pkgconfig

echo ""
echo "NB: "
echo "basedir is set to ${basedir}."
echo "  All paths are relative to that base."
echo "myarch is set to ${myarch}."
echo "  Build output will be in ${basedir}/build-${myarch}."
echo ""
