@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ========================================
echo   Project Thor - Web Dashboard
echo   (Auto-install version)
echo ========================================
echo.

echo [1] Checking Python...
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    pause
    exit /b 1
)
echo OK
echo.

echo [2] Checking Flask...
python -c "import flask" >nul 2>&1
if errorlevel 1 (
    echo Flask not found. Installing now...
    echo.
    python -m pip install flask --user
    if errorlevel 1 (
        echo.
        echo Installation failed. Trying alternative method...
        python -m pip install flask
        if errorlevel 1 (
            echo.
            echo ========================================
            echo   ERROR: Could not install Flask
            echo ========================================
            echo.
            echo Please run INSTALL_FLASK.bat manually
            echo Or open PowerShell as Administrator and run:
            echo   python -m pip install flask
            echo.
            pause
            exit /b 1
        )
    )
    echo.
    echo Flask installed successfully!
    echo.
) else (
    python -c "import flask; print(f'Flask {flask.__version__} found')"
)
echo.

echo [3] Testing imports...
python -c "from thor.web.app import app" >nul 2>&1
if errorlevel 1 (
    echo ERROR: Cannot import web app!
    echo Check the error above.
    pause
    exit /b 1
)
echo OK
echo.

echo [4] Starting web server...
echo.
echo ========================================
echo   Server is starting...
echo   Opening browser in 3 seconds...
echo   URL: http://localhost:5000
echo ========================================
echo.
echo Press Ctrl+C to stop the server
echo.

timeout /t 3 /nobreak >nul
start http://localhost:5000

python -m thor.web.run

pause
