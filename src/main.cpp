#include <QApplication>
#include <QQmlApplicationEngine>

#include "examples.h"
#include "syntaxhighlighter.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<Examples>("Examples", 1, 0, "Examples");
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 0, "SyntaxHighlighter");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine appEngine(QUrl("qrc:/main.qml"));
    return app.exec();
}
