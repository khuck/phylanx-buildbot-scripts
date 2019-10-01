#!/bin/bash -e

set -x

# where is this script?
if [ -z ${scriptdir} ] ; then
    scriptdir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
fi

cd ${scriptdir}/../..

cwd=`pwd`
set -x

git fetch
git fetch --tags --force
git checkout master
git pull
cd tools/buildbot
git fetch
git fetch --tags --force
git checkout master
git pull
cd src/hpx
git fetch
git fetch --tags --force
git checkout master
git pull
git checkout stable
cd apex
git fetch
git fetch --tags --force
git checkout develop
git pull
cd ${cwd}/tools/buildbot

