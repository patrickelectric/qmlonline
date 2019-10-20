#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include <QDir>

#include "examples.h"
#include "syntaxhighlighter.h"

#ifdef EMSCRIPTEN
#include <emscripten/val.h>
#endif

int main(int argc, char *argv[])
{
    qmlRegisterType<Examples>("Examples", 1, 0, "Examples");
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 0, "SyntaxHighlighter");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine(QUrl("qrc:/main.qml"));
#ifdef EMSCRIPTEN
    QString protocol = emscripten::val::global("window")["location"]["search"].as<std::string>().c_str();
#else
    QString protocol = "";
#endif
    engine.rootContext()->setContextProperty("SHARED_CODE", protocol);
    qDebug() << protocol;
    return app.exec();
}
