TARGET = qmlonline

CONFIG += \
    c++14

QT += gui quick qml widgets

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
