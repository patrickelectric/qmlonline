TARGET = qmlonline

CONFIG += \
    c++14 \
    static \


include(3rdparty/kirigami/kirigami.pri)

QT += \
    bluetooth \
    charts \
    gui \
    multimedia \
    network \
    opengl \
    printsupport \
    qml \
    quick \
    quickwidgets \
    svg \
    widgets \
    xml \
    texttospeech

SOURCES += \
    src/main.cpp \
    src/util.cpp \

HEADERS += \
    src/util.h \

RESOURCES += \
    resources.qrc