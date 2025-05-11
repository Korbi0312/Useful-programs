@echo off
setlocal enabledelayedexpansion

:: Aktueller Ordner
set "ORDNER=%~dp0"

:: Liste aller Dateien im Ordner (außer dieser Batch-Datei)
for %%F in ("%ORDNER%*.*") do (
    if not "%%~nxF"=="%~nx0" (
        echo Starte "%%~nxF"...
        start "" "%%F"
    )
)

echo Fertig! Alle Dateien wurden gestartet.
pause