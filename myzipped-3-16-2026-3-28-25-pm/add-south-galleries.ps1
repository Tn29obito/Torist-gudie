# Add Image Galleries to all South India Destination Pages
# This script adds photo gallery sections to each destination HTML file

$destinations = @(
    @{Name="Bengaluru"; Images=@("Bengaluru 1.jpg", "Bengaluru 2.jpg", "Bengaluru 3.jpg")},
    @{Name="Chennai"; Images=@("Chennai 1.jpg", "Chennai 2.jpg", "Chennai 3.jpg")},
    @{Name="Coorg"; Images=@("Coorg 1.jpg", "Coorg 2.jpg", "Coorg 3.jpg")},
    @{Name="Hampi"; Images=@("Hampi 1.jpg", "Hampi 2.jpg", "Hampi 3.jpg")},
    @{Name="Hyderabad"; Images=@("Hyderabad 1.jpg", "Hyderabad 2.jpg", "Hyderabad 3.jpg")},
    @{Name="Kochi"; Images=@("Kochi 1.jpg", "Kochi 2.jpg", "Kochi 3.jpg")},
    @{Name="Kodaikanal"; Images=@("Kodaikanal 1.jpg", "Kodaikanal 2.jpg", "Kodaikanal 3.jpg")},
    @{Name="Munnar"; Images=@("Munnar 1.jpg", "Munnar 2.jpg", "Munnar 3.jpg")},
    @{Name="Ooty"; Images=@("Ooty 1.jpg", "Ooty 2.jpg", "Ooty 3.jpg")},
    @{Name="Puducherry"; Images=@("Puducherry 1.jpg", "Puducherry 2.jpg", "Puducherry 3.jpg")},
    @{Name="Tirupati"; Images=@("Tirupati 1.jpg", "Tirupati 2.jpg", "Tirupati 3.jpg")}
)

$baseDir = "c:\Users\love1\Desktop\tori progect\Pages-inside\South-India"

foreach ($dest in $destinations) {
    $fileName = Join-Path $baseDir "$($dest.Name).html"
    
    if (Test-Path $fileName) {
        Write-Host "Processing $($dest.Name)..." -ForegroundColor Green
        
        # Read the file content
        $content = Get-Content $fileName -Raw
        
        # Create the gallery HTML
        $gallery = @"

        <!-- Photo Gallery Section -->
        <section class="content-section">
            <div class="section-header" data-scroll="fade-up">
                <span class="section-tag">Gallery</span>
                <h2 class="section-title">Explore $($dest.Name)</h2>
                <p class="section-subtitle">Discover the beauty through these stunning images</p>
            </div>

            <div class="row">
                <div class="col-md-4" data-scroll="fade-up" data-scroll-delay="1">
                    <div class="gallery-item">
                        <img src="../../South india image/$($dest.Images[0])" alt="$($dest.Name)" class="img-fluid" style="width: 100%; border-radius: 15px; margin-bottom: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
                    </div>
                </div>
                <div class="col-md-4" data-scroll="fade-up" data-scroll-delay="2">
                    <div class="gallery-item">
                        <img src="../../South india image/$($dest.Images[1])" alt="$($dest.Name)" class="img-fluid" style="width: 100%; border-radius: 15px; margin-bottom: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
                    </div>
                </div>
                <div class="col-md-4" data-scroll="fade-up" data-scroll-delay="3">
                    <div class="gallery-item">
                        <img src="../../South india image/$($dest.Images[2])" alt="$($dest.Name)" class="img-fluid" style="width: 100%; border-radius: 15px; margin-bottom: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.2);">
                    </div>
                </div>
            </div>
        </section>

"@
        
        # Find the CTA section and insert gallery before it
        $ctaPattern = '        <!-- CTA Section -->'
        
        if ($content -match [regex]::Escape($ctaPattern)) {
            $newContent = $content -replace [regex]::Escape($ctaPattern), ($gallery + $ctaPattern)
            Set-Content -Path $fileName -Value $newContent -NoNewline
            Write-Host "✓ Added gallery to $($dest.Name).html" -ForegroundColor Cyan
        } else {
            Write-Host "✗ Could not find CTA section in $($dest.Name).html" -ForegroundColor Yellow
        }
    } else {
        Write-Host "✗ File not found: $fileName" -ForegroundColor Red
    }
}

Write-Host "`nGallery addition complete!" -ForegroundColor Green
Write-Host "All South India destination pages now have image galleries." -ForegroundColor Green
