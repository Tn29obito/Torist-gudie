// Firebase Integration Script for South India Destination Pages
// Auto-adds Firebase integration to all 12 destination pages

$destinationPages = @(
    "Alleppey", "Bengaluru", "Chennai", "Coorg", "Hampi", 
    "Hyderabad", "Kochi", "Kodaikanal", "Munnar", "Ooty", 
    "Puducherry", "Tirupati"
)

$basePath = "c:\Users\love1\Desktop\tori progect\Pages-inside\South-India"

# Firebase integration code to add
$firebaseIntegration = @'

    <!-- Firebase Integration - Backend Connectivity -->
    <script type="module">
        // Import Firebase services
        import { app, auth, db } from '../../database/firebase-config.js';
        import { ItineraryService, ItineraryPointService, PointOfInterestService } from '../../database/firestore-schema.js';
        import { onAuthStateChanged } from 'https://www.gstatic.com/firebasejs/10.7.1/firebase-auth.js';

        // Get destination info from page
        const destinationName = document.querySelector('.hero-title').textContent.trim();
        const destinationId = window.location.pathname.split('/').pop().replace('.html', '').toLowerCase();

        console.log('🔥 Firebase integration loaded for:', destinationName);

        // Check authentication status
        onAuthStateChanged(auth, (user) => {
            if (user) {
                console.log('✅ User logged in:', user.email);
                showAuthenticatedUI(user);
            } else {
                console.log('ℹ️ User not logged in');
                showGuestUI();
            }
        });

        // Show UI for logged-in users
        function showAuthenticatedUI(user) {
            // Add user info to navigation
            const nav = document.querySelector('.navbar-nav');
            if (nav && !document.getElementById('user-info')) {
                const userItem = document.createElement('li');
                userItem.className = 'nav-item';
                userItem.id = 'user-info';
                userItem.innerHTML = `
                    <span class="nav-link" style="color: #f8b600; cursor: pointer;" title="View Profile">
                        👤 ${user.displayName || user.email.split('@')[0]}
                    </span>
                `;
                nav.appendChild(userItem);
            }

            // Add "Save to Itinerary" button
            addSaveButton(user);
        }

        // Show UI for guests
        function showGuestUI() {
            const nav = document.querySelector('.navbar-nav');
            if (nav && !document.getElementById('login-link')) {
                const loginItem = document.createElement('li');
                loginItem.className = 'nav-item';
                loginItem.id = 'login-link';
                loginItem.innerHTML = `
                    <a class="nav-link" href="../../html/login.html" style="color: #f8b600;">
                        🔐 Login
                    </a>
                `;
                nav.appendChild(loginItem);
            }
        }

        // Add "Save to Itinerary" button
        function addSaveButton(user) {
            const ctaSection = document.querySelector('.cta-section');
            if (ctaSection && !document.getElementById('save-to-trip-btn')) {
                const saveBtn = document.createElement('button');
                saveBtn.id = 'save-to-trip-btn';
                saveBtn.className = 'cta-btn';
                saveBtn.style.cssText = `
                    margin-left: 15px;
                    background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%);
                    border: none;
                    padding: 15px 30px;
                    border-radius: 50px;
                    color: white;
                    font-weight: 600;
                    cursor: pointer;
                    transition: all 0.3s ease;
                    display: inline-flex;
                    align-items: center;
                    gap: 10px;
                `;
                saveBtn.innerHTML = `
                    <span>➕ Add to My Trip</span>
                `;
                
                saveBtn.addEventListener('mouseenter', () => {
                    saveBtn.style.transform = 'translateY(-3px)';
                    saveBtn.style.boxShadow = '0 10px 30px rgba(17, 153, 142, 0.4)';
                });
                
                saveBtn.addEventListener('mouseleave', () => {
                    saveBtn.style.transform = 'translateY(0)';
                    saveBtn.style.boxShadow = 'none';
                });
                
                saveBtn.addEventListener('click', async () => {
                    saveBtn.disabled = true;
                    saveBtn.innerHTML = '<span>⏳ Saving...</span>';
                    await saveToItinerary(user, destinationId, destinationName);
                    saveBtn.disabled = false;
                    saveBtn.innerHTML = '<span>➕ Add to My Trip</span>';
                });
                
                const exploreBtn = ctaSection.querySelector('a.cta-btn');
                if (exploreBtn) {
                    exploreBtn.insertAdjacentElement('afterend', saveBtn);
                }
            }
        }

        // Save destination to user's itinerary
        async function saveToItinerary(user, poiId, poiName) {
            try {
                console.log('💾 Saving to itinerary:', poiName);
                
                // Check if user has an active itinerary
                const itineraries = await ItineraryService.getUserItineraries(user.uid);
                
                let itineraryId;
                
                if (itineraries.success && itineraries.data.length > 0) {
                    // Use the first itinerary
                    itineraryId = itineraries.data[0].id;
                    console.log('📋 Using existing itinerary:', itineraryId);
                } else {
                    // Create a new itinerary
                    console.log('📝 Creating new itinerary...');
                    const newItinerary = await ItineraryService.createItinerary(user.uid, {
                        name: 'My India Trip',
                        description: 'My personalized India travel itinerary',
                        public: false,
                        startDate: new Date().toISOString().split('T')[0],
                        endDate: null
                    });
                    
                    if (!newItinerary.success) {
                        throw new Error('Failed to create itinerary');
                    }
                    
                    itineraryId = newItinerary.id;
                    console.log('✅ New itinerary created:', itineraryId);
                }
                
                // Get current points count for ordering
                const existingPoints = await ItineraryPointService.getPointsForItinerary(itineraryId);
                const orderNumber = existingPoints.success ? existingPoints.data.length + 1 : 1;
                
                // Add this destination to the itinerary
                const result = await ItineraryPointService.addPoint({
                    itineraryId: itineraryId,
                    pointOfInterestId: poiId,
                    orderInItinerary: orderNumber,
                    notes: `Added from ${poiName} page on ${new Date().toLocaleDateString()}`,
                    visitedDate: null
                });
                
                if (result.success) {
                    showNotification(`✅ ${poiName} added to your trip!`, 'success');
                    console.log('✅ Destination saved to itinerary');
                } else {
                    throw new Error(result.error || 'Failed to add destination');
                }
                
            } catch (error) {
                console.error('❌ Error saving to itinerary:', error);
                showNotification(`❌ Failed to save: ${error.message}`, 'error');
            }
        }

        // Show notification
        function showNotification(message, type) {
            const notification = document.createElement('div');
            notification.style.cssText = `
                position: fixed;
                top: 100px;
                right: 30px;
                background: ${type === 'success' ? 'linear-gradient(135deg, #11998e 0%, #38ef7d 100%)' : 'linear-gradient(135deg, #e74c3c 0%, #c0392b 100%)'};
                color: white;
                padding: 20px 30px;
                border-radius: 15px;
                box-shadow: 0 10px 40px rgba(0,0,0,0.3);
                z-index: 10000;
                font-weight: 600;
                animation: slideIn 0.3s ease-out;
            `;
            notification.textContent = message;
            
            document.body.appendChild(notification);
            
            setTimeout(() => {
                notification.style.animation = 'slideOut 0.3s ease-out';
                setTimeout(() => notification.remove(), 300);
            }, 3000);
        }

        // Add animations
        const style = document.createElement('style');
        style.textContent = `
            @keyframes slideIn {
                from {
                    transform: translateX(400px);
                    opacity: 0;
                }
                to {
                    transform: translateX(0);
                    opacity: 1;
                }
            }
            @keyframes slideOut {
                from {
                    transform: translateX(0);
                    opacity: 1;
                }
                to {
                    transform: translateX(400px);
                    opacity: 0;
                }
            }
        `;
        document.head.appendChild(style);
    </script>
'@

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " FIREBASE INTEGRATION - AUTO-INSTALLER" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

$successCount = 0
$errorCount = 0

foreach ($destination in $destinationPages) {
    $filePath = Join-Path $basePath "$destination.html"
    
    if (Test-Path $filePath) {
        try {
            $content = Get-Content $filePath -Raw
            
            # Check if already integrated
            if ($content -match "Firebase Integration - Backend Connectivity") {
                Write-Host "⏭️  Skipped: $destination.html (already integrated)" -ForegroundColor Yellow
                continue
            }
            
            # Find the closing </body> tag and insert before it
            if ($content -match "</body>") {
                $content = $content -replace "</body>", "$firebaseIntegration`n</body>"
                Set-Content -Path $filePath -Value $content -NoNewline
                Write-Host "✅ Integrated: $destination.html" -ForegroundColor Green
                $successCount++
            }
            else {
                Write-Host "⚠️  Warning: No </body> tag found in $destination.html" -ForegroundColor Yellow
                $errorCount++
            }
            
        }
        catch {
            Write-Host "❌ Error: $destination.html - $_" -ForegroundColor Red
            $errorCount++
        }
    }
    else {
        Write-Host "❌ Not found: $destination.html" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "COMPLETED!" -ForegroundColor Green
Write-Host "✅ Successfully integrated: $successCount files" -ForegroundColor Green
if ($errorCount -gt 0) {
    Write-Host "❌ Errors/Skipped: $errorCount files" -ForegroundColor Yellow
}
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Open any South India page in browser" -ForegroundColor White
Write-Host "2. Check browser console for Firebase messages" -ForegroundColor White
Write-Host "3. Login to see 'Add to My Trip' button" -ForegroundColor White
Write-Host "4. Test saving destinations to itinerary`n" -ForegroundColor White

pause
