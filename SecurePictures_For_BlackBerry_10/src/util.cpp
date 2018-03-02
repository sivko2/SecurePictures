
#include "util.hpp"


namespace pronic { namespace camera { // NAMESPACE


Util::Util()
{
	HardwareInfo info;
	hardwareInfo = info.modelName();
	hardwareNumber = info.modelNumber();
	pin = info.pin();
	qDebug() << "HW: " << hardwareInfo << " " << hardwareNumber << " " << pin;

	bb::PackageInfo pkgInfo;
	version = pkgInfo.version();
	qDebug() << "VER: " << version;

    DisplayInfo display;
    screenWidth = display.pixelSize().width();
    screenHeight = display.pixelSize().height();
    qDebug() << "Screen: " << screenWidth << "x" << screenHeight;

    PlatformInfo platform;
    osVersion = platform.osVersion();
    qDebug() << "OS: " << osVersion;
}


Util::~Util()
{
}


QString Util::getTimeInMillis()
{
	QDateTime dateTime = QDateTime::currentDateTime();
	qint64 timeInMillis = dateTime.currentMSecsSinceEpoch();
	QString timeInMillisString = QString::number(timeInMillis);
	qDebug() << "Time in millis: " << timeInMillisString;
	return timeInMillisString;
}


QString Util::getHardwareInfo()
{
	return hardwareInfo;
}


QString Util::getVersion()
{
	return version;
}


QString Util::getOsVersion()
{
	return osVersion;
}


QString Util::getHardwareNumber()
{
	return hardwareNumber;
}


QString Util::getPIN()
{
	return pin;
}


int Util::getScreenWidth()
{
	return screenWidth;
}


int Util::getScreenHeight()
{
	return screenHeight;
}


QVariantList Util::listFiles(const QString &fileName)
{
    QVariantList list;

    QDir dirPath = QDir(fileName);
    qDebug() << "Files: " << fileName << " " << dirPath.entryList().length();
    QFileInfoList fileInfoList = dirPath.entryInfoList(QDir::NoDotAndDotDot | QDir::AllDirs | QDir::Files);
    qDebug() << "File list size: " << fileInfoList.length();

    QString temp = "";

    foreach (QFileInfo item, fileInfoList)
    {
        if (item.fileName() == temp)
        {
            continue;
        }

        if (item.isDir())
        {
            QVariantMap map;
            map["filename"] = item.fileName();
            map["type"] = "Folders";
            map["description"] = "";
            list.insert(0, map);
        }
        if (item.isFile())
        {
            if (item.fileName().endsWith(".sjpg"))
            {
                QFile file(item.absoluteFilePath());
                qDebug() << "File: " << item.fileName() << " " << file.size();
                QFileInfo info = QFileInfo(file);
                QDateTime dateTime = info.created();

                qint64 fileSize = file.size();
                QString sizeValue;
                if (fileSize < 2048)
                {
                    sizeValue = QString::number(fileSize) + " B";
                }
                else if (fileSize < 2097152)
                {
                    sizeValue = QString::number((fileSize / 1024)) + " KB";
                }
                else if (fileSize < 2147483648)
                {
                    sizeValue = QString::number((fileSize / 1048576)) + " MB";
                }
                else
                {
                    sizeValue = QString::number((fileSize / 1073741824)) + " GB";
                }

                QVariantMap map;
                map["filename"] = item.fileName();
                map["type"] = "Photos";
                map["description"] = dateTime.toString("yyyy MMM dd, HH:mm");
                map["status"] = sizeValue;
                list.insert(0, map);
            }
            else if (item.fileName().endsWith(".smp4"))
            {
                QFile file(item.absoluteFilePath());
                qDebug() << "File: " << item.fileName() << " " << file.size();
                QFileInfo info = QFileInfo(file);
                QDateTime dateTime = info.created();

                qint64 fileSize = file.size();
                QString sizeValue;
                if (fileSize < 2048)
                {
                    sizeValue = QString::number(fileSize) + " B";
                }
                else if (fileSize < 2097152)
                {
                    sizeValue = QString::number((fileSize / 1024)) + " KB";
                }
                else if (fileSize < 2147483648)
                {
                    sizeValue = QString::number((fileSize / 1048576)) + " MB";
                }
                else
                {
                    sizeValue = QString::number((fileSize / 1073741824)) + " GB";
                }

                QVariantMap map;
                map["filename"] = item.fileName();
                map["type"] = "Videos";
                map["description"] = dateTime.toString("yyyy MMM dd, HH:mm");
                map["status"] = sizeValue;
                list.insert(0, map);
            }
            else if (item.fileName().endsWith(".sm4a"))
            {
                QFile file(item.absoluteFilePath());
                qDebug() << "File: " << item.fileName() << " " << file.size();
                QFileInfo info = QFileInfo(file);
                QDateTime dateTime = info.created();

                qint64 fileSize = file.size();
                QString sizeValue;
                if (fileSize < 2048)
                {
                    sizeValue = QString::number(fileSize) + " B";
                }
                else if (fileSize < 2097152)
                {
                    sizeValue = QString::number((fileSize / 1024)) + " KB";
                }
                else if (fileSize < 2147483648)
                {
                    sizeValue = QString::number((fileSize / 1048576)) + " MB";
                }
                else
                {
                    sizeValue = QString::number((fileSize / 1073741824)) + " GB";
                }

                QVariantMap map;
                map["filename"] = item.fileName();
                map["type"] = "Voices";
                map["description"] = dateTime.toString("yyyy MMM dd, HH:mm");
                map["status"] = sizeValue;
                list.insert(0, map);
            }
        }

        temp = item.fileName();
    }

    return list;
}


void Util::saveBinary(const QString &fileName, const QByteArray &value)
{
	qDebug() << "SAVE BIN";
	QDir dirPath = QDir(fileName);
	QFile file(dirPath.absolutePath());
	qDebug() << "FILE EXISTS: " << file.exists();
	if (file.exists())
	{
		deleteFile(fileName);
	}
	file.open(QIODevice::WriteOnly);
	qDebug() << "Size: " << value.length() << " -> " << value.length();
	file.write(value);
	file.flush();
	file.close();
	qDebug() << "SAVED";
}


QByteArray Util::loadBinary(const QString &fileName)
{
	qDebug() << "LOAD bin";
	QDir dirPath = QDir(fileName);
	QFile file(dirPath.absolutePath());
	qDebug() << "FILE EXISTS: " << file.exists();
	if (!file.exists())
	{
		return "";
	}
	file.open(QIODevice::ReadOnly);
	qDebug() << "File opened - size: " << file.size();
	qint64 size = file.size();
	QByteArray fileData = file.readAll();
	qDebug() << "Data read - size: " << fileData.length();
	file.close();
	qDebug() << "LOADED";
	return fileData;
}


void Util::deleteFile(const QString &fileName)
{
	qDebug() << "DELETE";
	QDir dirPath = QDir(fileName);
	QFile file(dirPath.absolutePath());
	qDebug() << "FILE " << dirPath.absolutePath() << " EXISTS: " << file.exists();
	file.remove();
	qDebug() << "DELETED";
}


void Util::renameFile(const QString &srcFileName, const QString &destFileName)
{
    qDebug() << "RENAME";
    qDebug() << "FILE " << srcFileName << " TO " << destFileName;
    QFile::rename(srcFileName, destFileName);
    qDebug() << "RENAMED";
}


bool Util::checkFolder(const QString &fileName)
{
    qDebug() << "CHECK FOLDER " << (QDir::currentPath() + fileName);
    QDir dirPath = QDir(fileName);
    return dirPath.exists();
}


void Util::prepareDataDir()
{
    QDir dirPath = QDir("./data/");
//    dirPath.mkdir("securecamera");
//    dirPath = QDir("./shared/misc/securecamera/");
    dirPath.setFilter(QDir::Files);
    QStringList entries = dirPath.entryList();

    for (QStringList::ConstIterator entry = entries.begin(); entry != entries.end(); ++entry)
    {
        QString fileName = *entry;
        if (fileName.compare("mp4") != 0 || fileName.compare("jpg") != 0 || fileName.compare("m4a") != 0)
        {
            qDebug() << "File to delete: " << fileName;
            deleteFile("./data/" + fileName);
        }
    }

}


} } // NAMESPACE
