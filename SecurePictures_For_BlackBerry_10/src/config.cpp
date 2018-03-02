
#include "config.hpp"


namespace pronic { namespace camera { // NAMESPACE


Configurator::Configurator()
{
    // Read on initialization of config
	read();
}


Configurator::~Configurator()
{
}


void Configurator::read()
{
	qDebug() << "Password null?: " << settings.value("password").isNull();
	if (!settings.value("password").isNull())
	{
		password = settings.value("password").toString();
		initialized = true;
		qDebug() << "##### Password read: " << settings.value("password").toString() << "/" << password;
	}
	else
	{
		initialized = false;
	}

    qDebug() << "Multi shots null?: " << settings.value("multiShots").isNull();
    if (!settings.value("multiShots").isNull())
    {
        multiShots = settings.value("multiShots").toBool();
        qDebug() << "##### Multi shots read: " << settings.value("multiShots").toBool();
    }
    else
    {
        multiShots = false;
    }

    qDebug() << "Forget when min null?: " << settings.value("forgetWhenMin").isNull();
    if (!settings.value("forgetWhenMin").isNull())
    {
        forgetWhenMin = settings.value("forgetWhenMin").toBool();
        qDebug() << "##### Forget when min read: " << settings.value("forgetWhenMin").toBool();
    }
    else
    {
        multiShots = false;
    }

    qDebug() << "Forget when exit null?: " << settings.value("forgetWhenExit").isNull();
    if (!settings.value("forgetWhenExit").isNull())
    {
        forgetWhenExit = settings.value("forgetWhenExit").toBool();
        qDebug() << "##### Forget when exit read: " << settings.value("forgetWhenExit").toBool();
    }
    else
    {
        multiShots = false;
    }

}


void Configurator::write()
{
	settings.setValue("password", password);
    settings.setValue("multiShots", multiShots);
    settings.setValue("forgetWhenMin", forgetWhenMin);
    settings.setValue("forgetWhenExit", forgetWhenExit);
	initialized = true;
	qDebug() << "Settings saved";
}


bool Configurator::getInitialized()
{
	return initialized;
}


QString Configurator::getPassword()
{
	return password;
}


void Configurator::setPassword(QString _password)
{
	password = _password;
	settings.setValue("password", password);
	write();
}


bool Configurator::getMultiShots()
{
    return multiShots;
}


void Configurator::setMultiShots(bool _multiShots)
{
    multiShots = _multiShots;
    settings.setValue("multiShots", multiShots);
    write();
}


bool Configurator::getForgetWhenMin()
{
    return forgetWhenMin;
}


void Configurator::setForgetWhenMin(bool _forgetWhenMin)
{
    forgetWhenMin = _forgetWhenMin;
    settings.setValue("forgetWhenMin", forgetWhenMin);
    write();
}


bool Configurator::getForgetWhenExit()
{
    return forgetWhenExit;
}


void Configurator::setForgetWhenExit(bool _forgetWhenExit)
{
    forgetWhenExit = _forgetWhenExit;
    settings.setValue("forgetWhenExit", forgetWhenExit);
    write();
}


} } // NAMESPACE
