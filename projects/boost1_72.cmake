# boost
set(VER 1.72.0)
string(REPLACE "." "_" VER_ ${VER}) # 1_72_0
string(REGEX REPLACE "([0-9]+)\\.([0-9]+)(\\.[0-9]+)?" "\\1_\\2" VER2_ ${VER}) # 1_72
xpProOption(boost${VER2_})
set(REPO https://github.com/boostorg/boost)
set(PRO_BOOST${VER2_}
  NAME boost${VER2_}
  WEB "boost" http://www.boost.org/ "Boost website"
  LICENSE "open" http://www.boost.org/users/license.html "Boost Software License"
  DESC "libraries that give C++ a boost"
  REPO "repo" ${REPO} "boost repo on github"
  GRAPH GRAPH_NODE boost GRAPH_DEPS zlib bzip2
  VER ${VER}
  GIT_ORIGIN git://github.com/boostorg/boost.git
  GIT_TAG boost-${VER} # what to 'git checkout'
  DLURL https://dl.bintray.com/boostorg/release/${VER}/source/boost_${VER_}.tar.bz2
  DLMD5 cb40943d2a2cb8ce08d42bc48b0f84f0
  )
