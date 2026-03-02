@echo off
chcp 65001 >nul 2>&1
cd /d "%~dp0"

echo ========================================
echo   Project Thor - פתיחת דשבורד
echo ========================================
echo.

echo בודק חבילות נדרשות...
python -c "import flask, httpx, openai" >nul 2>&1
if errorlevel 1 (
    echo מתקין flask, httpx, openai...
    python -m pip install flask httpx openai --user
)
python -c "import openai" >nul 2>&1
if errorlevel 1 (
    echo שגיאה: חבילת openai לא מותקנת.
    echo הרץ ב-PowerShell: python -m pip install openai --user
    pause
    exit /b 1
)
echo OK

echo מפעיל שרת...
echo.
echo ========================================
echo   השרת רץ על: http://localhost:5000
echo   הדפדפן יפתח אוטומטית...
echo ========================================
echo.
echo לחץ Ctrl+C כדי לעצור את השרת
echo.

timeout /t 3 /nobreak >nul
start http://localhost:5000

python -m thor.web.run

pause
