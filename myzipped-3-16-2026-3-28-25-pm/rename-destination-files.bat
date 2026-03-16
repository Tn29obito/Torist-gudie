@echo off
REM ============================================================
REM Tourism Website File Renaming Script (Batch Version)
REM ============================================================
REM Description: Renames index.html, style.css, and script.js 
REM              files in each destination folder to match the 
REM              folder name
REM
REM Usage: Double-click this file OR run from Command Prompt
REM
REM Author: Tour India Project
REM Date: 2026-01-17
REM ============================================================

echo ============================================
echo   Tourism Website File Renaming Script
echo ============================================
echo.

REM Get the directory where this script is located
set "PROJECT_ROOT=%~dp0"
echo Project Root: %PROJECT_ROOT%
echo.

REM Initialize counters
set /a SUCCESS_COUNT=0
set /a ERROR_COUNT=0
set /a SKIP_COUNT=0

REM Process each destination folder
call :ProcessFolder "Alleppey"
call :ProcessFolder "Munnar"
call :ProcessFolder "Kochi"
call :ProcessFolder "Chennai"
call :ProcessFolder "Ooty"
call :ProcessFolder "Kodaikanal"
call :ProcessFolder "Hampi"
call :ProcessFolder "Bengaluru"
call :ProcessFolder "Coorg"
call :ProcessFolder "Hyderabad"
call :ProcessFolder "Tirupati"
call :ProcessFolder "Puducherry"

REM Display summary
echo.
echo ============================================
echo   SUMMARY
echo ============================================
echo   Files renamed successfully: %SUCCESS_COUNT%
echo   Errors encountered:         %ERROR_COUNT%
echo   Folders skipped:            %SKIP_COUNT%
echo ============================================
echo.

pause
exit /b 0

REM ============================================================
REM Function: ProcessFolder
REM Description: Renames files in a single destination folder
REM Parameter: %1 = Folder name
REM ============================================================
:ProcessFolder
set "FOLDER_NAME=%~1"
set "FOLDER_PATH=%PROJECT_ROOT%%FOLDER_NAME%"

echo Processing: %FOLDER_NAME%

REM Check if folder exists
if not exist "%FOLDER_PATH%" (
    echo   [SKIP] Folder not found
    set /a SKIP_COUNT+=1
    echo.
    goto :eof
)

REM Rename index.html
if exist "%FOLDER_PATH%\index.html" (
    if exist "%FOLDER_PATH%\%FOLDER_NAME%.html" (
        echo   [SKIP] %FOLDER_NAME%.html already exists
    ) else (
        ren "%FOLDER_PATH%\index.html" "%FOLDER_NAME%.html"
        if errorlevel 1 (
            echo   [ERROR] Failed to rename index.html
            set /a ERROR_COUNT+=1
        ) else (
            echo   [OK] index.html -^> %FOLDER_NAME%.html
            set /a SUCCESS_COUNT+=1
        )
    )
) else (
    echo   [SKIP] index.html not found
)

REM Rename style.css
if exist "%FOLDER_PATH%\style.css" (
    if exist "%FOLDER_PATH%\%FOLDER_NAME%.css" (
        echo   [SKIP] %FOLDER_NAME%.css already exists
    ) else (
        ren "%FOLDER_PATH%\style.css" "%FOLDER_NAME%.css"
        if errorlevel 1 (
            echo   [ERROR] Failed to rename style.css
            set /a ERROR_COUNT+=1
        ) else (
            echo   [OK] style.css -^> %FOLDER_NAME%.css
            set /a SUCCESS_COUNT+=1
        )
    )
) else (
    echo   [SKIP] style.css not found
)

REM Rename script.js
if exist "%FOLDER_PATH%\script.js" (
    if exist "%FOLDER_PATH%\%FOLDER_NAME%.js" (
        echo   [SKIP] %FOLDER_NAME%.js already exists
    ) else (
        ren "%FOLDER_PATH%\script.js" "%FOLDER_NAME%.js"
        if errorlevel 1 (
            echo   [ERROR] Failed to rename script.js
            set /a ERROR_COUNT+=1
        ) else (
            echo   [OK] script.js -^> %FOLDER_NAME%.js
            set /a SUCCESS_COUNT+=1
        )
    )
) else (
    echo   [SKIP] script.js not found
)

echo.
goto :eof
