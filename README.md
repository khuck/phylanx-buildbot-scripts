# Buildbot scripts for Phylanx project

The scripts in this directory are used for launching regular, automated builds
of the Phylanx project.  All dependencies are included, such as HPX, pybind11,
eigen3.

The top level script is buildbot.sh. The other relevant scripts:

* buildbot\_boost.sh: for building boost 1.65
* buildbot\_hpx.sh: for building HPX master
* buildbot\_common.sh: for setting common build paths
* buildbot\_eigen3.sh: for "building" the eigen3 headers
* buildbot\_pybind.sh: for "building" the pybind11 headers
* buildbot\_phylanx.sh: for building phylanx
* launch-build-talapas.sh: for launching the HPX build on a compute node
* delphi-gcc.sh: for loading modules, etc. on delphi x86\_64 server at UO
* grover-intel.sh: for loading modules, etc. on grover KNL server at UO
* ktau-gcc.sh: for loading modules, etc. on buildbot server at UO

Working machine scripts:

* Delphi (x86\_64-Linux RedHat, with 18 cores, hyperthreading, gcc 7.1, boost 1.65)
* ktau (x86\_64-Linux Ubuntu, with 8 cores, gcc 7.1, boost 1.65)
* grover (KNL-Linux with 68 cores, 4x threads per core, Intel 18, boost 1.65)
* centaur (IBM Power8-Linux with 40 cores, 4x threads per core, Clang 5.0, boost 1.65)

To get the scripts in the phylanx project:

```
git submodule update --recursive --remote
git submodule update --init tools/buildbot
git submodule foreach git pull origin master
```

# Build Status

[![x86_64 release build status](http://ktau.nic.uoregon.edu:8020/badges/x86_64-gcc7-release.svg?left_text=x86_64-gcc7-release)](http://ktau.nic.uoregon.edu:8020/#/)
[![KNL release build status](http://ktau.nic.uoregon.edu:8020/badges/knl-gcc7-release.svg?left_text=KNL-gcc7-release)](http://ktau.nic.uoregon.edu:8020/#/)
[![POWER8 release build status](http://ktau.nic.uoregon.edu:8020/badges/ppc64le-clang5-release.svg?left_text=POWER8-clang5-release)](http://ktau.nic.uoregon.edu:8020/#/)

[![x86_64 release build status](http://ktau.nic.uoregon.edu:8020/badges/x86_64-gcc7-relwithdebinfo.svg?left_text=x86_64-gcc7-relwithdebinfo)](http://ktau.nic.uoregon.edu:8020/#/)
[![KNL release build status](http://ktau.nic.uoregon.edu:8020/badges/knl-gcc7-relwithdebinfo.svg?left_text=KNL-gcc7-relwithdebinfo)](http://ktau.nic.uoregon.edu:8020/#/)
[![POWER8 release build status](http://ktau.nic.uoregon.edu:8020/badges/ppc64le-clang5-relwithdebinfo.svg?left_text=POWER8-clang5-relwithdebinfo)](http://ktau.nic.uoregon.edu:8020/#/)

[![x86_64 debug build status](http://ktau.nic.uoregon.edu:8020/badges/x86_64-gcc7-debug.svg?left_text=x86_64-gcc7-debug)](http://ktau.nic.uoregon.edu:8020/#/)
[![KNL debug build status](http://ktau.nic.uoregon.edu:8020/badges/knl-gcc7-debug.svg?left_text=KNL-gcc7-debug)](http://ktau.nic.uoregon.edu:8020/#/)
[![POWER8 debug build status](http://ktau.nic.uoregon.edu:8020/badges/ppc64le-clang5-debug.svg?left_text=POWER8-clang5-debug)](http://ktau.nic.uoregon.edu:8020/#/)
