@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ========================================
echo   Project Thor - Web Dashboard
echo ========================================
echo.

echo [1] Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    echo Please install Python first.
    pause
    exit /b 1
)
echo OK
echo.

echo [2] Checking Flask...
python -c "import flask" >nul 2>&1
if errorlevel 1 (
    echo Flask not found!
    echo.
    echo Please run INSTALL_FLASK.bat first to install Flask.
    echo Or run in PowerShell: python -m pip install flask --user
    echo.
    pause
    exit /b 1
)
python -c "import flask; print(f'Flask {flask.__version__} found')"
echo.

echo [3] Starting web server...
echo.
echo ========================================
echo   Server starting...
echo   Open your browser to: http://localhost:5000
echo ========================================
echo.
echo Press Ctrl+C to stop the server
echo.

timeout /t 2 /nobreak >nul
start http://localhost:5000

python -m thor.web.run
pause
