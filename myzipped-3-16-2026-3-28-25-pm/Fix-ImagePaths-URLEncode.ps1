# Fix-ImagePaths-URLEncode.ps1
# Professional Fix Script - URL Encodes spaces in image paths
# Quick fix that works immediately without renaming files

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " IMAGE PATH FIX - URL ENCODING SCRIPT" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$projectPath = "c:\Users\love1\Desktop\tori progect\Pages-inside\South-India"
$files = Get-ChildItem "$projectPath\*.html"

Write-Host "Found $($files.Count) HTML files to process`n" -ForegroundColor Yellow

$filesFixed = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw
        
        # Count replacements
        $beforeCount = ([regex]::Matches($content, '../../South india image/')).Count
        
        # Replace spaces with %20 in image paths
        $content = $content -replace '../../South india image/', '../../South%20india%20image/'
        
        # Save the file
        Set-Content -Path $file.FullName -Value $content -NoNewline
        
        $filesFixed++
        Write-Host "✓ Fixed $beforeCount image paths in: $($file.Name)" -ForegroundColor Green
        
    }
    catch {
        Write-Host "✗ Error processing $($file.Name): $_" -ForegroundColor Red
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "COMPLETED: $filesFixed files updated" -ForegroundColor Green
Write-Host "All image paths now use URL encoding!" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Open any South India page in your browser" -ForegroundColor White
Write-Host "2. Verify images load correctly" -ForegroundColor White
Write-Host "3. Check browser console (F12) for errors" -ForegroundColor White
Write-Host ""

pause
