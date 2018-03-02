#include "applicationui.hpp"


using namespace bb::cascades;


namespace pronic { namespace camera { // NAMESPACE


ApplicationUI::ApplicationUI(bb::cascades::Application *app) : QObject()
{
    // Assign application pointer
	application = app;

	// To verifying how signals with slots are connecting
	bool ok;

	// Connecting exit app signal
	ok = QObject::connect(application, SIGNAL(aboutToQuit()), this, SLOT(onAboutToQuit()));
	if (!ok)
	{
		qDebug() << "Error connecting signal aboutToQuit()";
	}

	// Creating helpers
	config = new Configurator();
	util = new Util();
	util->prepareDataDir();
	crypto = new Crypto(config);
	invokator = new Invokator(config, crypto, util);

    // Connecting invoke manager signal
    ok = QObject::connect(invokator->getInvokeManager(), SIGNAL(invoked(const bb::system::InvokeRequest&)),
            this, SLOT(handleInvoke(const bb::system::InvokeRequest&)));
    if (!ok)
    {
        qDebug() << "Error connecting signal invoked()";
    }

    // Connecting card resized signal
    ok = QObject::connect(invokator->getInvokeManager(),
            SIGNAL(cardResizeRequested(const bb::system::CardResizeMessage&)),
            this, SLOT(resized(const bb::system::CardResizeMessage&)));
    if (!ok)
    {
        qDebug() << "Error connecting signal cardResizeRequested()";
    }

    // Connecting card done signal
    ok = QObject::connect(invokator->getInvokeManager(),
            SIGNAL(cardPooled(const bb::system::CardDoneMessage&)), this,
            SLOT(pooled(const bb::system::CardDoneMessage&)));
    if (!ok)
    {
        qDebug() << "Error connecting signal cardPooled()";
    }

    // Check startup mode to properly start app
    switch (invokator->getInvokeManager()->startupMode())
    {
        // Launched as app from icon
        case ApplicationStartupMode::LaunchApplication:
            startupMode = "LaunchApp";
            qDebug() << "Launch app";
            initMainUI();
            break;

        // Launched as app
        case ApplicationStartupMode::InvokeApplication:
            startupMode = "InvokeApp";
            qDebug() << "Invoke app";
            break;

        // Launches as card
        case ApplicationStartupMode::InvokeCard:
            startupMode = "InvokeCard";
            qDebug() << "Invoke card";
            break;
    }
}


void ApplicationUI::handleInvoke(const InvokeRequest& request)
{
    config->read();

    // Read invokation data
    source = QString::fromLatin1("%1 (%2)").arg(request.source().installId()).
            arg(request.source().groupId());
    qDebug() << "##### SOURCE: " << source;
    target = request.target();
    qDebug() << "TARGET: " << target;
    action = request.action();
    qDebug() << "ACTION: " << action;
    mimeType = request.mimeType();
    qDebug() << "MIME: " << mimeType;
    uri = request.uri().toString();
    qDebug() << "URI: " << uri;
    data = QString::fromUtf8(request.data());
    qDebug() << "DATA: " << data;

    if (target == "si.pronic.secpictures")
    {
        qDebug() << "Invoking: message viewer - data length: " << data.length();
        initViewUI();
    }

}


void ApplicationUI::initMainUI()
{
    // Active card
    qDebug() << "initMainUI";
    QmlDocument *qmlCover = QmlDocument::create("asset:///CameraCover.qml").parent(this);
    qDebug() << "Cover QML created";
    if (!qmlCover->hasErrors())
    {
        Container *coverContainer = qmlCover->createRootObject<Container>();
        SceneCover *sceneCover = SceneCover::create().content(coverContainer);
        Application::instance()->setCover(sceneCover);
    }

    // Delete temporary files
//    util->prepareWorkingDir();
    qDebug() << "Work dir prepared";

    // Sleep to show logo
    sleep(500);
    qDebug() << "Slept for 200ms";

    qDebug() << "Password: " << config->getPassword();
    // If there config is not initialized then go through setup process otherwise show main screen
    if (!config->getInitialized())
    {
        qDebug() << "Going welcome";
        showWelcome();
    }
    else
    {
        qDebug() << "Going main";
        showMain();
    }
}


void ApplicationUI::showWelcome()
{
    qDebug() << "##### Showing welcome";

    // Remove previous screen if any
    AbstractPane *previousScene = Application::instance()->scene();
    if (previousScene)
    {
        previousScene->setParent(NULL);
    }

    // Create welcome screen
    QmlDocument *qml = QmlDocument::create("asset:///WelcomePane.qml").parent(this);
    qml->setContextProperty("app", this);
    qml->setContextProperty("crypto", crypto);
    qml->setContextProperty("util", util);
    qml->setContextProperty("config", config);
    qml->setContextProperty("invokator", invokator);
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(root);

    // Delete previous screen instance
    if (previousScene)
    {
        previousScene->deleteLater();
    }
}


void ApplicationUI::showMain()
{
    // Remove previous screen if any
    AbstractPane *previousScene = Application::instance()->scene();
    if (previousScene)
    {
        previousScene->setParent(NULL);
    }
    qDebug() << "Previous scene removed";

    // Create main screen
    QmlDocument *qml = QmlDocument::create("asset:///main.qml").parent(this);
    qDebug() << "Main QML created";
    qml->setContextProperty("app", this);
    qml->setContextProperty("crypto", crypto);
    qml->setContextProperty("util", util);
    qml->setContextProperty("config", config);
    qml->setContextProperty("invokator", invokator);
    qDebug() << "Context properties set";
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(root);
    qDebug() << "Scene set";

    // Delete previous screen instance
    if (previousScene)
    {
        previousScene->deleteLater();
    }
}


void ApplicationUI::initViewUI()
{
    // Showing viewer
    QmlDocument *qml = QmlDocument::create("asset:///Viewer.qml");
    qml->setContextProperty("app", this);
    qml->setContextProperty("crypto", crypto);
    qml->setContextProperty("util", util);
    qml->setContextProperty("config", config);
    qml->setContextProperty("invokator", invokator);
    AbstractPane *root = qml->createRootObject<AbstractPane>();
    Application::instance()->setScene(root);
    root->setProperty("file", uri);
}


void ApplicationUI::sleep(int ms)
{
    CameraThread::msleep(ms);
}


void ApplicationUI::onAboutToQuit()
{
    // Delete all helper instances
	qDebug() << "onAboutToQuit()";
    if (invokator)
    {
        delete invokator;
    }
    if (util)
    {
        delete util;
    }
    if (crypto)
    {
        delete crypto;
    }
    if (config)
    {
        delete config;
    }
}


QString ApplicationUI::getStartupMode()
{
    return startupMode;
}


void ApplicationUI::resized(const bb::system::CardResizeMessage&)
{
    qDebug() << "##### Resized!";
}


void ApplicationUI::pooled(const bb::system::CardDoneMessage& doneMessage)
{
    qDebug() << "##### Pooled!";

}


} } // NAMESPACE
