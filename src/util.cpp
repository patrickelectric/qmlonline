#include "util.h"

#include <QDebug>
#include <QUrl>

#ifdef EMSCRIPTEN
#include <emscripten/val.h>
#include <emscripten.h>
#endif

#ifdef EMSCRIPTEN

EMSCRIPTEN_KEEPALIVE
void sayHi() {
  printf("Hi!\n");
}

#endif

QString Util::sharedCode() const
{
#ifdef EMSCRIPTEN
    sayHi();
    QString code = emscripten::val::global("window")["location"]["search"].as<std::string>().c_str();
#else
    QString code = "";
#endif
    if(code.startsWith("?code=")) {
        return QUrl::fromPercentEncoding(code.remove(0, 6).toLatin1());
    }
    return QUrl::fromPercentEncoding(code.toLatin1());
}

QString Util::createSharedCode(const QString& code, bool tiny) const
{
    if(!tiny) {
        return "https://patrickelectric.work/qmlonline/?code=" + QString(QUrl::toPercentEncoding(code));
    }

    auto url = QString("https://patrickelectric.work/qmlonline/?code=") + code;
    for(const auto item : _urlEncodeMap.toStdMap()) {
        url.replace(item.first, item.second);
    }
    return url;
}

QString Util::code() const
{
    return _code;
}

std::string Util::codeEMS() const
{
    return _code.toStdString();
}

void Util::setCode(const QString& code)
{
    if (_code != code) {
        _code = code;
        emit codeChanged();
    }
}

void Util::setCodeEMS(const std::string& code)
{
    setCode(QString::fromStdString(code));
}

QObject* Util::qmlSingletonRegister(QQmlEngine* engine, QJSEngine* scriptEngine)
{
    Q_UNUSED(engine)
    Q_UNUSED(scriptEngine)

    return self();
}

Util* Util::self()
{
    static Util* self = new Util();
    self->setCode(
R"(
import QtQuick 2.0

Rectangle {
    id: root
    anchors.fill: parent
    color: "black"

    Rectangle {
        id: rect
        width: 50
        height: 50
        color: "red"
        anchors.top: root.top
        anchors.left: root.left
        anchors.margins: 10
    }

    states: [
        State {
            name: "small"
            AnchorChanges {
                target: rect
                anchors.bottom: root.bottom
                anchors.right: root.right
            }
            PropertyChanges {
                target: rect
                height: 50
                width: 50
            }
        },
        State {
            name: "big"
            AnchorChanges {
                target: rect
                anchors.bottom: undefined
                anchors.right: undefined
            }
        }
    ]

    Timer {
        running: true; repeat: true; interval: 1000;
        onTriggered: root.state = root.state ===  "small" ?  "big" : "small"
    }

    transitions: Transition {
        AnchorAnimation { duration: 400 }
    }
}
)"
    );
    return self;
}

Util::~Util() {}

#include <emscripten/bind.h>

EMSCRIPTEN_BINDINGS(util) {
    emscripten::class_<Util>("Util")
        .function("code", &Util::codeEMS)
        .function("setCode", &Util::setCodeEMS);
    emscripten::function("self", &Util::self, emscripten::allow_raw_pointers());
}
