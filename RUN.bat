@echo off
echo ========================================
echo   Project Thor - Quick Run
echo ========================================
echo.
echo Running compliance scan...
echo.
python -m thor.cli scan --source stripe
echo.
echo ========================================
echo Done! Press any key to exit...
pause >nul
