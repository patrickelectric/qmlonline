include(FetchContent)

FetchContent_Declare(
  QtStaticCMake
  GIT_REPOSITORY https://github.com/OlivierLDff/QtStaticCMake
  GIT_TAG        master
)

FetchContent_MakeAvailable(QtStaticCMake)