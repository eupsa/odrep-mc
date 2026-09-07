@echo off
REM Teste local no Windows. Uso: scripts\start.bat [heap_MB]
setlocal
cd /d "%~dp0.."
set HEAP=%1
if "%HEAP%"=="" set HEAP=3072

if not exist "run\paper.jar" ( echo Rode scripts\setup.bat primeiro. & exit /b 1 )
if not exist "run\eula.txt" ( echo Falta run\eula.txt  ^(echo eula=true^> run\eula.txt^) & exit /b 1 )

cd run
java -Xms%HEAP%M -Xmx%HEAP%M ^
 -XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 ^
 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch ^
 -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M ^
 -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 ^
 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 ^
 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 ^
 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 ^
 -Dusing.aikars.flags=https://mcflags.emc.gs -Daikars.new.flags=true ^
 -jar paper.jar --nogui
