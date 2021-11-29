#include <iostream>
#include <ctime>
#include <windows.h>

using namespace std;

const int maxPeople = 3;

int main()
{
    // Open serial port
    HANDLE serialHandle;

    serialHandle = CreateFileA("\\\\.\\COM11", GENERIC_READ, 0, NULL, OPEN_EXISTING, 0, NULL);
    	cout << " put port to COM11\n" ;
    	cout <<"Press Enter to Continue";
    	while( getchar() != '\n' );

    if (serialHandle == INVALID_HANDLE_VALUE)   //Check Connection
        cout << "Error in opening serial port\n";
    else
        cout << "opening serial port successful\n";

    //  settings
    DCB serialParams = { 0 };
    serialParams.DCBlength = sizeof(serialParams);

    GetCommState(serialHandle, &serialParams);
    serialParams.BaudRate = 9600;
    serialParams.ByteSize = 8;
    serialParams.StopBits = ONESTOPBIT;
    serialParams.Parity = NOPARITY;
    SetCommState(serialHandle, &serialParams);

    // Set timeouts
    COMMTIMEOUTS timeout = { 0 };
    timeout.ReadIntervalTimeout = 50;
    timeout.ReadTotalTimeoutConstant = 50;
    timeout.ReadTotalTimeoutMultiplier = 50;
    timeout.WriteTotalTimeoutConstant = 50;
    timeout.WriteTotalTimeoutMultiplier = 10;

    SetCommTimeouts(serialHandle, &timeout);

    // Receiving Data
    byte Number = 0; //Temporary character used for reading
    DWORD NoBytesRead;
    byte OLD = Number;

    while (true) {
        ReadFile(serialHandle,           //Handle of the Serial port
            &Number,       //Temporary character
            sizeof(Number),//Size of Number
            &NoBytesRead,    //Number of bytes read
            NULL);

        if (Number != OLD) {  //Compare Current Value with Old one
            cout << time(0) << " " << (int)Number << "\n";
            if(OLD > Number)
                cout << "person LEFT\n";
            else if(OLD < Number)
                cout << "person ENTERED\n";
            if(Number >= maxPeople)
                cout << "Max. number of People is reached\n";
        }
        OLD = Number;     //Save current number
    }

    CloseHandle(serialHandle);//Closing the Serial Port

    return EXIT_SUCCESS;
}
