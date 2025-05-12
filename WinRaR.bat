@echo off
:: Automatisch als Administrator ausführen
NET FILE >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    PowerShell -Command "Start-Process -Verb RunAs -FilePath '%~dpnx0'"
    EXIT
)

:: Prüfen, ob WinRAR installiert ist
where winrar >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo WinRAR ist bereits installiert!
    echo Pfad: %ProgramFiles%\WinRAR
    exit
)

:: Download-Pfade
set "DOWNLOAD_DIR=%USERPROFILE%\Downloads"
set "WINRAR_URL=https://www.win-rar.com/fileadmin/winrar-versions/winrar/winrar-x64-624.exe"
set "INSTALLER=%DOWNLOAD_DIR%\winrar_installer.exe"

:: Installer herunterladen
echo Lade WinRAR-Installer nach Downloads...
bitsadmin /transfer downloadJob /download /priority normal "%WINRAR_URL%" "%INSTALLER%"

if not exist "%INSTALLER%" (
    echo Download fehlgeschlagen! Bitte Internetverbindung prüfen.
    timeout /t 3 >nul
    exit /b 1
)

:: Installation starten (silent)
echo Installiere WinRAR...
start /wait "" "%INSTALLER%" /S

:: Erfolgsprüfung und automatisches Schließen
if exist "%ProgramFiles%\WinRAR\WinRAR.exe" (
    echo WinRAR wurde erfolgreich installiert!
    echo Die Installationsdatei liegt in: %DOWNLOAD_DIR%
) else (
    echo Installation fehlgeschlagen!
    timeout /t 3 >nul
)

:: Installationsdatei löschen (optional)
del "%INSTALLER%"

exit