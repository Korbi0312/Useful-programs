[file name]: Wlan Passwort.bat
[file content begin]
@echo off
netsh wlan show profiles
set /p name="Gib den WLAN-Namen ein: "
netsh wlan show profile name="%name%" key=clear

echo.
echo Ihre IP-Adresse(n):
ipconfig | findstr IPv4

pause
[file content end]