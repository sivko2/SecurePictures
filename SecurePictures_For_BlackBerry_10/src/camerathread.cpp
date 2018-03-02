
#include "camerathread.hpp"


namespace pronic { namespace camera { // NAMESPACE


void CameraThread::sleep(unsigned long secs)
{
	QThread::sleep(secs);
}


void CameraThread::msleep(unsigned long msecs)
{
	QThread::msleep(msecs);
}


void CameraThread::usleep(unsigned long usecs)
{
	QThread::usleep(usecs);
}


} } // NAMESPACE
