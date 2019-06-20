Based off of externpro: https://github.com/smanders/externpro
All credit should be accredited to smanders

# externprolite
[![GitHub license](https://img.shields.io/github/license/cameronfrandsen/externpro.svg)](https://github.com/cameronfrandsen/externpro) [![GitHub release](https://img.shields.io/github/release/cameronfrandsen/externprolite.svg)](https://github.com/cameronfrandsen/externprolite)

an extensible project to build (or copy pre-built) external (3rd-party) [projects](projects/README.md)

## description

externprolite supports options for [4 steps](https://github.com/smanders/externpro/blob/15.10.2/modules/macpro.cmake#L67-L72): mkpatch (make patch), download, patch, build -- with patch being the default option

externprolite makes heavy use of cmake's [ExternalProject](http://www.kitware.com/media/html/BuildingExternalProjectsWithCMake2.8.html) module

#### mkpatch

for each project in the [projects directory](projects) the mkpatch step: clones a repository (if `GIT_ORIGIN` is defined), does a checkout of a specified branch or hash (specified with `GIT_TAG`), and creates a patch (the diff between `GIT_REF` and `GIT_TAG`) -- this is how the [patches directory](patches) is populated and updated

this is typically a task done by a single maintainer - others developers who wish to use externprolite aren't usually doing this step

#### download

for each project in the [projects directory](projects) which implements a download_*project-name*() cmake function or defines `DLURL` and `DLMD5`, the download step: downloads and/or verifies the md5 of a compressed archive of a specified URL -- this is how the **_bldpkgs directory** is populated and updated

executing this step produces a directory structure suitable for light transport - burn to media to take into a closed environment or disconnect from the internet and you'll still be able to execute the next steps

#### patch

for each project in the [projects directory](projects) which implements a patch_*project-name*() cmake function or has a compressed archive or a patch, the patch step: downloads the compressed archive (if it hasn't already been downloaded), verfies the md5, expands the compressed archive, and applies the patch (made by mkpatch, if one exists)

executing this step produces the source code in a patched state, suitable for debugging and stepping into the source

if a developer already has externprolite installed (using the installer produced by the build step below), they can simply run the patch step (on an externprolite revision that matches their installed revision) and are now able to debug and step into third party code

if you are debugging and stepping into third party code, please note the instructions for building debug version(s) of all or selected projects below (in the usage > debug section)

#### build

for each project in the [projects directory](projects) which implements a build_*project-name*() cmake function, the build step: executes the patch step then builds the project with the compiler (aka cmake generator) detected or specified at cmake-time of externprolite

externprolite also contains cmake options to specify different build platforms (32, 64 bit) and configurations (release, debug, multiple release runtime support with MSVC) - all of these platforms and configurations are built at build-time of externprolite

the `package` target of externprolite will build an installer suitable for the OS on which you're building

## advantages

* compiler choice and compatibility - build third-party projects with the same compiler you're using with your project
* version choice - choose the exact version of a third-party project you want to employ in your project (can be bleeding edge or trailing what's available via other means)
* patch - apply fixes or tweaks you've found to be necessary or easily cherry-pick a fix from a version you're not ready to move to yet
* consistency across platforms - every OS can be using the same (perhaps patched) version of third-party code
* platform choice - build for the OS and architecture you support
* build configuration choice - support debug builds for stepping into code (and gaining understanding) and release configurations that utilize different runtimes (DLL or static)
* compiler flags - consistency across all third-party libraries and your project(s) is often required (c++11, fpic, libumem on Solaris)

## usage

to build and use externprolite from another project you can either create a *build version* of externprolite or an *installed version*

a build version is created by simply building externprolite and an installed version involves building, making the package (aka installer), and installing

one difference between a build version and an installed version is where the find script looks to find externprolite - you can see the PATHS searched, in order, in the [find script](https://github.com/smanders/externprolite/blob/18.04.1/modules/Findscript.cmake.in#L89-L100)

if you always plan to use an installed version the path to the source and build directories doesn't matter -- only the path where it is installed matters, unless you use an environment variable (examine the find script for suitable install locations)

**NOTE**: if your build directory (`_bld` below) is a subdirectory of the repo, you'll need to have git ignore the build directory or the staging directory will be marked with `dirtyrepo` from [this cmake](https://github.com/smanders/externprolite/blob/18.04.1/modules/macpro.cmake#L270-L279) -- and since I'm not a fan of a .gitignore file committed to the repo, I recommend adding `_bld*/` to the `.git/info/exclude` file

because the find script looks for a build version of externprolite in `C:/src` on Windows and `~/src/` on Unix, if you have any intention of using a build version directly from another project: perform the following commands in the appropriate `src` directory

```bash
git clone git://github.com/cameronfrandsen/externprolite.git
cd externprolite
git checkout <tag>               # where tag is, for example, 18.04.1
git checkout -b dev origin/dev   # --or-- if you want the latest dev branch instead of a tagged version
mkdir _bld
cd _bld
```
#### windows
choose the cmake generator you want all of the externprolite projects to be built with (Visual Studio 2015, 64-bit in example below)
```bash
cmake -G "Visual Studio 14 2015 Win64" ..
cmake -DXP_STEP=build .
explorer externprolite.sln
```
build the solution for a build version of externprolite or build the PACKAGE project for an installed version
#### unix
you can also choose the cmake generator, usually the default is what you'll want (Unix Makefiles)
```bash
cmake -DXP_STEP=build ..
make -j8
make package
```
the first `make` gives you a build version of externprolite, and the additional `make package` for an installed version
#### debug
building Debug versions of projects that support Debug is not `ON` by default (see [option](https://github.com/smanders/externpro/blob/9d023a5263b27d434001eaca0c4b57c28ad66be3/modules/macpro.cmake#L75))

to build Debug versions first turn `ON` the `XP_BUILD_DEBUG` cmake option (with ccmake on Unix platforms, or cmake-gui on Windows, or via commandline in the build directory: `cmake -DXP_BUILD_DEBUG=ON .`

if you want to build Debug versions of *all* projects that support Debug, you must also turn `ON` the `XP_BUILD_DEBUG_ALL` cmake option, otherwise you can choose selected projects to build Debug (most easily chosen with ccmake or cmake-gui) by selecting the cmake option specific for the given project -- of the form `XP_PRO_${PRJ}_BUILD_DBG` where `${PRJ}` specifies the project (see [option](https://github.com/smanders/externprolite/blob/9d023a5263b27d434001eaca0c4b57c28ad66be3/modules/xpfunmac.cmake#L21))
