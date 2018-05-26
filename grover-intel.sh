module load gcc/6.4
module load intel
module load cmake
module load python/3.6.0
# module load boost/1.61
module list

# special flags for some library builds
export mycflags="-fPIC -xMIC_AVX512"
export mycxxflags="-fPIC -xMIC_AVX512"
export myldflags="-fPIC -xMIC_AVX512 -latomic -Wl,--allow-multiple-definition"
export mycc=icc
export mycxx=icpc
export myfc=ifort

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
export myarch=${host}-${arch}-${uname}-intel
export buildtype=Release
export malloc=tcmalloc
export contrib=${basedir}/build-${myarch}/contrib
export malloc_path=/usr/local/packages/gperftools/2.5
export activeharmony_path=/usr/local/packages/activeharmony/4.6.0-knl-gcc-6.1
export otf2_path=/usr/local/packages/otf2-2.0
export papi_path=/usr/local/packages/papi/papi-knl/5.5.0/
export boost_path=/usr/local/packages/boost/1.65.0-knl-intel18
export BOOST_ROOT=${boost_path}
export Boost_DIR=${boost_path}

echo ""
echo "NB: "
echo "basedir is set to ${basedir}."
echo "  All paths are relative to that base."
echo "myarch is set to ${myarch}."
echo "  Build output will be in ${basedir}/build-${myarch}."
echo ""
