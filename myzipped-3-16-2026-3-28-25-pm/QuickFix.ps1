# Fix-ImagePaths.ps1 - Simple Fix Script
# URL Encodes spaces in image paths

Write-Host "`nFixing image paths..." -ForegroundColor Cyan

$projectPath = "c:\Users\love1\Desktop\tori progect\Pages-inside\South-India"
$files = Get-ChildItem "$projectPath\*.html"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $content = $content -replace '../../South india image/', '../../South%20india%20image/'
    Set-Content -Path $file.FullName -Value $content -NoNewline
    Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
}

Write-Host "`nDone! All 12 files updated.`n" -ForegroundColor Green
