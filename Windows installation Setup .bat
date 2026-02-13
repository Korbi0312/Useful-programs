@echo off
chcp 65001 >nul
title Installations-Skript
cls
echo Das Skript installiert jetzt folgende Programme:
echo LocalSend, Modrinth, Revo, Epic, Steam, Discord, WinRAR
echo.
echo WICHTIG: Bitte schliesse keine Fenster und druecke
echo keine Tasten waehrend der Installation!
echo.
echo Die Installation startet in 15 Sekunden automatisch...
ping 127.0.0.1 -n 16 >nul

cls
echo.
echo === Starte Installationen ===
echo.

echo [1/7] Installiere LocalSend...
winget install localsend

echo [2/7] Installiere Modrinth App...
winget install -e Modrinth.ModrinthApp

echo [3/7] Installiere Revo Uninstaller...
winget install -e RevoUninstaller.RevoUninstaller

echo [4/7] Installiere Epic Games Launcher...
winget install -e EpicGames.EpicGamesLauncher

echo [5/7] Installiere Steam...
winget install -e Valve.Steam

echo [6/7] Installiere Discord...
winget install -e Discord.Discord

echo [7/7] Installiere WinRAR...
winget install -e WinRAR.WinRAR

echo.
echo === Alle Vorgaenge abgeschlossen! ===
echo Druecke eine beliebige Taste, um dieses Fenster zu schliessen
echo und die Installationsdatei automatisch zu loeschen.
pause >nul

:: Eigene Batch-Datei loeschen
start /b "" cmd /c del "%~f0"
exit