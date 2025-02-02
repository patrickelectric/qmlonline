cmake_minimum_required(VERSION 3.16)
project(qmlonline VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Bluetooth Charts Gui Multimedia Network OpenGL
    PrintSupport Qml Quick QuickWidgets Svg Widgets
    Xml XmlPatterns TextToSpeech
)

set(SOURCES
    src/main.cpp
    src/util.cpp
    src/version.cpp
)

set(HEADERS
    src/util.h
    src/version.h
)

qt6_add_resources(RESOURCE_ADDED resources.qrc)

add_executable(qmlonline
    ${SOURCES}
    ${HEADERS}
    ${RESOURCE_ADDED}
)

target_link_libraries(qmlonline PRIVATE
    Qt6::Bluetooth
    Qt6::Charts
    Qt6::Gui
    Qt6::Multimedia
    Qt6::Network
    Qt6::OpenGL
    Qt6::PrintSupport
    Qt6::Qml
    Qt6::Quick
    Qt6::QuickWidgets
    Qt6::Svg
    Qt6::Widgets
    Qt6::Xml
    Qt6::XmlPatterns
    Qt6::TextToSpeech
)

execute_process(
    COMMAND git --git-dir ${CMAKE_SOURCE_DIR}/.git --work-tree ${CMAKE_SOURCE_DIR} log -1 --format=%h
    OUTPUT_VARIABLE GIT_VERSION
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
    COMMAND git --git-dir ${CMAKE_SOURCE_DIR}/.git --work-tree ${CMAKE_SOURCE_DIR} log -1 --pretty=format:%cd --date=format:%d/%m/%Y
    OUTPUT_VARIABLE GIT_VERSION_DATE
    OUTPUT_STRIP_TRAILING_WHITESPACE
)
execute_process(
    COMMAND git --git-dir ${CMAKE_SOURCE_DIR}/.git --work-tree ${CMAKE_SOURCE_DIR} remote get-url origin
    OUTPUT_VARIABLE GIT_URL
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

target_compile_definitions(qmlonline PRIVATE
    GIT_VERSION="${GIT_VERSION}"
    GIT_VERSION_DATE="${GIT_VERSION_DATE}"
    GIT_URL="${GIT_URL}"
)

message(STATUS "GIT_VERSION: ${GIT_VERSION}")
message(STATUS "GIT_VERSION_DATE: ${GIT_VERSION_DATE}")
message(STATUS "GIT_URL: ${GIT_URL}")

add_custom_command(TARGET qmlonline POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/html ${CMAKE_CURRENT_BINARY_DIR}/html
    COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_SOURCE_DIR}/qml ${CMAKE_CURRENT_BINARY_DIR}/qml
)
