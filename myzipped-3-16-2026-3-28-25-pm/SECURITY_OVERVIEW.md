# 🛡️ Tour India Security & Authentication System

This document outlines the professional security architecture implemented for the Tour India project.

## 🔑 Authentication Architecture
The system uses a **Hybrid Authentication Model**:
1.  **Client-Side (Firebase Auth)**: Primary authentication for high-speed login, social sign-in (Google), and session persistence.
2.  **Server-Side (Python/Flask)**: Secondary verification using the `Firebase Admin SDK` to protect sensitive API endpoints.

---

## 🏗️ Security Layers

### 1. Unified Authentication Manager (`js/auth-manager.js`)
- Acts as a **Global session gatekeeper**.
- Automatically synchronizes Firebase state with the backend.
- Provides a centralized `requireAuth()` method for protecting specific pages.
- Standardizes the Login/Logout UI across the entire site.

### 2. Backend Protection (`backend/app.py`)
- **JWT Verification**: Every sensitive request to the Python API must include a `Bearer` token in the header.
- **Middleware Decorator**: Implemented `@token_required` to prevent unauthorized data access at the server level.
- **Service Account Security**: Sensitive database operations are handled via a protected JSON key, never exposed to the client.

### 3. Database Security Rules (`database/firestore.rules`)
- **Principle of Least Privilege**:
  - `Points of Interest`: Read/Public, Write/Admin Only.
  - `User Data`: Read/Write ONLY by the owner (UID check).
  - `Itineraries`: Personal plans are private; sharing requires explicit `public=true` flag.
  - `Bookings`: Immutable and private to the creating account.

### 4. Non-Intrusive Auth Flow (`js/auth-state.js`)
- Designed for landing pages where login is optional.
- Updates navigation dynamically (showing "Hi, Name" instead of "Login") without forcing a redirect.

---

## 🛠️ Security Settings Applied

| Feature | Status | Implementation |
|---------|--------|----------------|
| HTTPS Support | ✅ Ready | All Firebase CDN imports use HTTPS |
| Persistence | ✅ local | Sessions survive browser restarts |
| Password Policy | ✅ Enforced | Minimum 6 characters (Firebase default) |
| Token Verification | ✅ Server-side | Validated by Python Admin SDK |
| NoSQL Injection | ✅ Protected | Firestore naturally prevents SQLi; rules prevent data scraping |

---

## 🚀 Future Hardening Steps
- [ ] **MFA**: Enable Multi-Factor Authentication in Firebase Console.
- [ ] **Email Verification**: Force users to verify email before creating itineraries.
- [ ] **Rate Limiting**: Add `flask-limiter` to protect the Python API from brute-force.
- [ ] **CORS Policy**: Restrict `CORS(app)` to specific production domains only.

*Security System Audit - 2026*
