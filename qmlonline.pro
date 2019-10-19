TARGET = qmlonline

CONFIG += \
    c++14

QT += gui quick qml widgets

SOURCES += \
    src/main.cpp \
    src/syntaxhighlighter.cpp \

HEADERS += \
    src/syntaxhighlighter.h \

RESOURCES += \
    resources.qrc
