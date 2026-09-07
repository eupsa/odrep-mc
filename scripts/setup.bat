@echo off
REM Wrapper: chama o setup.ps1 (Paper via Fill API v3 + plugins do Modrinth).
cd /d "%~dp0.."
powershell -NoProfile -ExecutionPolicy Bypass -File "scripts\setup.ps1"
