TARGET = qmlonline

CONFIG += \
    c++14

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
    src/examples.cpp \
    src/util.cpp \
    src/syntaxhighlighter.cpp \

HEADERS += \
    src/examples.h \
    src/util.h \
    src/syntaxhighlighter.h \

RESOURCES += \
    resources.qrc
