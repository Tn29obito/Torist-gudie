@echo off
echo ==========================================
echo      TOUR INDIA - WEB DEPLOYMENT
echo ==========================================
echo.
echo This script will deploy your website to Firebase Hosting.
echo Project: tourist-guide-1e156
echo.
echo checks if you are logged in...
call npx -y firebase-toolslogin --interactive
if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Please log in to your Google Account in the browser window that opens.
    call npx -y firebase-tools login
)

echo.
echo Ready to deploy!
echo.
pause

echo.
echo Deploying to Firebase Hosting...
call npx -y firebase-tools deploy --only hosting
echo.

if %ERRORLEVEL% EQU 0 (
    echo ==========================================
    echo      DEPLOYMENT SUCCESSFUL!  
    echo ==========================================
    echo.
    echo Your website is now live at:
    echo https://tourist-guide-1e156.web.app
    echo.
    start https://tourist-guide-1e156.web.app
) else (
    echo.
    echo Deployment failed. Please check the errors above.
)
pause
