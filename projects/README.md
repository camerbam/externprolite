# projects

|project|license|description|version|repository|patch/diff|
|-------|-------|-----------|-------|----------|----------|
|[boost](http://www.boost.org/ 'Boost website')|[open](http://www.boost.org/users/license.html 'Boost Software License')|libraries that give C++ a boost|1.72.0|[repo](https://github.com/boostorg/boost 'boost repo on github')|none|
|[bzip2](https://en.wikipedia.org/wiki/Bzip2 'bzip2 on wikipedia')|[open](https://spdx.org/licenses/bzip2-1.0.6.html 'bzip2 BSD-style license')|lossless block-sorting data compression library|1.0.6|[repo](https://github.com/smanders/bzip2 'forked bzip2 repo on github')|[diff](https://github.com/smanders/bzip2/compare/v1.0.6...xp1.0.6 'patch/diff')|
|[lcov-to-cobertura-xml](https://github.com/eriwen/lcov-to-cobertura-xml 'lcov-to-cobertura-xml website')|[open](https://github.com/eriwen/lcov-to-cobertura-xml/blob/master/LICENSE 'lcov-to-cobertura-xml license: Apache')|Converts lcov output to Cobertura-compatible XML for CI |1.6|[repo](https://github.com/eriwen/lcov-to-cobertura-xml 'lcov-to-cobertura-xml repo on github')|none|
|[OpenSSL](http://www.openssl.org/ 'OpenSSL website')|[open](http://www.openssl.org/source/license.html 'OpenSSL, SSLeay License: BSD-style')|Cryptography and SSL/TLS Toolkit|1.0.2a|[repo](https://github.com/smanders/openssl 'forked openssl repo on github')|[diff](https://github.com/smanders/openssl/compare/openssl:OpenSSL_1_0_2a...xp_1_0_2a 'patch/diff')|
|[patch](http://www.gnu.org/software/patch 'GNU patch website')|[GPL](http://www.gnu.org/licenses/gpl.html 'GNU GPL v3')|pre-built (MSW), built here (non-MSW) used internally to apply a patch file of differences|2.5.9-7/2.7.5|[repo](http://git.savannah.gnu.org/cgit/patch.git 'patch (git) repo on gnu.org')|none|
|[protobuf](https://developers.google.com/protocol-buffers/ 'Protocol Buffers website')|[open](https://github.com/google/protobuf/blob/v3.11.2/LICENSE '3-clause BSD license')|language-neutral, platform-neutral extensible mechanism for serializing structured data|3.11.2|[repo](https://github.com/smanders/protobuf 'forked protobuf repo on github')|[diff](https://github.com/smanders/protobuf/compare/google:v3.11.2...xp3.11.2_temp 'patch/diff')|
|[RapidJSON](http://miloyip.github.io/rapidjson/ 'RapidJSON on githubio')|[open](https://raw.githubusercontent.com/miloyip/rapidjson/master/license.txt 'The MIT License - http://opensource.org/licenses/mit-license.php')|C++ library for parsing and generating JSON|1.1.0|[repo](https://github.com/miloyip/rapidjson 'rapidjson repo on github')|none|
|[RapidXml](http://rapidxml.sourceforge.net/ 'RapidXml on sourceforge')|[open](http://rapidxml.sourceforge.net/license.txt 'Boost Software License -or- The MIT License')|fast XML parser|1.13|[repo](https://github.com/smanders/rapidxml 'rapidxml repo on github')|[diff](https://github.com/smanders/rapidxml/compare/v1.13...xp1.13 'patch/diff')|
|[zlib](http://zlib.net/ 'zlib website')|[open](http://zlib.net/zlib_license.html 'zlib license')|compression library|1.2.8|[repo](https://github.com/smanders/zlib 'forked zlib repo on github')|[diff](https://github.com/smanders/zlib/compare/madler:v1.2.8...xp1.2.8 'patch/diff')|


## dependency graph

![deps.dot graph](https://g.gravizo.com/source/depgraph_7534f50dff50e228418c5fa10ab8ade8?https%3A%2F%2Fraw.githubusercontent.com%2Fcameronfrandsen%2Fexternprolite%2Fdev%2Fprojects%2FREADME.md)
<details>
<summary></summary>
depgraph_7534f50dff50e228418c5fa10ab8ade8
digraph GG {
  node [fontsize=12];
  boost [shape=diamond];
  boost -> zlib;
  boost -> bzip2;
  bzip2 [shape=diamond];
  openssl [shape=diamond];
  protobuf [shape=diamond];
  protobuf -> zlib;
  zlib [shape=diamond];
}
depgraph_7534f50dff50e228418c5fa10ab8ade8
</details>
