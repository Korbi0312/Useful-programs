@echo off
chcp 65001 >nul
title Installations-Skript (Silent)
echo Installiere Programme... Bitte warten.

:: Kurze Pause, damit die Meldung sichtbar ist (kann auf 0 gesetzt werden)
timeout /t 3 /nobreak >nul

echo [1/8] Installiere LocalSend...
winget install localsend --silent --accept-package-agreements

echo [2/8] Installiere Modrinth App...
winget install -e Modrinth.ModrinthApp --silent --accept-package-agreements

echo [3/8] Installiere Revo Uninstaller...
winget install -e RevoUninstaller.RevoUninstaller --silent --accept-package-agreements
if %errorlevel% neq 0 (
    echo Winget-Installation fehlgeschlagen, starte direkten Download...
    bitsadmin /transfer "RevoDownload" /download /priority high "https://download.revouninstaller.com/download/revosetup.exe" "%TEMP%\revosetup.exe" >nul
    if exist "%TEMP%\revosetup.exe" (
        start /wait "" "%TEMP%\revosetup.exe" /VERYSILENT /SUPPRESSMSGBOXES /NORESTART
        del "%TEMP%\revosetup.exe"
    ) else (
        echo Download fehlgeschlagen.
    )
)

echo [4/8] Installiere Epic Games Launcher...
winget install -e EpicGames.EpicGamesLauncher --silent --accept-package-agreements

echo [5/8] Installiere Steam...
winget install -e Valve.Steam --silent --accept-package-agreements

echo [6/8] Installiere Discord...
winget install -e Discord.Discord --silent --accept-package-agreements

echo [7/8] Installiere WinRAR...
winget install -e WinRAR.WinRAR --silent --accept-package-agreements

echo [8/8] Installiere Update.bat...
bitsadmin /transfer "UpdateDownload" /download /priority high "https://raw.githubusercontent.com/Korbi0312/Useful-programs/refs/heads/main/Update.bat" "%USERPROFILE%\Desktop\Update.bat" >nul

:: Kein automatischer Start der Update.bat mehr!

:: Eigene Batch-Datei l�schen
start /b "" cmd /c del "%~f0"
exit
