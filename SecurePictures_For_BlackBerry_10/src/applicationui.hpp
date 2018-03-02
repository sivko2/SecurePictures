#ifndef ApplicationUI_HPP_
#define ApplicationUI_HPP_


#include <QObject>
#include <QString>
#include <bb/cascades/Application>
#include <bb/cascades/QmlDocument>
#include <bb/cascades/AbstractPane>
#include <bb/cascades/Container>
#include <bb/cascades/SceneCover>
#include <bb/cascades/AbstractCover>

#include "config.hpp"
#include "invoke.hpp"
#include "crypto.hpp"
#include "util.hpp"
#include "camerathread.hpp"


using namespace bb::cascades;


namespace pronic { namespace camera { // NAMESPACE


class ApplicationUI : public QObject
{
    Q_OBJECT

public:

    // Startup mode property: app or card
    Q_PROPERTY(QString startupMode READ getStartupMode);

    // Constructor and destructor
    ApplicationUI(bb::cascades::Application *app);
    virtual ~ApplicationUI() {}

    // Initialize when started as app
    void initMainUI();

    // Initialize when started as card
    void initViewUI();

    // Show main screen
    Q_INVOKABLE void showMain();

    // Show welcome initialization screen
    Q_INVOKABLE void showWelcome();

    // Sleep thread method
    Q_INVOKABLE void sleep(int ms);

    // Getters
    QString getStartupMode();

private Q_SLOTS:

    // Handling exiting app
    void onAboutToQuit();

    // ???
    void handleInvoke(const bb::system::InvokeRequest&);

    // Handling screen resize and card being pooled
    void resized(const bb::system::CardResizeMessage&);
    void pooled(const bb::system::CardDoneMessage&);

private:

    // Accessors to instances of helper classes
    Configurator *config;
    Crypto *crypto;
    Util *util;
    Invokator *invokator;

    // Startup mode: app or card
    QString startupMode;
    QString source;
    QString target;
    QString action;
    QString mimeType;
    QString uri;
    QString data;
    QString status;

    // Pointer to app
	Application *application;
};


} } // NAMESPACE


#endif
