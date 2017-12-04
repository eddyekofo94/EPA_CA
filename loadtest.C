/*
 * This is Linux ONLY code
 * Do not compile on windows
 * compile this file using the command
 * g++ -fopenmp loadtest.C -o loadtest
 * once compilation is successful run the test using
 * ./loadtest
 * Ctrl C to stop the test
 */

#include <iostream>
#include <fstream>
#include <cmath>
#include <unistd.h>
#include <omp.h>
#include <cstdlib>

using namespace std;

void sleep_ms(int milliseconds);

int main(int argc, char **argv)
{

    srand(time(NULL));

    ofstream fptr;

    if (argc != 2)
    {
        cout << "useage: loadtest N" << endl;
        cout << "where N is the number of concurrent users from 0-100" << endl;
        exit(1);
    }

    int nthreads = atoi(argv[1]);

    int tid;

    fptr.open("synthetic.dat", ios::trunc);

    omp_set_num_threads(nthreads);
    omp_lock_t writelock;
    omp_init_lock(&writelock);

#pragma omp parallel private(tid)
    {
        tid = omp_get_thread_num();
#pragma omp parallel for
        for (int t = 0; t < 10; t++)
        {
            for (;;)
            {
                for (int i = 0; i < 1000000; i++)
                {
                    double t = rand() % 8273 + 1;
                    double tt = sqrt(t);
                }

                time_t t = time(0);
                struct tm *now = localtime(&t);

                omp_set_lock(&writelock);

                fptr << (now->tm_year + 1900) << '-'
                     << (now->tm_mon + 1) << '-'
                     << now->tm_mday << '-'
                     << (now->tm_hour) << '-'
                     << (now->tm_min) << '-'
                     << (now->tm_sec)
                     << "    UserID [" << tid << "]"
                     << "    Transaction Complete " << endl;

                omp_unset_lock(&writelock);

                sleep_ms(100);
            }
        }
    }

    fptr.close();

    return 0;
}

void sleep_ms(int milliseconds)
{
    struct timespec ts;
    ts.tv_sec = milliseconds / 1000;
    ts.tv_nsec = (milliseconds % 1000) * 1000000;
    nanosleep(&ts, NULL);
    usleep(milliseconds * 1000);
}