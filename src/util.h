#pragma once

#include <QObject>

class QJSEngine;
class QQmlEngine;
class QQuickView;

/**
 * @brief Singleton helper for qml interface
 *
 */
class Util : public QObject {
    Q_OBJECT

public:
    /**
     * @brief Provide the code shared around web apps
     *
     * @return QString
     */
    Q_INVOKABLE QString sharedCode() const;

    /**
     * @brief Create a url that provides the code
     *
     * @param code
     * @return QString
     */
    Q_INVOKABLE QString createSharedCode(const QString& code) const;

    /**
     * @brief Return Util pointer
     *
     * @return Util*
     */
    static Util* self();
    ~Util();

    /**
     * @brief Return a pointer of this singleton to the qml register function
     *
     * @param engine
     * @param scriptEngine
     * @return QObject*
     */
    static QObject* qmlSingletonRegister(QQmlEngine* engine, QJSEngine* scriptEngine);

private:
    Q_DISABLE_COPY(Util)
    /**
     * @brief Construct a new Util object
     *
     */
    Util() = default;
};
