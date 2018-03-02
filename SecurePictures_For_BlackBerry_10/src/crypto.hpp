#ifndef CRYPTO_HPP_
#define CRYPTO_HPP_


#include <QObject>
#include <QDebug>
#include <QByteArray>
#include <sbreturn.h>
#include <huctx.h>
#include <hugse56.h>
#include <huseed.h>
#include <hurandom.h>
#include <huaes.h>
#include <QtCore/QtCore>
#include <bb/data/JsonDataAccess>

#include "config.hpp"


using namespace bb::data;


namespace pronic { namespace camera { // NAMESPACE


class Crypto : public QObject
{
    Q_OBJECT

public:

    // Constructor and destructor
    Crypto(Configurator *_config);
    ~Crypto();

    static const char* AES_KEY;
    static const char* AES_IV;

    QByteArray encryptAESImpl(QByteArray plainData, sb_Key &key);
    QByteArray decryptAESImpl(QByteArray cipherData, sb_Key &key);
    Q_INVOKABLE QByteArray encryptAES(QByteArray plainData);
    Q_INVOKABLE QByteArray decryptAES(QByteArray cipherData);
    Q_INVOKABLE void setKey(const QString &password);

    QString toHex(const QByteArray &in);
    bool fromHex(const QString in, QByteArray &toReturn);

private:

	static QMap<int, QString> errors;
	static void buildErrors();
	static QString getErrorText(int error);

	QByteArray getRandomBytes(QByteArray &buffer);
    void pad(QByteArray &in, int pad);
    bool removePadding(QByteArray &out, int pad);
    QString fromHexToQString(const QString &in);
    char nibble(char c);

	sb_GlobalCtx context;

	sb_RNGCtx randomContext;

	sb_Params aesParams;
	sb_Key aesKey;

	Configurator *config;
};


} } // NAMESPACE


#endif
