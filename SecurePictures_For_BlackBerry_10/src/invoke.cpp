
#include "invoke.hpp"


using namespace bb::cascades;
using namespace bb::system;


namespace pronic { namespace camera { // NAMESPACE


Invokator::Invokator(Configurator *_config, Crypto *_crypto, Util *_util)
{
    config = _config;
    crypto = _crypto;
    util = _util;
	invokeManager = new InvokeManager(this);
}


InvokeManager* Invokator::getInvokeManager()
{
	return invokeManager;
}


void Invokator::closeCard()
{
    CardDoneMessage message;
    message.setData("OK");
    message.setDataType("text/plain");
    message.setReason("Success");
    invokeManager->sendCardDone(message);
}


void Invokator::invokePicViewer(const QString &path, const QString &filename)
{
    crypto->setKey(config->getPassword());
    qDebug() << "loading " << (path + "/" + filename);
    QByteArray encryptData = util->loadBinary(path + "/" + filename);
    qDebug() << "real size: " << encryptData.length();
    QString suffix = filename.mid(filename.lastIndexOf(".") + 2);
    QByteArray fileData = crypto->decryptAES(encryptData);
    QString newFilename = filename.left(filename.lastIndexOf(".")) + "." + suffix;
    util->saveBinary("data/" + newFilename, fileData);
    QString realFileName = QString("file://" + QDir::currentPath() + "/data/" + newFilename);

    qDebug() << "#### Invoke pic viewer: " << filename;
    InvokeRequest request;
    request.setTarget("sys.pictures.card.previewer");
    request.setAction("bb.action.VIEW");
    request.setMimeType("image/jpeg");
    request.setUri(realFileName);
    invokeManager->invoke(request);

    QObject::connect(invokeManager, SIGNAL(childCardDone(const bb::system::CardDoneMessage&)),
            this, SLOT(onViewerCardDone(const bb::system::CardDoneMessage&)));
}


void Invokator::invokeMoviePlayer(const QString &path, const QString &filename)
{
    crypto->setKey(config->getPassword());
    QByteArray encryptData = util->loadBinary(path + "/" + filename);
    QString suffix = filename.mid(filename.lastIndexOf(".") + 2);
    QByteArray fileData = crypto->decryptAES(encryptData);
    QString newFilename = filename.left(filename.lastIndexOf(".")) + "." + suffix;
    util->saveBinary("data/" + newFilename, fileData);
    QString realFileName = QString("file://" + QDir::currentPath() + "/data/" + newFilename);

    qDebug() << "#### Invoke movie player: " << filename;
    InvokeRequest request;
    request.setTarget("sys.mediaplayer.previewer");
    request.setAction("bb.action.VIEW");
    request.setMimeType("video/mp4");
    request.setUri(realFileName);
    invokeManager->invoke(request);

    QObject::connect(invokeManager, SIGNAL(childCardDone(const bb::system::CardDoneMessage&)),
            this, SLOT(onViewerCardDone(const bb::system::CardDoneMessage&)));
}


void Invokator::invokePermissions()
{
    // Invoke settings' screen for permissions
	InvokeRequest request;
	request.setTarget("sys.settings.card");
	request.setAction("bb.action.OPEN");
	request.setMimeType("settings/view");
	request.setUri("settings://permissions");
	invokeManager->invoke(request);
}


void Invokator::invokeVoice()
{
    InvokeRequest request;
    request.setTarget("sys.apps.audiorecorder");
    request.setAction("bb.action.CAPTURE");
    request.setMimeType("audio/mp4");
    invokeManager->invoke(request);

    QObject::connect(invokeManager, SIGNAL(childCardDone(const bb::system::CardDoneMessage&)),
            this, SLOT(onCameraCardDone(const bb::system::CardDoneMessage&)));
}


void Invokator::invokeCamera()
{
    InvokeRequest request;
    request.setTarget("sys.camera.card");
    request.setAction("bb.action.CAPTURE");
    request.setData(QString("photo").toUtf8());
    invokeManager->invoke(request);

    QObject::connect(invokeManager, SIGNAL(childCardDone(const bb::system::CardDoneMessage&)),
            this, SLOT(onCameraCardDone(const bb::system::CardDoneMessage&)));
}


void Invokator::invokeVideo()
{
    InvokeRequest request;
    request.setTarget("sys.camera.card");
    request.setAction("bb.action.CAPTURE");
    request.setData(QString("video").toUtf8());
    invokeManager->invoke(request);

    QObject::connect(invokeManager, SIGNAL(childCardDone(const bb::system::CardDoneMessage&)),
            this, SLOT(onCameraCardDone(const bb::system::CardDoneMessage&)));
}


void Invokator::invokeMoreApps()
{
    InvokeRequest request;
    request.setTarget("sys.appworld");
    request.setAction("bb.action.OPEN");
    request.setUri("appworld://vendor/8198");
    invokeManager->invoke(request);
}


void Invokator::onViewerCardDone(const CardDoneMessage &message)
{
    QObject::disconnect(invokeManager, SIGNAL(childCardDone(const bb::system::CardDoneMessage&)),
            this, SLOT(onViewerCardDone(const bb::system::CardDoneMessage&)));
    qDebug() << "##### Card done: " << message.reason();
    closeCard();
}


void Invokator::onCameraCardDone(const CardDoneMessage &message)
{
    QObject::disconnect(invokeManager, SIGNAL(childCardDone(const bb::system::CardDoneMessage&)),
            this, SLOT(onCameraCardDone(const bb::system::CardDoneMessage&)));
    qDebug() << "##### Camera card done: " << message.reason();
    if (message.reason() == "save" || message.reason() == "closed")
    {
        qDebug() << "##### File: " << message.data();

        crypto->setKey(config->getPassword());
        QByteArray fileData = util->loadBinary(message.data());
        suffix = message.data().mid(message.data().lastIndexOf(".") + 1);
        QByteArray encryptedData = crypto->encryptAES(fileData);
        QString filename = message.data().left(message.data().lastIndexOf(".")) + ".s" + suffix;
        suffix = ".s" + suffix;
        qDebug() << "New file: " << filename;
        util->saveBinary(filename, encryptedData);
        util->deleteFile(message.data());

        if (config->getMultiShots() && suffix == ".sjpg")
        {
            invokeCamera();
        }
        else
        {
            originalName = filename.mid(filename.lastIndexOf("/") + 1);
            path = filename.mid(0, filename.lastIndexOf("/"));
            prompt = new SystemPrompt(this);
            prompt->setTitle("Rename");
            prompt->setDismissAutomatically(true);
            prompt->confirmButton()->setEnabled(true);
            prompt->confirmButton()->setLabel("Yes");
            prompt->cancelButton()->setEnabled(true);
            prompt->cancelButton()->setLabel("No");
            prompt->customButton()->setEnabled(true);
            prompt->customButton()->setLabel("Delete");
            prompt->setBody("Do you want to rename the name of the file " + originalName + "?");
            prompt->inputField()->setDefaultText(originalName);

            // Connect the finished() signal to the onPromptFinished() slot.


            QObject::connect(prompt, SIGNAL(finished(bb::system::SystemUiResult::Type)),
                 this, SLOT(onRenameFinished(bb::system::SystemUiResult::Type)));
            prompt->show();
        }

    }
}


void Invokator::onRenameFinished(bb::system::SystemUiResult::Type type)
{
    if (type == SystemUiResult::ConfirmButtonSelection)
    {
        qDebug() << "You clicked YES!!!";
        QString value = prompt->inputFieldTextEntry();

        if (value.toUpper().lastIndexOf(suffix.toUpper()) <= 0)
        {
            value = value + suffix;
        }
        qDebug() << "New filename: " << value;
        qDebug() << "Path: " << path;
        util->renameFile(path  + "/" + originalName, path + "/" + value);
        prompt->deleteLater();
        emit newMediaFileAdded();
    }
    else if (type == SystemUiResult::CustomButtonSelection)
    {
        qDebug() << "You clicked DELETE";
        util->deleteFile(path  + "/" + originalName);
        prompt->deleteLater();
    }

}


} } // NAMESPACE
