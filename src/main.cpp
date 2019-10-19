#include <QApplication>
#include <QQmlApplicationEngine>

#include "syntaxhighlighter.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<SyntaxHighlighter>("SyntaxHighlighter", 1, 0, "SyntaxHighlighter");

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine appEngine(QUrl("qrc:/main.qml"));
    return app.exec();
}
