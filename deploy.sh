#!/bin/sh

DOCKER_IMAGE=madmanfred/qt-webassembly
EMS_CACHE=$HOME/.emscripten_cache
SOURCE_DIR=$PWD

DOCKER_COMMAND="docker run --rm -v $EMS_CACHE:/emsdk_portable/.data/cache -v $SOURCE_DIR/:/src/ -u $(id -u):$(id -g) $DOCKER_IMAGE"

# Build
mkdir -p build
$DOCKER_COMMAND qmake -o /src/build CONFIG+=release
$DOCKER_COMMAND make -C /src/build

# Remove intermediary files
rm -rf build/{moc,objects,*.cpp}