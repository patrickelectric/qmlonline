#!/bin/sh

DOCKER_IMAGE=stateoftheartio/qt6:6.6-wasm-aqt
EMS_CACHE=$HOME/.emscripten_cache
SOURCE_DIR=$PWD

DOCKER_COMMAND="docker run --rm -v $EMS_CACHE:/emsdk_portable/.data/cache -v $SOURCE_DIR/:/home/user/project:ro -u $(id -u):$(id -g) $DOCKER_IMAGE"

# Build
mkdir -p build
$DOCKER_COMMAND sh -c "qmake6 -o /src/build CONFIG+=release"
$DOCKER_COMMAND sh -c "make -C /src/build"

# Remove intermediary files
rm -rf build/{moc,objects,*.cpp}