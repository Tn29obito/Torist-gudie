# 🚀 How to Host Your Website Live

I have configured your project for **Firebase Hosting**. This is the best way to host your site since you're already using Firebase database.

## 📋 Prerequisites
- You need to be connected to the internet.
- You need to have Node.js installed (which you likely do).

## ⚡ Quick Start

1. **Run the Deployment Script**
   Double-click on the file **`DEPLOY_NOW.bat`** in your project folder.

2. **Login (First Time Only)**
   - A browser window might open asking you to login to Google.
   - Authorize "Firebase CLI" to access your account.
   - Use the same account where you created the `tourist-guide-1e156` project.

3. **Wait for Deployment**
   - The script will upload your files.
   - Once done, it will open your live website!

## 🌐 Your Live URL
Once deployed, your website will be available at:
**https://tourist-guide-1e156.web.app**

## 🛠️ Configuration Details
- **Entry Point**: I created `index.html` in the root folder which redirects to `html/home.html`.
- **Config Files**: `firebase.json` and `.firebaserc` are set up for your project.
- **Root Directory**: The entire project folder is uploaded, excluding hidden files.

## 🔄 Updating Your Site
Whenever you make changes to your code:
1. Save your files.
2. Run **`DEPLOY_NOW.bat`** again.
3. Your changes will be live in seconds!
