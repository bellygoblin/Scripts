@echo off
echo Checking your system info, Please waiting...
systeminfo | findstr /c:"Host Name" >> c:\scratch\pc1\sys.txt
systeminfo | findstr /c:"Domain" >> c:\scratch\pc1\sys.txt
systeminfo | findstr /c:"OS Name" >> c:\scratch\pc1\sys.txt
systeminfo | findstr /c:"OS Version" >> c:\scratch\pc1\sys.txt
systeminfo | findstr /c:"System Manufacturer" >> c:\scratch\pc1\sys.txt
systeminfo | findstr /c:"System Model" >> c:\scratch\pc1\sys.txt
systeminfo | findstr /c:"System type" >> c:\scratch\pc1\sys.txt
systeminfo | findstr /c:"Total Physical Memory" >> c:\scratch\pc1\sys.txt
ipconfig | findstr IPv4 >> c:\scratch\pc1\sys.txt
echo.
echo Hard Drive Space:
wmic diskdrive get size >> c:\scratch\pc1\sys.txt
echo.
echo.
echo Service Tag:
wmic bios get serialnumber >> c:\scratch\pc1\sys.txt
echo.
echo.
echo CPU:
wmic cpu get name >> c:\scratch\pc1\sys.txt
