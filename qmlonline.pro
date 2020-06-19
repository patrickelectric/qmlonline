TARGET = qmlonline

CONFIG += \
    c++14 \
    file_copies \

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

include(3rdparty/kirigami/kirigami.pri)

html.files = $$PWD/html/*
html.path = $$OUT_PWD

examples.files = $$PWD/qml
examples.path = $$OUT_PWD

COPIES += html examples

OBJECTS_DIR = $$$$OUT_PWD/objects
MOC_DIR = $$$$OUT_PWD/moc