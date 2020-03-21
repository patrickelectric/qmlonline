#pragma once

#include <QObject>
#include <QMap>

class QJSEngine;
class QQmlEngine;
class QQuickView;

/**
 * @brief Singleton helper for qml interface
 *
 */
class Util : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString code READ code NOTIFY codeChanged)

public:
    /**
     * @brief Return the code
     *
     * @return QString
     */
    QString code() const;

    /**
     * @brief Get code via std::string
     *
     * @return QString
     */
    std::string codeEMS() const;

    /**
     * @brief Set the code
     *
     * @param code
     */
    void setCode(const QString& code);

    /**
     * @brief Set the code via std::string
     *
     * @param code
     */
    void setCodeEMS(const std::string& code);

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

signals:
    void codeChanged();

private:
    Q_DISABLE_COPY(Util)
    /**
     * @brief Construct a new Util object
     *
     */
    Util() = default;

    QString _code;
};
