@echo off
cd /d "%~dp0"

if not exist "venv\Scripts\activate.bat" (
    echo Creating virtual environment...
    python -m venv venv
    if errorlevel 1 (
        echo ERROR: Failed to create venv
        pause
        exit /b 1
    )
)

echo Activating venv...
call venv\Scripts\activate.bat

echo.
echo Virtual environment activated!
echo You can now run: python -m thor.cli scan --source stripe
echo Or: python -m thor.web.run
echo.
cmd /k
