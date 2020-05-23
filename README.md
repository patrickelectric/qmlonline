# QML online

[![Travis Build Status](https://travis-ci.org/patrickelectric/qmlonline.svg?branch=master)](https://travis-ci.org/patrickelectric/qmlonline)

Play online with QML, thanks to WebAssembly!

[CHECK IT HERE!](https://patrickelectric.work/qmlonline/)

> You can also check the [desktop version: QHot!](https://github.com/patrickelectric/qhot)!

## How to build:
1. `docker run --rm -v ~/.emscripten_cache:/emsdk_portable/.data/cache -v $(pwd)/../:/src/ -u $(id -u):$(id -g) madmanfred/qt-webassembly qmake -o /src/build`
2. `docker run --rm -v ~/.emscripten_cache:/emsdk_portable/.data/cache -v $(pwd)/../:/src/ -u $(id -u):$(id -g) madmanfred/qt-webassembly make -C /src/build -j14`
