# 🚀 How to Run Your Tour India Project

## 📋 Quick Start Guide

---

## Method 1: Open Directly in Browser (Simplest) ✅

### Step 1: Find Your Main Files

Your main entry points are:
- **Homepage**: `html/home.html` - Start here for the main website
- **Login Page**: `html/login.html` - User authentication
- **Destinations**: `html/destination.html` - Browse destinations
- **Database Test**: `database/test-connection.html` - Test Firebase

### Step 2: Open in Browser

**Option A: Double-click the file**
1. Navigate to: `c:\Users\love1\Desktop\tori progect\html\`
2. Double-click `home.html`
3. It will open in your default browser

**Option B: Right-click and choose browser**
1. Right-click on `home.html`
2. Select "Open with"
3. Choose your browser (Chrome, Edge, Firefox)

---

## Method 2: Use Live Server (Recommended for Development) ⭐

This is better because:
- ✅ Auto-refresh when you edit files
- ✅ Better file path handling
- ✅ Firebase modules work properly

### Using Python (Built-in on most systems)

1. Open PowerShell/Command Prompt
2. Navigate to your project:
   ```powershell
   cd "c:\Users\love1\Desktop\tori progect"
   ```

3. Start the server:
   ```powershell
   python -m http.server 8000
   ```

4. Open browser and go to:
   - Homepage: `http://localhost:8000/html/home.html`
   - Database Test: `http://localhost:8000/database/test-connection.html`

5. To stop the server, press `Ctrl + C`

### Using Node.js (If you have it installed)

1. Install live-server globally (one-time setup):
   ```powershell
   npm install -g live-server
   ```

2. Navigate to your project:
   ```powershell
   cd "c:\Users\love1\Desktop\tori progect"
   ```

3. Start the server:
   ```powershell
   live-server
   ```

4. It will automatically open in your browser!

---

## Method 3: Use VS Code Live Server Extension 🎯

If you have Visual Studio Code:

1. Install "Live Server" extension by Ritwick Dey
2. Open your project folder in VS Code
3. Right-click on `html/home.html`
4. Click "Open with Live Server"
5. Your browser will open automatically!

---

## 📂 Project Structure Overview

```
tori progect/
│
├── html/                          # Main pages
│   ├── home.html                  ⭐ START HERE - Homepage
│   ├── login.html                 - Login page
│   ├── register.html              - Registration
│   ├── destination.html           - Browse destinations
│   └── West-India.html            - Regional pages
│
├── Pages-inside/                  # Individual destination pages
│   ├── Srinagar.html
│   ├── Gulmarg.html
│   ├── Leh.html
│   └── ... (many more)
│
├── database/                      # Firebase database (NEW!)
│   ├── test-connection.html       - Test Firebase setup
│   ├── example-integration.html   - See database in action
│   ├── firebase-config.js         - Firebase credentials
│   ├── db-operations.js           - Database functions
│   └── seed-data.js               - Initial data
│
├── css/                           # Stylesheets
├── js/                            # JavaScript files
├── img/                           # Images
├── fonts/                         # Custom fonts
└── pictures/                      # More images
```

---

## 🎯 Recommended Running Order

### For First Time Setup:

1. **Test Firebase Connection** 
   - Open: `database/test-connection.html`
   - Click "Test Connection"
   - Click "Add Initial Destinations"

2. **View Main Website**
   - Open: `html/home.html`
   - Browse around the site

3. **See Database Integration Example**
   - Open: `database/example-integration.html`
   - See how destinations load from Firebase

4. **Test Login/Registration**
   - Open: `html/login.html`
   - Try the authentication flow

---

## 🔧 Common Issues & Solutions

### Issue 1: "File not found" errors
**Problem:** Paths are broken when opening files directly

**Solution:** Use a local server (Method 2 or 3)

### Issue 2: Firebase not working
**Problem:** CORS or module errors

**Solution:** 
1. Must use a local server (not direct file opening)
2. Make sure Firestore is enabled in Firebase Console
3. Check `database/firebase-config.js` has correct credentials

### Issue 3: Images not loading
**Problem:** Relative paths are incorrect

**Solution:** 
1. Use a local server
2. All paths should be relative to your current file location

### Issue 4: CSS/JS not loading
**Problem:** File paths in HTML are wrong

**Solution:** Check that paths match your actual file structure
- From `html/home.html`, CSS is at `../css/home.css`
- From `Pages-inside/Srinagar.html`, CSS might be at `../css/...`

---

## 🌐 URLs to Access Your Site

### When using Python server (port 8000):
- **Homepage**: http://localhost:8000/html/home.html
- **Destinations**: http://localhost:8000/html/destination.html
- **Login**: http://localhost:8000/html/login.html
- **Database Test**: http://localhost:8000/database/test-connection.html
- **Example Integration**: http://localhost:8000/database/example-integration.html

### When using Live Server (usually port 5500):
- **Homepage**: http://127.0.0.1:5500/html/home.html
- (Adjust port number if different)

---

## 📱 Testing on Mobile

### Method 1: Using Local Network
1. Find your computer's IP address:
   ```powershell
   ipconfig
   ```
   Look for "IPv4 Address" (e.g., 192.168.1.5)

2. Start local server (Method 2)

3. On your phone (connected to same WiFi):
   - Open browser
   - Go to: `http://YOUR_IP_ADDRESS:8000/html/home.html`
   - Example: `http://192.168.1.5:8000/html/home.html`

### Method 2: Deploy Online
- Use GitHub Pages, Netlify, or Vercel (free hosting)

---

## 🚀 Quick Commands Reference

### Start Python Server:
```powershell
cd "c:\Users\love1\Desktop\tori progect"
python -m http.server 8000
```

### Start Live Server (if installed):
```powershell
cd "c:\Users\love1\Desktop\tori progect"
live-server
```

### Open in Default Browser:
```powershell
start html/home.html
```

---

## 🎨 Before First Run - Firebase Setup (5 minutes)

If you want to use the database features:

1. **Enable Firestore**:
   - Go to https://console.firebase.google.com/project/tourist-guide-1e156
   - Click "Firestore Database" → "Create Database"
   - Choose "Test mode" → Enable

2. **Test Connection**:
   - Open: `database/test-connection.html`
   - Click "🔌 Test Connection"
   - Should see: ✅ SUCCESS!

3. **Add Data**:
   - Click "🌱 Add Initial Destinations"
   - Wait 1-2 minutes for completion

4. **Done!** Your database is ready

---

## 📋 Testing Checklist

- [ ] Home page loads correctly
- [ ] Navigation works (can move between pages)
- [ ] Images are displaying
- [ ] CSS styling is applied
- [ ] JavaScript features work (sliders, animations)
- [ ] Destination pages are accessible
- [ ] Firebase connection works (if using database)
- [ ] Login/Register pages load
- [ ] Forms are functional
- [ ] Mobile responsive design works

---

## 💡 Pro Tips

1. **Use Chrome DevTools** (F12) to debug issues
2. **Check Browser Console** for JavaScript errors
3. **Use Network Tab** to see failed file loads
4. **Clear Browser Cache** (Ctrl + Shift + Delete) if updates don't show
5. **Use Incognito Mode** to test without cache

---

## 🆘 Still Having Issues?

1. **Check console errors**: Press F12 in browser → Console tab
2. **Verify file paths**: Make sure all files exist where referenced
3. **Test different browsers**: Try Chrome, Edge, Firefox
4. **Use a local server**: Don't open files directly (file://)

---

## 🎉 Success!

If you can see your homepage with all styling and images, you're ready to go!

**Your Tour India website is running! 🇮🇳**

---

## Next Steps

1. ✅ Run the project locally
2. ✅ Test all pages and features
3. ✅ Set up Firebase database (if needed)
4. ⬜ Customize content and styling
5. ⬜ Deploy online (GitHub Pages, Netlify, etc.)

**Happy developing! 🚀**
