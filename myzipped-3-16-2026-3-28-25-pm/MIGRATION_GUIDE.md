# 🚀 React & Node.js Migration Plan - Tour India

This guide outlines the transition from a static HTML/Python stack to a modern **Full-Stack JavaScript (React + Node.js)** architecture.

## 📦 New Structure
We have introduced two new directories:
1.  **`/frontend-react`**: A modern React application powered by **Vite**, **Framer Motion** (animations), and **React Router**.
2.  **`/backend-node`**: An **Express.js** backend that mirrors the Python API but with Node.js performance and the `firebase-admin` SDK.

---

## 🛠️ Prerequisites
To run this new stack, you must have **Node.js (LTS)** installed on your machine.
- [Download Node.js here](https://nodejs.org/)
- Verify installation with: `node -v` and `npm -v`

---

## 🏃 Getting Started

### 1. Start the Node.js Backend
```bash
cd backend-node
npm install
npm run start
```
*Note: Ensure your `service-account.json` is placed in the `backend-node/` folder.

## ✨ Improvements in this Stack
- **Component-Based UI**: Using React components like `<DestinationCard />` makes the code reusable and easier to maintain than static HTML.
- **Declarative Routing**: Smooth navigation between pages without full browser reloads.
- **State Management**: Real-time updates and efficient data fetching using `useState` and `useEffect`.
- **Advanced Animations**: Using `framer-motion` for professional-grade transitions that were previously hard to achieve with manual CSS.
- **Unified Language**: Using JavaScript/TypeScript for both frontend and backend improves developer productivity.

---

## 🛣️ Migration Roadmap
1. [ ] **Step 1**: Move all static HTML content into React components.
2. [ ] **Step 2**: Replace `api-client.js` with `axios` calls to the Node.js server.
3. [ ] **Step 3**: Implement Firebase Auth using the `firebase` React SDK.
4. [ ] **Step 4**: Deploy the backend to a provider like Heroku/Render and the frontend to Vercel/Netlify.

---
*Migration Architected by Antigravity AI - 2026*
