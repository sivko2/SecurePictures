#ifndef CONFIG_HPP_
#define CONFIG_HPP_


#include <QtCore/QtCore>
#include <QString>
#include <QBool>
#include <QVariant>
#include <QSettings>


namespace pronic { namespace camera { // NAMESPACE


class Configurator : public QObject
{
	Q_OBJECT

public:

	// Constructor and destructor
	Configurator();
	~Configurator();

	// Configuration initialized property
	Q_PROPERTY(bool initialized READ getInitialized);

	// Password property
	Q_PROPERTY(QString password READ getPassword WRITE setPassword);

    // Forget password when app is minimized
    Q_PROPERTY(bool multiShots READ getMultiShots WRITE setMultiShots);

    // Forget password when you leave viewer
    Q_PROPERTY(bool forgetWhenMin READ getForgetWhenMin WRITE setForgetWhenMin);

    // Multi cam shot property
    Q_PROPERTY(bool forgetWhenExit READ getForgetWhenExit WRITE setForgetWhenExit);

	// Read config
	Q_INVOKABLE void read();

	// Write config
	Q_INVOKABLE void write();

	// Getters
	bool getInitialized();
	QString getPassword();
    bool getMultiShots();
    bool getForgetWhenMin();
    bool getForgetWhenExit();

	// Setters
	void setPassword(QString);
	void setMultiShots(bool);
    void setForgetWhenMin(bool);
    void setForgetWhenExit(bool);

private:

	// Password for encryption key
	QString password;

	// After a cam shot try another one
	bool multiShots;

	// Forget password when minimized
	bool forgetWhenMin;

    // Forget password when exiting viewer
    bool forgetWhenExit;

    // Is config initialized
    bool initialized;

	// Settings object
	QSettings settings;

};


} } // NAMESPACE


#endif
