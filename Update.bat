@echo off
:: Automatisch als Administrator ausführen
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    PowerShell -Command "Start-Process -Verb RunAs -FilePath '%~dpnx0'"
    EXIT
)

:: Schriftfarbe auf Grün setzen
color 0a

:: Winget-Befehle ausführen
winget list
winget upgrade --all

:: Automatisch nach 10 Sekunden schließen
echo Das Fenster schlie§t sich in 10 Sekunden...
timeout /t 10 /nobreak >nul
exit