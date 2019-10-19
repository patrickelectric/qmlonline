#pragma once

#include <QSyntaxHighlighter>
#include <QQuickTextDocument>

class SyntaxHighlighter : public QSyntaxHighlighter
{
    Q_OBJECT

    Q_PROPERTY(QQuickTextDocument* textDocument WRITE setTextDocument)
public:
    SyntaxHighlighter(QTextDocument* parent = nullptr);

    void setTextDocument(QQuickTextDocument* document) { return setDocument(document->textDocument()); };

protected:
    void highlightBlock(const QString& text);

    void updateRules(const QString& pattern, const QColor& color) {
        QTextCharFormat format;
        format.setForeground(color);
        highlightingRules.append({
            pattern,
            format
        });
    }

private:
    struct HighlightingRule
    {
        QString pattern;
        QTextCharFormat format;
    };
    QVector<HighlightingRule> highlightingRules;

    struct MultLineComment {
        bool started{false};
        QString pattern() {
            return {started ? R"(\*\/)" : R"(\/\*)"};
        };
        QTextCharFormat format;

        MultLineComment() {
            format.setForeground(Qt::darkGreen);
        }
    } multLineComment;
};
