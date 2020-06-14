include(FetchContent)

set(QTWASMCMAKE_REPOSITORY "https://github.com/OlivierLDff/QtWasmCMake.git" CACHE STRING "QtWasmCMake repository, can be a local URL")
set(QTWASMCMAKE_TAG master CACHE STRING "QtWasmCMake git tag")

FetchContent_Declare(
  QtWasmCMake
  GIT_REPOSITORY ${QTWASMCMAKE_REPOSITORY}
  GIT_TAG        ${QTWASMCMAKE_TAG}
)

FetchContent_MakeAvailable(QtWasmCMake)