@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ========================================
echo   Testing Dashboard Setup
echo ========================================
echo.

echo [1] Testing Python...
python --version
if errorlevel 1 (
    echo ERROR: Python not found!
    pause
    exit /b 1
)
echo.

echo [2] Testing Flask...
python -c "import flask; print(f'Flask version: {flask.__version__}')"
if errorlevel 1 (
    echo Flask not installed!
    echo Run: python -m pip install flask --user
    pause
    exit /b 1
)
echo.

echo [3] Testing imports...
python -c "from thor.web.app import app; print('All imports OK!')"
if errorlevel 1 (
    echo ERROR: Import failed!
    echo Check the error message above.
    pause
    exit /b 1
)
echo.

echo ========================================
echo   All tests passed!
echo   You can now run START_DASHBOARD.bat
echo ========================================
pause
