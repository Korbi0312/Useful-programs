@echo off
:: Automatisch als Administrator ausführen
NET FILE >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    PowerShell -Command "Start-Process -Verb RunAs -FilePath '%~dpnx0'"
    EXIT
)

:: Prüfen, ob Python installiert ist
where python >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Python ist bereits installiert!
    python --version
    pause
    exit
)

:: Download-Pfad: Downloads-Ordner des Benutzers
set "DOWNLOAD_DIR=%USERPROFILE%\Downloads"
set "PYTHON_URL=https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
set "INSTALLER=%DOWNLOAD_DIR%\python_installer.exe"

:: Installer herunterladen
echo Lade Python-Installer nach Downloads...
bitsadmin /transfer downloadJob /download /priority normal "%PYTHON_URL%" "%INSTALLER%"

if not exist "%INSTALLER%" (
    echo Download fehlgeschlagen! Bitte Internetverbindung pr³fen.
    pause
    exit /b 1
)

:: Installation starten (ohne Datei zu löschen)
echo Installiere Python aus dem Downloads-Ordner...
start /wait "" "%INSTALLER%" /quiet InstallAllUsers=1 PrependPath=1

:: Erfolgspr³fung
where python >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Python wurde erfolgreich installiert!
    echo Die Installationsdatei liegt in: %DOWNLOAD_DIR%
    python --version
) else (
    echo Installation fehlgeschlagen!
)

pause