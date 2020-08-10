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
    xmlpatterns \
    texttospeech

SOURCES += \
    src/main.cpp \
    src/util.cpp \
    src/version.cpp \

HEADERS += \
    src/util.h \
    src/version.h \

RESOURCES += \
    resources.qrc

# Clone or update kirigami repository
KIRIGAMI_TAG = v5.70.0
KIRIGAMI_DIR = 3rdparty/kirigami
exists($$KIRIGAMI_DIR) {
    $$system(git --git-dir=$$_PRO_FILE_PWD_/$$KIRIGAMI_DIR/.git fetch --tags)
    $$system(git --git-dir=$$_PRO_FILE_PWD_/$$KIRIGAMI_DIR/.git checkout $$KIRIGAMI_TAG)
} else {
    $$system(git clone -b $$KIRIGAMI_TAG https://github.com/KDE/kirigami $$KIRIGAMI_DIR)
}
include(3rdparty/kirigami/kirigami.pri)

# Clone or update breeze-icons repository
BREEZE_TAG = v5.70.0
BREEZE_DIR = 3rdparty/breeze-icons
exists($$BREEZE_DIR) {
    $$system(git --git-dir=$$_PRO_FILE_PWD_/$$BREEZE_DIR/.git fetch --tags)
    $$system(git --git-dir=$$_PRO_FILE_PWD_/$$BREEZE_DIR/.git checkout $$BREEZE_TAG)
} else {
    $$system(git clone -b $$BREEZE_TAG https://github.com/KDE/breeze-icons $$BREEZE_DIR)
}

html.files = $$PWD/html/*
html.path = $$OUT_PWD

examples.files = $$PWD/qml
examples.path = $$OUT_PWD

COPIES += html examples

OBJECTS_DIR = $$$$OUT_PWD/objects
MOC_DIR = $$$$OUT_PWD/moc

# Get actual build information
GIT_VERSION = $$system(git --git-dir $$_PRO_FILE_PWD_/.git --work-tree $$PWD log -1 --format=%h)
GIT_VERSION_DATE = $$system(git --git-dir $$_PRO_FILE_PWD_/.git --work-tree $$PWD log -1 --pretty='format:%cd' --date=format:'%d/%m/%Y')
GIT_URL = $$system(git --git-dir $$_PRO_FILE_PWD_/.git --work-tree $$PWD remote get-url origin)
DEFINES += 'GIT_VERSION=\\"$$GIT_VERSION\\"'
DEFINES += 'GIT_VERSION_DATE=\\"$$GIT_VERSION_DATE\\"'
DEFINES += 'GIT_URL=\\"$$GIT_URL\\"'

message(" GIT_VERSION:      " $$GIT_VERSION)
message(" GIT_VERSION_DATE: " $$GIT_VERSION_DATE)
message(" GIT_URL:          " $$GIT_URL)
