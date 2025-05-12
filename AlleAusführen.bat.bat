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

:: Automatisch nach 10 Sekunden schließen
echo Fertig! Alle Dateien wurden gestartet.
echo Das Fenster schlie§t sich in 10 Sekunden...
timeout /t 10 /nobreak >nul
exit