@echo off
:: Automatisch als Administrator ausführen
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    PowerShell -Command "Start-Process -Verb RunAs -FilePath '%~dpnx0'"
    EXIT
)

:: Phase 0: Skript in Autostart kopieren (nur einmalig)
set "AUTOSTART_DIR=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
if not exist "%AUTOSTART_DIR%\Update.bat" (
    copy "%~dpnx0" "%AUTOSTART_DIR%\" >nul
    echo [Info] Skript wurde dem Autostart hinzugefügt.
)

:: Schriftfarbe auf Grün setzen
color 0a
cls

:: Phase 1: Firefox installieren/updaten
echo [1/2] Installiere/Update Firefox...
setlocal enabledelayedexpansion
set "FF_URL=https://download.mozilla.org/?product=firefox-latest-ssl&os=win64&lang=de"
set "INSTALLER=%TEMP%\Firefox_Installer.exe"

:: Download mit PowerShell (TLS 1.2 erzwingen)
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '!FF_URL!' -OutFile '!INSTALLER!'"

if not exist "!INSTALLER!" (
    echo FEHLER: Firefox-Download fehlgeschlagen!
    timeout /t 5
    exit /b 1
)

:: Silent-Installation + Aufräumen
start /wait "" "!INSTALLER!" -ms
del "!INSTALLER!" >nul 2>&1

:: Phase 2: Alle Pakete mit Winget updaten
endlocal
echo [2/2] Führe System-Updates durch...
winget upgrade --all --accept-package-agreements --accept-source-agreements --silent

:: Erfolgsmeldung
echo.
echo =========================================
echo Firefox-Update & System-Updates abgeschlossen!
echo Das Fenster schlie§t sich in 5 Sekunden...
timeout /t 5 /nobreak >nul
exit