@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ============================================
echo   Project Thor - Fix and Run
echo ============================================
echo.

echo [1] Checking Python...
python --version 2>nul
if errorlevel 1 (
    echo ERROR: Python not found!
    echo Please install Python from: https://www.python.org/downloads/
    echo Make sure to check "Add Python to PATH"
    goto end
)
echo OK - Python found
echo.

echo [2] Checking required packages...
python -c "import pydantic" 2>nul
if errorlevel 1 (
    echo Installing pydantic...
    python -m pip install pydantic --user
)
echo OK - Packages ready
echo.

echo [3] Running scan...
echo.
python -m thor.cli scan --source stripe
if errorlevel 1 (
    echo.
    echo ERROR: Scan failed. See message above.
    echo Try: python -m pip install pydantic --user
)

:end
echo ============================================
echo Press any key to close...
pause >nul
