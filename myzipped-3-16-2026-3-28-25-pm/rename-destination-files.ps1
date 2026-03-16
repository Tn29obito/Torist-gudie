# ============================================================
# Tourism Website File Renaming Script
# ============================================================
# Description: Renames index.html, style.css, and script.js 
#              files in each destination folder to match the 
#              folder name (e.g., Alleppey/index.html -> Alleppey/Alleppey.html)
#
# Usage: Run this script from the project root directory
#        Right-click -> "Run with PowerShell" OR
#        Open PowerShell and run: .\rename-destination-files.ps1
#
# Author: Tour India Project
# Date: 2026-01-17
# ============================================================

# List of destination folders to process
$destinationFolders = @(
    "Alleppey",
    "Munnar", 
    "Kochi",
    "Chennai",
    "Ooty",
    "Kodaikanal",
    "Hampi",
    "Bengaluru",
    "Coorg",
    "Hyderabad",
    "Tirupati",
    "Puducherry"
)

# Get the script's directory (project root)
$projectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path

# If script is run directly, use current directory
if (-not $projectRoot) {
    $projectRoot = Get-Location
}

Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Tourism Website File Renaming Script" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Project Root: $projectRoot" -ForegroundColor Yellow
Write-Host ""

# Counter for tracking progress
$successCount = 0
$errorCount = 0
$skippedCount = 0

# Process each destination folder
foreach ($folder in $destinationFolders) {
    
    # Construct full path to the destination folder
    $folderPath = Join-Path -Path $projectRoot -ChildPath $folder
    
    Write-Host "Processing: $folder" -ForegroundColor White
    
    # Check if folder exists
    if (-not (Test-Path $folderPath -PathType Container)) {
        Write-Host "  [SKIP] Folder not found: $folderPath" -ForegroundColor DarkYellow
        $skippedCount++
        continue
    }
    
    # --------------------------------------------------------
    # Rename index.html -> <folder-name>.html
    # --------------------------------------------------------
    $oldHtmlPath = Join-Path -Path $folderPath -ChildPath "index.html"
    $newHtmlPath = Join-Path -Path $folderPath -ChildPath "$folder.html"
    
    if (Test-Path $oldHtmlPath) {
        # Check if target already exists
        if (Test-Path $newHtmlPath) {
            Write-Host "  [SKIP] $folder.html already exists" -ForegroundColor DarkYellow
        } else {
            try {
                Rename-Item -Path $oldHtmlPath -NewName "$folder.html" -ErrorAction Stop
                Write-Host "  [OK] index.html -> $folder.html" -ForegroundColor Green
                $successCount++
            } catch {
                Write-Host "  [ERROR] Failed to rename index.html: $_" -ForegroundColor Red
                $errorCount++
            }
        }
    } else {
        Write-Host "  [SKIP] index.html not found" -ForegroundColor DarkGray
    }
    
    # --------------------------------------------------------
    # Rename style.css -> <folder-name>.css
    # --------------------------------------------------------
    $oldCssPath = Join-Path -Path $folderPath -ChildPath "style.css"
    $newCssPath = Join-Path -Path $folderPath -ChildPath "$folder.css"
    
    if (Test-Path $oldCssPath) {
        # Check if target already exists
        if (Test-Path $newCssPath) {
            Write-Host "  [SKIP] $folder.css already exists" -ForegroundColor DarkYellow
        } else {
            try {
                Rename-Item -Path $oldCssPath -NewName "$folder.css" -ErrorAction Stop
                Write-Host "  [OK] style.css -> $folder.css" -ForegroundColor Green
                $successCount++
            } catch {
                Write-Host "  [ERROR] Failed to rename style.css: $_" -ForegroundColor Red
                $errorCount++
            }
        }
    } else {
        Write-Host "  [SKIP] style.css not found" -ForegroundColor DarkGray
    }
    
    # --------------------------------------------------------
    # Rename script.js -> <folder-name>.js
    # --------------------------------------------------------
    $oldJsPath = Join-Path -Path $folderPath -ChildPath "script.js"
    $newJsPath = Join-Path -Path $folderPath -ChildPath "$folder.js"
    
    if (Test-Path $oldJsPath) {
        # Check if target already exists
        if (Test-Path $newJsPath) {
            Write-Host "  [SKIP] $folder.js already exists" -ForegroundColor DarkYellow
        } else {
            try {
                Rename-Item -Path $oldJsPath -NewName "$folder.js" -ErrorAction Stop
                Write-Host "  [OK] script.js -> $folder.js" -ForegroundColor Green
                $successCount++
            } catch {
                Write-Host "  [ERROR] Failed to rename script.js: $_" -ForegroundColor Red
                $errorCount++
            }
        }
    } else {
        Write-Host "  [SKIP] script.js not found" -ForegroundColor DarkGray
    }
    
    Write-Host ""
}

# --------------------------------------------------------
# Summary Report
# --------------------------------------------------------
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  SUMMARY" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host "  Files renamed successfully: $successCount" -ForegroundColor Green
Write-Host "  Errors encountered:         $errorCount" -ForegroundColor Red
Write-Host "  Folders skipped:            $skippedCount" -ForegroundColor Yellow
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Pause to allow user to review output
Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
