@echo off
REM Tour India - File Checker
REM This script checks if all critical files exist

echo ========================================
echo    TOUR INDIA - FILE CHECK
echo ========================================
echo.

echo Checking critical files...
echo.

REM Check CSS
if exist "html\home.css" (
    echo [OK] html\home.css exists
) else (
    echo [MISSING] html\home.css NOT FOUND
)

REM Check Video
if exist "img\v1.mp4" (
    echo [OK] img\v1.mp4 exists
) else (
    echo [WARNING] img\v1.mp4 NOT FOUND - Hero section may not display video
)

REM Check jQuery
if exist "js\vendor\jquery-2.2.4.min.js" (
    echo [OK] js\vendor\jquery-22.4.min.js exists
) else (
    echo [ERROR] js\vendor\jquery-2.2.4.min.js NOT FOUND - JavaScript will fail
)

REM Check Main Scripts
if exist "js\main.js" (
    echo [OK] js\main.js exists
) else (
    echo [ERROR] js\main.js NOT FOUND
)

if exist "js\animated-slider-home.js" (
    echo [OK] js\animated-slider-home.js exists
) else (
    echo [WARNING] js\animated-slider-home.js NOT FOUND
)

echo.
echo ========================================
echo Check Complete!
echo.
echo To run your website:
echo 1. Double-click START_PROJECT.bat
echo 2. Or open html\home.html in your browser
echo ========================================
echo.
pause
