
@echo off
cd /d "%~dp0"
python -m thor.cli scan --source stripe
pause
