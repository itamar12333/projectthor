@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ============================================
echo   Project Thor - Generate Policy Templates
echo ============================================
echo.

python GENERATE_POLICIES.py

echo.
echo ============================================
echo Press any key to close...
pause >nul
