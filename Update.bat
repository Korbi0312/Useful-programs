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

:: Automatisch "Y" auswählen (ohne Eingabe)
echo Y | choice /c Y /n >nul

:: Upgrade aller Pakete
winget upgrade --all

:: Fenster offen halten
pause