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
    return self;
}

Util::~Util() {}

#ifdef EMSCRIPTEN

#include <emscripten/bind.h>

EMSCRIPTEN_BINDINGS(util) {
    emscripten::class_<Util>("Util")
        .function("code", &Util::codeEMS)
        .function("setCode", &Util::setCodeEMS);
    emscripten::function("self", &Util::self, emscripten::allow_raw_pointers());
}

#endif
