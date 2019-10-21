#include "util.h"

#include <QDebug>
#include <QUrl>

#ifdef EMSCRIPTEN
#include <emscripten/val.h>
#endif

QString Util::sharedCode() const
{
#ifdef EMSCRIPTEN
    QString code = emscripten::val::global("window")["location"]["search"].as<std::string>().c_str();
#else
    QString code = "";
#endif
    if(code.startsWith("?code=")) {
        return QUrl::fromPercentEncoding(code.remove(0, 6).toLatin1());
    }
    return QUrl::fromPercentEncoding(code.toLatin1());
}

QString Util::createSharedCode(const QString& code) const
{
    return "https://patrickelectric.work/qmlonline/?code=" + QString(QUrl::toPercentEncoding(code));
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
