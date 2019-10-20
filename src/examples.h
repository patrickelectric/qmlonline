#pragma once

#include <QObject>
#include <QVariant>

struct Example
{
    Q_GADGET
    Q_PROPERTY(QString name MEMBER name)
    Q_PROPERTY(QString path MEMBER path)
public:
    bool operator==(const Example& other) const {
        return (name == other.name) && (path == other.path);
    }

    QString name;
    QString path;
};
Q_DECLARE_METATYPE(Example)

class Examples : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariantList examples MEMBER _examples CONSTANT)
public:
    Examples(QObject* parent = nullptr);

    Q_INVOKABLE QString getTextFromExample(const QString& example) const;

private:
    QString _basePath{":/examples/"};

    QVariantList _examples;


    QString _header{
        R"(/* QML online!
 * Repository: https://github.com/patrickelectric/qmlonline
 *
 * You can check the offline/desktop version here **QHot!**:
 *     https://github.com/patrickelectric/qhot
 *
 * I'm working heavily and the web version is WIP,
 * be patient (and happy!), changes will be done soon.
 *
 */

// - Just edit the text or use the "Update!" button to update the Qml
// - Use your browser console to check the error/warning messages!
// - If something is not working, check if you are running the https version
)"
    };
};
