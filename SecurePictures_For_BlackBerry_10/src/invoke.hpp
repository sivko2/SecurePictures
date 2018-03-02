#ifndef INVOKE_HPP_
#define INVOKE_HPP_


#include <QVariantMap>
#include <QVariantList>
#include <QTemporaryFile>
#include <QByteArray>
#include <bb/cascades/Application>
#include <bb/cascades/InvokeQuery>
#include <bb/system/InvokeManager>
#include <bb/system/InvokeRequest>
#include <bb/system/SystemPrompt>
#include <bb/system/SystemUiResult>
#include <bb/PpsObject>
#include <bb/system/CardDoneMessage>
#include "crypto.hpp"
#include "config.hpp"
#include "util.hpp"

using namespace bb::cascades;
using namespace bb::system;


namespace pronic { namespace camera { // NAMESPACE


class Invokator : public QObject
{
	Q_OBJECT

public:

	// Constructor and destructor
    Invokator(Configurator *_config, Crypto *_crypto, Util *_util);
    virtual ~Invokator() {};

    // Invoke settings' screen for permissions, camera, and more
    Q_INVOKABLE void invokePermissions();
    Q_INVOKABLE void invokeCamera();
    Q_INVOKABLE void invokeVideo();
    Q_INVOKABLE void invokeVoice();
    Q_INVOKABLE void invokeMoreApps();
    Q_INVOKABLE void invokePicViewer(const QString &path, const QString &filename);
    Q_INVOKABLE void invokeMoviePlayer(const QString &path, const QString &filename);

    // Invoke close card
    Q_INVOKABLE void closeCard();

    // Getters
    InvokeManager* getInvokeManager();

    // Invoke manager pointer
    InvokeManager* invokeManager;

signals:

    void newMediaFileAdded();

private Q_SLOTS:

    void onCameraCardDone(const bb::system::CardDoneMessage &message);
    void onViewerCardDone(const bb::system::CardDoneMessage &message);
    void onRenameFinished(bb::system::SystemUiResult::Type);

private:

    Configurator* config;
    Crypto* crypto;
    Util* util;
    SystemPrompt* prompt;
    QString originalName;
    QString suffix;
    QString path;
};


} } // NAMESPACE


#endif /* INVOKE_HPP_ */
