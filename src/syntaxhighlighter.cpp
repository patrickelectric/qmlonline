#include "syntaxhighlighter.h"
#include <QRegularExpression>

SyntaxHighlighter::SyntaxHighlighter(QTextDocument* parent)
    : QSyntaxHighlighter(parent)
{
    // Match some keywords
    QStringList keywordPatterns {
        "else",
        "false",
        "for",
        "if",
        "import",
        "on",
        "parent",
        "property",
        "return",
        "signal",
        "true",
        "var",
    };
    QString wordBoundariesTag{"\\b"};
    for (QString regexString: keywordPatterns) {
        regexString.prepend(wordBoundariesTag);
        regexString.append(wordBoundariesTag);
        updateRules(regexString, Qt::blue);
    }

    // Properties
    updateRules(R"(([A-z\.]+)(?=:))", Qt::darkRed);

    // Numbers
    updateRules(R"(\b\d+\b)",Qt::magenta);

    // Find items
    updateRules(R"(\b.*(?=\{))", Qt::darkBlue);

    // Find comments and strings
    updateRules(R"(\".*\")", Qt::darkGreen);
    updateRules(R"(\'.*\')", Qt::darkGreen);
    updateRules(R"(\/\/.*)", Qt::darkGreen);
    // This is not working for comment blocks
    updateRules(R"(\/\*((.|\n)*)\*\/)", Qt::darkGreen);

    // Find imports
    updateRules(R"(\b(import).*\d)", Qt::blue);
}

void SyntaxHighlighter::highlightBlock(const QString& text)
{
    // No comments for now..
    setCurrentBlockState(0);

    // Poor comment logic...
    if (!multLineComment.started) {
        QRegExp regex{multLineComment.pattern()};
        int index = regex.indexIn(text);
        if (index > -1) {
            multLineComment.started = true;
            QRegExp regex2{multLineComment.pattern()};
            int index2 = regex2.indexIn(text);
            if (index2 > -1) {
                multLineComment.started = false;
                setFormat(index, index2 + regex2.matchedLength(), multLineComment.format);
                return;
            }

            setFormat(index, text.length(), multLineComment.format);
            multLineComment.started = true;
            setCurrentBlockState(1);
            return;
        }
    } else {
        QRegExp regex{multLineComment.pattern()};
        int index = regex.indexIn(text);
        if (index > -1) {
            multLineComment.started = false;
            setFormat(0, index + regex.matchedLength(), multLineComment.format);
        } else {
            setFormat(0, text.length(), multLineComment.format);
            setCurrentBlockState(1);
            return;
        }
    }

    if(currentBlockState()) {
        setFormat(0, text.length(), multLineComment.format);
        return;
    }

    // Everything else that is not a comment
    for(const HighlightingRule &rule: highlightingRules){
        QRegularExpression regex(rule.pattern);
        auto iterator = regex.globalMatch(text);
        while (iterator.hasNext()) {
            auto match = iterator.next();
            setFormat(match.capturedStart(), match.capturedLength(), rule.format);
        }
    }
}
