@echo off
start DriverInstall.exe

cd C:\EcoSaverUpdate\USB Driver\
CH341SER_3_5.exe


echo.  
echo Do NOT connect the EcoSaver
echo.  
echo Install the USB Driver first (DriverSetup):
echo.   

::echo 1. Press 'Uninstall'
::echo    (this will uninstall any old versions)
::echo.
::echo 2. Press 'Install' and wait...
::echo    (Note: Windows may also search the Internet
::echo     which creates a long time waiting for
::echo     the success message. You may stop the search...)
::echo.

echo Wait until the procedure is done.
echo    (Note: Windows may also search the Internet
echo     which creates a long time waiting for
echo     the success message. You may stop the search...)

::echo If you see 'Driver install success', hit 'OK'
::echo	and close the DriverSetup window
::echo.
::echo. Remark: It should not be needed to restart the pc.


Set /P done=Did you see 'Driver install success' (y/n) ? 
if "%done%" NEQ "Y" if "%done%" NEQ "y" GOTO ENDNOW

taskkill /IM DRVSetup64.exe

cls
echo.
echo. Connect the Helium EcoSaver via USB and switch on.
echo.
echo. Wait 10 seconds
echo.
Set /P done= Helium EcoSaver now connected (y/n) ? 
if "%done%" NEQ "Y" if "%done%" NEQ "y" GOTO ENDNOW



cls

echo.
echo Open the 'Devices and Printers' Control Panel of Windows 
echo.
echo Find the COM port number of the new device
echo.
echo   'USB-SERIAL CH340 (COM_X_)'
echo   where _X_ is the number
echo.
echo.

cd C:\EcoSaverUpdate\

Set /P cnumber=COM Port number please? 


cls
echo.
echo. Testing COM%cnumber% in new window...
echo.
echo. -------------------------------
echo.

	start plink.exe -serial COM%cnumber% -sercfg 9600,8,n,1,N

echo.--------------------
echo. Did you see 'Booting FW 2.2' ?
echo.

Set /P done= Update to Firmware 2.3 (y/n) ? 
if "%done%" NEQ "Y" if "%done%" NEQ "y" GOTO ENDNOW

taskkill /IM plink.exe 

cls
echo.
echo Updating, please wait 5 seconds

avrdude.exe -p m328p -carduino -P COM%cnumber% -b115200 -D -Uflash:w:"C:\EcoSaverUpdate\HeliumSaver_v2.3.ino.hex":i - v > "C:\EcoSaverUpdate\log.txt" 2>&1 

echo.
echo.
echo Restart EcoSaver. verify Firmware 2.3 in new COM window...
echo.

start plink.exe -serial COM%cnumber% -sercfg 9600,8,n,1,N

Timeout 3

cls
echo. Testing COM%cnumber%...echo. 
echo.
echo. Please verify the NEW Firmware version
echo.
echo. 'Booting FW 2.3'
echo.-------------------
echo.


:ENDNOW
	echo.
	echo Quit EcoSaver Update
	timeout 10
	taskkill /IM plink.exe 
	exit



