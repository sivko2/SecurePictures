#ifndef CAMERATHREAD_HPP_
#define CAMERATHREAD_HPP_


#include <QThread>


namespace pronic { namespace camera { // NAMESPACE


class CameraThread : public QThread
{
	public:

        // Sleep methods
		static void sleep(unsigned long secs);
		static void msleep(unsigned long msecs);
		static void usleep(unsigned long usecs);

};


} } // NAMESPACE


#endif
