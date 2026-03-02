@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ========================================
echo   Installing Flask for Web Dashboard
echo ========================================
echo.

echo Checking if Flask is installed...
python -c "import flask" >nul 2>&1
if not errorlevel 1 (
    echo Flask is already installed!
    python -c "import flask; print(f'Flask version: {flask.__version__}')"
    echo.
    echo You can now run START_DASHBOARD.bat
    pause
    exit /b 0
)

echo Flask not found. Installing...
echo.

echo Method 1: Installing with --user flag...
python -m pip install flask --user
if not errorlevel 1 (
    echo.
    echo SUCCESS! Flask installed successfully.
    echo You can now run START_DASHBOARD.bat
    pause
    exit /b 0
)

echo.
echo Method 1 failed. Trying Method 2...
echo Installing without --user flag...
python -m pip install flask
if not errorlevel 1 (
    echo.
    echo SUCCESS! Flask installed successfully.
    echo You can now run START_DASHBOARD.bat
    pause
    exit /b 0
)

echo.
echo ========================================
echo   Installation Failed
echo ========================================
echo.
echo Please try one of these:
echo.
echo Option 1: Open PowerShell as Administrator
echo   Right-click PowerShell -^> Run as Administrator
echo   Then run: python -m pip install flask
echo.
echo Option 2: Try with py command
echo   py -m pip install flask --user
echo.
echo Option 3: Use CLI instead (no Flask needed)
echo   Run: FIX_AND_RUN.bat
echo.
pause
