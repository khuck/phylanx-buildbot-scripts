#!/bin/bash -e

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

# First, update the Phylanx source
cd ${scriptdir}/../..
cwd=`pwd`

${scriptdir}/get_all_source.sh ${cwd}/..
