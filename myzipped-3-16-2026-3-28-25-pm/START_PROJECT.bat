@echo off
REM Tour India Project Launcher
REM Simple script to run your website

echo ========================================
echo    Tour India Project Launcher
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% == 0 (
    echo [OK] Python is installed
    echo.
    echo Starting local server on port 8000...
    echo.
    echo Your website will be available at:
    echo.
    echo   Homepage:        http://localhost:8000/html/home.html
    echo   Destinations:    http://localhost:8000/html/destination.html
    echo   Login:           http://localhost:8000/html/login.html
    echo   Database Test:   http://localhost:8000/database/test-connection.html
    echo.
    echo Press Ctrl+C to stop the server
    echo.
    echo ========================================
    echo.
    
    REM Wait 2 seconds then open browser
    timeout /t 2 /nobreak >nul
    start http://localhost:8000/html/home.html
    
    REM Start Python server
    python -m http.server 8000
) else (
    echo [ERROR] Python is not installed or not in PATH
    echo.
    echo Opening homepage directly in browser...
    echo (Note: Some features may not work without a server)
    echo.
    start html\home.html
    echo.
    echo For better experience, install Python and run this script again.
    echo Download Python from: https://www.python.org/downloads/
    echo.
    pause
)
