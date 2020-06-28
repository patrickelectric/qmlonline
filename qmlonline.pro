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

# Clone or update kirigami repository
KIRIGAMI_TAG = v5.70.0
KIRIGAMI_DIR = 3rdparty/kirigami
exists($$(KIRIGAMI_DIR)) {
    $$system(git --git-dir=$$_PRO_FILE_PWD_/$$KIRIGAMI_DIR/.git fetch)
    $$system(git --git-dir=$$_PRO_FILE_PWD_/$$KIRIGAMI_DIR/.git checkout $$KIRIGAMI_TAG)
} else {
    $$system(git clone -b $$KIRIGAMI_TAG https://github.com/KDE/kirigami $$KIRIGAMI_DIR)
}
include(3rdparty/kirigami/kirigami.pri)

html.files = $$PWD/html/*
html.path = $$OUT_PWD

examples.files = $$PWD/qml
examples.path = $$OUT_PWD

COPIES += html examples

OBJECTS_DIR = $$$$OUT_PWD/objects
MOC_DIR = $$$$OUT_PWD/moc