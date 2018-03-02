
#include <QTimer>
#include <bb/system/SystemCredentialsPrompt>
#include <bb/system/SystemDialog>
#include <bb/system/SystemPrompt>
#include <bb/system/SystemToast>
#include <bb/system/SystemUiButton>
#include <bb/system/SystemUiError>
#include <bb/system/SystemUiInputField>
#include <bb/system/SystemUiInputMode>
#include <bb/system/SystemUiPosition>
#include <bb/system/SystemUiResult>
#include <bb/system/SystemListDialog>

#include "applicationui.hpp"


using namespace bb::cascades;
using namespace pronic::camera;


Q_DECL_EXPORT int main(int argc, char **argv)
{
    // Creating app object
    Application app(argc, argv);

    // Registering classes
    qmlRegisterType<QTimer>("bb.core", 1, 3, "QTimer");
    qmlRegisterType<bb::system::SystemUiButton>("bb.system", 1, 2, "SystemUiButton");
    qmlRegisterType<bb::system::SystemListDialog>("bb.system", 1, 2, "SystemListDialog");
    qmlRegisterType<bb::system::SystemUiInputField>("bb.system", 1, 2, "SystemUiInputField");
    qmlRegisterType<bb::system::SystemToast>("bb.system", 1, 2, "SystemToast");
    qmlRegisterType<bb::system::SystemPrompt>("bb.system", 1, 2, "SystemPrompt");
    qmlRegisterType<bb::system::SystemCredentialsPrompt>("bb.system", 1, 2, "SystemCredentialsPrompt");
    qmlRegisterType<bb::system::SystemDialog>("bb.system", 1, 2, "SystemDialog");
    qmlRegisterUncreatableType<bb::system::SystemUiError>("bb.system", 1, 2, "SystemUiError", "");
    qmlRegisterUncreatableType<bb::system::SystemUiResult>("bb.system", 1, 2, "SystemUiResult", "");
    qmlRegisterUncreatableType<bb::system::SystemUiPosition>("bb.system", 1, 2, "SystemUiPosition", "");
    qmlRegisterUncreatableType<bb::system::SystemUiInputMode>("bb.system", 1, 2, "SystemUiInputMode", "");
    qmlRegisterUncreatableType<bb::system::SystemUiModality>("bb.system", 1, 2, "SystemUiModality", "");
    qRegisterMetaType<bb::system::SystemUiResult::Type>("bb::system::SystemUiResult::Type");

    // Create instance of Secure Pictures app and start it
    ApplicationUI appui(&app);
    return Application::exec();
}
