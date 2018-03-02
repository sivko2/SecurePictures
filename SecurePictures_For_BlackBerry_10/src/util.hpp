#ifndef UTIL_HPP_
#define UTIL_HPP_


#include <QObject>
#include <QDateTime>
#include <QtGlobal>
#include <QString>
#include <QVariantMap>
#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QFileInfoList>
#include <QDebug>
#include <QTextStream>
#include <QDataStream>
#include <QVariantList>
#include <QtCore/QtCore>
#include <bb/PackageInfo>
#include <bb/device/HardwareInfo>
#include <bb/device/DisplayInfo>
#include <bb/platform/PlatformInfo>


using namespace bb::platform;
using namespace bb::device;


namespace pronic { namespace camera { // NAMESPACE


class Util : public QObject
{
	Q_OBJECT

public:

    // Constructor and destructor
	Util();
	~Util();

	// Properties for hardware
	Q_PROPERTY(QString hardwareInfo READ getHardwareInfo);
	Q_PROPERTY(QString hardwareNumber READ getHardwareNumber);
	Q_PROPERTY(int screenWidth READ getScreenWidth);
	Q_PROPERTY(int screenHeight READ getScreenHeight);
	Q_PROPERTY(QString version READ getVersion);
	Q_PROPERTY(QString osVersion READ getOsVersion);
	Q_PROPERTY(QString pin READ getPIN);

	// Get time in milliseconds from 01.01.1970
	Q_INVOKABLE QString getTimeInMillis();

	// Delete a file
    Q_INVOKABLE void deleteFile(const QString &fileName);

    // Delete a file
    Q_INVOKABLE void renameFile(const QString &srcFileName, const QString &destFileName);

    // Prepare an app working directory
    Q_INVOKABLE void prepareDataDir();

    // Save a binary file
	Q_INVOKABLE void saveBinary(const QString &fileName, const QByteArray &value);

	// Load a binary file
	Q_INVOKABLE QByteArray loadBinary(const QString &fileName);

    // Load a binary file
    Q_INVOKABLE bool checkFolder(const QString &fileName);

    // Load a binary file
    Q_INVOKABLE QVariantList listFiles(const QString &fileName);

    // Getters
	// Getters
	QString getHardwareInfo();
	QString getHardwareNumber();
	int getScreenWidth();
	int getScreenHeight();
	QString getVersion();
	QString getOsVersion();
    QString getPIN();

private:

    // Hardware info values
	QString hardwareInfo;
	QString hardwareNumber;
	QString version;
	int screenWidth;
	int screenHeight;
	QString osVersion;
	QString pin;

};


} } // NAMESPACE


#endif
