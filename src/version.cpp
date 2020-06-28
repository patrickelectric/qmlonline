#include "version.h"

#ifdef EMSCRIPTEN

#include <emscripten.h>
#include <emscripten/bind.h>
#include <emscripten/val.h>

EMSCRIPTEN_BINDINGS(version) {
    emscripten::class_<Version>("Version")
        .constructor<>()
        .property("hash", &Version::hash)
        .property("date", &Version::date)
        .property("url", &Version::url);
}

#endif
