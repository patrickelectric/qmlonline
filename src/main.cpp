#include <QApplication>
#include <QQmlApplicationEngine>

#include "examples.h"
#include "util.h"
#include "syntaxhighlighter.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<Examples>("Examples", 1, 0, "Examples");
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 0, "SyntaxHighlighter");
    qmlRegisterSingletonType<Util>("Util", 1, 0, "Util", Util::qmlSingletonRegister);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine appEngine(QUrl("qrc:/main.qml"));
    return app.exec();
}
