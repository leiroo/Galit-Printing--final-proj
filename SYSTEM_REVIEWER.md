# GALIT Digital Printing Services - Complete System Reviewer

## 📋 Table of Contents
1. [System Overview](#1-system-overview)
2. [How the System Was Built](#2-how-the-system-was-built)
3. [AI Integration (Google Gemini)](#3-ai-integration-google-gemini)
4. [Google Cloud Console & OAuth](#4-google-cloud-console--oauth)
5. [Session Timeout & Auto-Logout](#5-session-timeout--auto-logout)
6. [Deployment on Render using GitHub](#6-deployment-on-render-using-github)
7. [Technologies & Frameworks](#7-technologies--frameworks)
8. [Frontend Resources: Icons, Animations & Libraries](#8-frontend-resources-icons-animations--libraries)
9. [Project Structure](#9-project-structure)
10. [System Features](#10-system-features)
11. [Configuration & Environment Variables](#11-configuration--environment-variables)

---

## 1. System Overview

### What is GALIT Digital Printing Services System?

Ang **GALIT Digital Printing Services Management System** ay isang comprehensive business management system na ginawa para sa digital printing business. Ang sistema ay nagha-handle ng:

- **Job Order Management** - Complete order lifecycle from creation to completion
- **Customer Management** - Customer database, authentication, at order history
- **Inventory Management** - Stock tracking, materials management
- **Staff & Task Management** - Automated task assignment based on service types
- **Sales & Reporting** - Business analytics, reports, at insights
- **AI-Powered Insights** - Business recommendations using Google Gemini AI
- **Real-time Notifications** - Server-Sent Events (SSE) para sa real-time updates

### User Types

1. **Admin** - Full system access, analytics, staff management
2. **Clerk** - Order creation, customer lookup, basic reports
3. **Customer** - Order tracking, order history, account management

### System Architecture

```
┌─────────────────┐
│   Frontend      │  HTML5, CSS3, Vanilla JavaScript
│  (Static Site)  │  Deployed on Render Static Site
└────────┬────────┘
         │
         │ HTTP/HTTPS
         │ REST API
         ▼
┌─────────────────┐
│   Backend API   │  Node.js + Express.js
│  (Web Service)  │  Deployed on Render Web Service
└────────┬────────┘
         │
         │ PostgreSQL Connection
         ▼
┌─────────────────┐
│   PostgreSQL    │  Database
│   (Database)    │  Deployed on Render PostgreSQL
└─────────────────┘
```

---

## 2. How the System Was Built

### Development Process

#### Phase 1: Planning & Design
- Requirements gathering
- Database schema design
- API endpoint planning
- User interface design

#### Phase 2: Backend Development
1. **Database Setup**
   - PostgreSQL database creation
   - Schema design (`backend/sql/schema.sql`)
   - Tables, indexes, triggers, functions
   - Migration system for updates

2. **API Development**
   - Express.js server setup
   - RESTful API endpoints
   - Authentication middleware
   - File upload handling
   - Error handling

3. **Business Logic**
   - Task automation system
   - Inventory management
   - Order processing
   - Reporting & analytics

#### Phase 3: Frontend Development
1. **Static Pages**
   - Admin dashboard (`index.html`)
   - Clerk dashboard (`clerk.html`)
   - Customer portal (`customer.html`)
   - Login pages

2. **JavaScript Functionality**
   - API integration
   - Real-time updates (SSE)
   - Session management
   - UI interactions

3. **Styling**
   - Responsive design
   - Modern UI/UX
   - Custom CSS

#### Phase 4: Integration
- Google OAuth integration
- Gemini AI integration
- Cloudinary file storage
- Email service integration

#### Phase 5: Deployment
- GitHub repository setup
- Render backend deployment
- Render static site deployment
- Database migration
- Environment configuration

### Architecture Pattern

**RESTful API Architecture:**
- **Backend:** Node.js + Express.js
- **Database:** PostgreSQL (Relational)
- **Frontend:** Static HTML/CSS/JS
- **Authentication:** JWT (JSON Web Tokens)
- **File Storage:** Cloudinary (Cloud-based)
- **Real-time:** Server-Sent Events (SSE)

**Separation of Concerns:**
- Frontend: Presentation layer (UI/UX)
- Backend: Business logic & API
- Database: Data persistence
- External Services: AI, OAuth, File Storage

---

## 3. AI Integration (Google Gemini)

### Overview
Ang sistema ay gumagamit ng **Google Gemini 2.5 Flash** model para sa AI-powered business insights at recommendations. Ang AI ay ginagamit para mag-generate ng intelligent analysis base sa business data.

### Paano Nakuha ang API Key

#### Step 1: Google AI Studio
1. Pumunta sa [Google AI Studio](https://makersuite.google.com/app/apikey)
2. Sign in gamit ang Google account
3. Click **"Get API Key"** o **"Create API Key"**
4. Pumili ng Google Cloud Project (o gumawa ng bago)
5. Copy ang API key na nabuo

#### Step 2: I-configure sa System
1. I-add ang API key sa `.env` file (local) o Render Environment Variables (production):
   ```env
   GEMINI_API_KEY=your_gemini_api_key_here
   ```

### Implementation Details

**Location:** `backend/routes/ai.js`

**API Endpoints:**
- `POST /api/ai/generate-insight` - Generate AI insights
- `GET /api/ai/quota` - Check API quota usage
- `GET /api/ai/test` - Test API connection

**API Configuration:**
```javascript
// API Endpoint
const hostname = 'generativelanguage.googleapis.com';
const path = `/v1beta/models/gemini-2.5-flash:generateContent?key=${apiKey}`;

// Request Configuration
{
  contents: [{
    parts: [{
      text: prompt  // User's question/prompt
    }]
  }],
  generationConfig: {
    temperature: 0.7,        // Creativity level (0-1)
    maxOutputTokens: 2000    // Maximum response length
  }
}
```

**Rate Limiting:**
- **Limit:** 240 requests per day (below Google's 250 free tier limit)
- **Purpose:** Prevent quota exhaustion
- **Implementation:** In-memory rate limiter

**Error Handling:**
- Automatic retry (up to 3 attempts)
- Handles 503 errors (service overloaded)
- Graceful fallback when unavailable

### Security Features

1. **API Key Protection:**
   - Stored in `.env` file (not in code)
   - Not exposed to frontend
   - Backend-only access

2. **Authentication:**
   - Requires JWT token
   - Clerk or Admin access only
   - Protected by `authenticateToken` middleware

3. **Rate Limiting:**
   - Prevents quota exhaustion
   - Tracks daily usage
   - Returns 429 error when limit reached

### Usage Example

**Frontend Request:**
```javascript
fetch('/api/ai/generate-insight', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Authorization': `Bearer ${token}`
  },
  body: JSON.stringify({
    prompt: "Analyze our sales trends for this month"
  })
})
```

**Backend Response:**
```json
{
  "success": true,
  "data": {
    "insight": "Based on your data, sales increased by 15%..."
  },
  "quota": {
    "remaining": 239,
    "limit": 240
  }
}
```

---

## 4. Google Cloud Console & OAuth

### Overview
Ang sistema ay gumagamit ng **Google OAuth 2.0** para sa authentication. Parehong admin at customers ay pwedeng mag-login gamit ang Google account.

### Paano Nakuha ang Google Client ID

#### Step 1: Google Cloud Console Setup
1. Pumunta sa [Google Cloud Console](https://console.cloud.google.com/)
2. Sign in gamit ang Google account
3. Gumawa ng bagong project o pumili ng existing:
   - Click **"Select a project"** → **"New Project"**
   - I-name ang project (hal: "GALIT Digital Printing")
   - Click **"Create"**

#### Step 2: Enable OAuth Consent Screen
1. Sa left sidebar, pumunta sa **"APIs & Services"** → **"OAuth consent screen"**
2. Piliin ang **"External"** (para sa public users)
3. Fill up ang required fields:
   - **App name:** GALIT Digital Printing Services
   - **User support email:** galitdigitalprintingservices@gmail.com
   - **Developer contact:** Your email
4. Click **"Save and Continue"**
5. Sa **"Scopes"**, add: `email`, `profile`, `openid`
6. Click **"Save and Continue"** → **"Back to Dashboard"**

#### Step 3: Create OAuth 2.0 Credentials
1. Pumunta sa **"APIs & Services"** → **"Credentials"**
2. Click **"Create Credentials"** → **"OAuth client ID"**
3. Piliin ang **Application type:** **Web application**
4. I-name ang client (hal: "GALIT Web Client")
5. Sa **"Authorized JavaScript origins":**
   - Add: `http://localhost:5500` (development)
   - Add: `https://yourdomain.com` (production)
6. Sa **"Authorized redirect URIs":**
   - Add: `http://localhost:5500/customer.html`
   - Add: `http://localhost:5500/index.html`
7. Click **"Create"**
8. **Copy ang Client ID**

#### Step 4: I-configure sa System
1. I-add ang Client ID sa `.env` file o Render Environment Variables:
   ```env
   GOOGLE_CLIENT_ID=your_google_client_id_here.apps.googleusercontent.com
   ```

2. I-configure sa frontend (`frontend/config.js`):
   ```javascript
   window.GOOGLE_CLIENT_ID = 'your_google_client_id_here.apps.googleusercontent.com';
   ```

### Implementation Details

**Location:** `backend/routes/auth.js`

**Package Used:**
```javascript
const { OAuth2Client } = require('google-auth-library');
```

**Token Verification:**
```javascript
const verifyGoogleIdToken = async (credential) => {
  const ticket = await googleClient.verifyIdToken({
    idToken: credential,
    audience: googleClientId
  });
  
  const payload = ticket.getPayload();
  
  // Validate email
  if (!payload.email || !payload.email_verified) {
    throw new Error('Invalid Google account');
  }
  
  return payload;
};
```

**API Endpoints:**
- `POST /api/auth/admin/google` - Admin Google login
- `POST /api/auth/customer/google` - Customer Google login
- `POST /api/auth/customer/google-oauth` - OAuth code exchange

**Admin Restriction:**
- Only `galitdigitalprintingservices@gmail.com` can login as admin
- Other Google accounts are treated as customers

### OAuth Flow

#### For Customers:
1. User clicks "Sign in with Google"
2. Google shows consent screen
3. User approves
4. Google returns ID token (credential)
5. Frontend sends credential to backend
6. Backend verifies token
7. Backend creates/updates customer account
8. Backend returns JWT token
9. Frontend stores token and redirects

#### For Admin:
1. Admin clicks "Sign in with Google"
2. Google shows consent screen
3. Admin approves
4. Google returns ID token
5. Frontend sends credential to backend
6. Backend verifies token
7. Backend checks if email is admin email
8. Backend creates/updates admin account
9. Backend returns JWT token
10. Frontend stores token and redirects

---

## 5. Session Timeout & Auto-Logout

### Overview
Ang sistema ay may automatic session timeout at logout mechanism para sa lahat ng user types. Ang timeout ay base sa inactivity (walang user activity).

### Session Timeout Durations

#### Frontend Timeout (Inactivity-based)

| User Type | Timeout Duration | In Milliseconds |
|-----------|-----------------|------------------|
| **Customer** | **1 hour** | 3,600,000 ms |
| **Admin** | **5 hours** | 18,000,000 ms |
| **Clerk** | **12 hours** | 43,200,000 ms |

#### Backend JWT Token Expiration

| User Type | JWT Expiration | Configuration |
|-----------|----------------|---------------|
| **Admin** | **24 hours** | `JWT_EXPIRES_IN=24h` |
| **Clerk** | **24 hours** | `JWT_EXPIRES_IN=24h` |
| **Customer** | **7 days** | `JWT_EXPIRES_IN=7d` |

#### Customer Database Session

| User Type | Database Session | Expiration |
|-----------|------------------|------------|
| **Customer** | **7 days** | Stored in `customer_sessions` table |

### How It Works

**Frontend Session Timeout Manager:**
- **Location:** `frontend/session-timeout.js`
- **Activity Detection:** Monitors user activity (mouse, keyboard, scroll, touch)
- **Automatic Reset:** Resets timeout on user activity
- **Throttling:** Resets only every 60 seconds (to prevent overload)
- **Auto-Logout:** Automatic logout when timeout reached

**Backend JWT Expiration:**
- **Location:** `backend/routes/auth.js`
- **Token Generation:** JWT tokens with expiration
- **Token Verification:** Backend middleware validates expiration
- **Expired Tokens:** Returns 401 error when expired

**Customer Database Sessions:**
- **Location:** `backend/middleware/auth.js`
- **Session Storage:** Sessions stored in `customer_sessions` table
- **Session Validation:** Backend validates session expiration on every request
- **Expired Sessions:** Automatically rejected

### Logout Process

**Manual Logout:**
1. User clicks "Logout" button
2. Frontend calls logout API endpoint
3. Backend invalidates session (for customers)
4. Frontend clears localStorage
5. Frontend redirects to login page

**Automatic Logout (Session Timeout):**
1. User has no activity for specified duration
2. Frontend SessionTimeoutManager detects timeout
3. Frontend calls logout callback function
4. Frontend clears localStorage (including login timestamp)
5. Frontend redirects to login page
6. Shows message: "Session expired due to inactivity"

---

## 6. Deployment on Render using GitHub

### Overview
Ang sistema ay deployed sa **Render** platform gamit ang **GitHub** para sa version control at automatic deployment.

### Render Services Used

1. **Web Service** - Backend API (Node.js/Express)
2. **PostgreSQL Database** - Database service
3. **Static Site** - Frontend (HTML/CSS/JS)

### Deployment Process

#### Step 1: GitHub Repository Setup

1. **Create GitHub Repository:**
   ```bash
   git init
   git add .
   git commit -m "Initial commit"
   git remote add origin https://github.com/yourusername/galit-digital-printing.git
   git push -u origin main
   ```

2. **Repository Structure:**
   ```
   GalitDigitalPrintingFinal_3/
   ├── backend/          # Backend code
   ├── frontend/         # Frontend code
   ├── README.md         # Documentation
   └── .gitignore        # Git ignore file
   ```

#### Step 2: Render Backend Deployment

1. **Create Web Service:**
   - Go to [Render Dashboard](https://dashboard.render.com/)
   - Click **"New +"** → **"Web Service"**
   - Connect your GitHub repository
   - Select the repository

2. **Configure Service:**
   - **Name:** `galit-printing-backend` (or your preferred name)
   - **Environment:** `Node`
   - **Build Command:** `cd backend && npm install`
   - **Start Command:** `cd backend && npm start`
   - **Root Directory:** Leave empty (or set to `backend` if needed)

3. **Environment Variables:**
   Add the following in Render Dashboard → Environment:
   ```env
   # Database Configuration
   DB_HOST=your-render-postgres-host
   DB_PORT=5432
   DB_NAME=galit_digital_printing
   DB_USER=your-db-user
   DB_PASSWORD=your-db-password
   
   # Server Configuration
   PORT=10000
   NODE_ENV=production
   
   # JWT Configuration
   JWT_SECRET=your_super_secret_jwt_key_here
   JWT_EXPIRES_IN=24h
   
   # Frontend URL
   FRONTEND_URL=https://your-frontend-url.onrender.com
   
   # Google OAuth
   GOOGLE_CLIENT_ID=your_google_client_id
   
   # Gemini AI
   GEMINI_API_KEY=your_gemini_api_key
   
   # Cloudinary (Required for file uploads)
   CLOUDINARY_URL=cloudinary://api_key:api_secret@cloud_name
   # OR separate variables:
   CLOUDINARY_CLOUD_NAME=your_cloud_name
   CLOUDINARY_API_KEY=your_api_key
   CLOUDINARY_API_SECRET=your_api_secret
   
   # Migrations
   RUN_MIGRATIONS_ON_STARTUP=true
   ```

4. **Deploy:**
   - Click **"Create Web Service"**
   - Render will automatically build and deploy
   - Wait for deployment to complete
   - Copy the service URL (e.g., `https://galit-printing-backend.onrender.com`)

#### Step 3: Render PostgreSQL Database

1. **Create Database:**
   - Go to Render Dashboard
   - Click **"New +"** → **"PostgreSQL"**
   - **Name:** `galit-db` (or your preferred name)
   - **Database:** `galit_digital_printing`
   - **User:** Auto-generated
   - Click **"Create Database"**

2. **Get Connection Details:**
   - Go to database dashboard
   - Copy:
     - **Internal Database URL** (for backend)
     - **External Connection String** (for local access)

3. **Run Initial Schema:**
   - Use Render Shell or external tool (pgAdmin)
   - Connect to database
   - Run `backend/sql/schema.sql`

4. **Update Backend Environment:**
   - Use the Internal Database URL from Render
   - Or set individual variables:
     ```
     DB_HOST=dpg-xxxxx-a.oregon-postgres.render.com
     DB_PORT=5432
     DB_NAME=galit_digital_printing
     DB_USER=galit_user
     DB_PASSWORD=your_password
     ```

#### Step 4: Render Static Site (Frontend)

1. **Create Static Site:**
   - Go to Render Dashboard
   - Click **"New +"** → **"Static Site"**
   - Connect your GitHub repository
   - Select the repository

2. **Configure Site:**
   - **Name:** `galit-printing-frontend` (or your preferred name)
   - **Build Command:** Leave empty (static files)
   - **Publish Directory:** `frontend`
   - **Root Directory:** Leave empty

3. **Environment Variables (if needed):**
   - Usually not needed for static sites
   - But you can set build-time variables if needed

4. **Update Frontend Configuration:**
   - Edit `frontend/config.js`:
   ```javascript
   // Production (Render)
   window.API_ORIGIN = 'https://galit-printing-backend.onrender.com';
   window.API_BASE = window.API_ORIGIN + '/api';
   ```

5. **Deploy:**
   - Click **"Create Static Site"**
   - Render will deploy frontend
   - Copy the site URL (e.g., `https://galit-printing-frontend.onrender.com`)

#### Step 5: Configure CORS

1. **Update Backend CORS:**
   - In `backend/server.js`, add your frontend URL:
   ```javascript
   const allowedOrigins = [
     'https://galit-printing-frontend.onrender.com',
     'https://your-custom-domain.com',
     // ... other origins
   ];
   ```

2. **Update Environment Variable:**
   ```env
   FRONTEND_URL=https://galit-printing-frontend.onrender.com
   ```

#### Step 6: Database Migrations

1. **Automatic Migrations:**
   - Set `RUN_MIGRATIONS_ON_STARTUP=true` in backend environment
   - Migrations run automatically on server start

2. **Manual Migrations:**
   - Use Render Shell:
     ```bash
     cd backend
     npm run migrate
     ```

#### Step 7: Cloudinary Setup (File Storage)

**⚠️ IMPORTANT:** Render's filesystem is ephemeral - files uploaded to local filesystem will be lost. You **MUST** use Cloudinary for persistent file storage.

1. **Create Cloudinary Account:**
   - Go to [Cloudinary](https://cloudinary.com)
   - Sign up for free account
   - Get credentials from Dashboard

2. **Add to Render Environment:**
   ```env
   CLOUDINARY_URL=cloudinary://api_key:api_secret@cloud_name
   ```

3. **Verify:**
   - Check Render logs: `✅ Cloudinary storage configured`
   - Upload test file - should be stored in Cloudinary

### Deployment Workflow

**Automatic Deployment:**
1. Push code to GitHub
2. Render detects changes
3. Render builds new version
4. Render deploys automatically
5. Service restarts with new code

**Manual Deployment:**
1. Go to Render Dashboard
2. Select service
3. Click **"Manual Deploy"**
4. Select branch/commit
5. Click **"Deploy"**

### Render Configuration Files

**No special files needed** - Render auto-detects:
- `package.json` for Node.js projects
- Build and start commands from package.json
- Environment variables from dashboard

### Custom Domain Setup (Optional)

1. **In Render Dashboard:**
   - Go to your service
   - Click **"Settings"** → **"Custom Domain"**
   - Add your domain

2. **DNS Configuration:**
   - Add CNAME record pointing to Render
   - Wait for DNS propagation

3. **SSL Certificate:**
   - Render automatically provisions SSL
   - HTTPS enabled automatically

### Monitoring & Logs

**Render Logs:**
- View logs in Render Dashboard
- Real-time log streaming
- Log retention (varies by plan)

**Health Checks:**
- Backend health endpoint: `/health`
- Render monitors automatically
- Auto-restart on failure

### Cost

**Free Tier:**
- Web Service: Free (with limitations)
- PostgreSQL: Free (90 days, then paid)
- Static Site: Free

**Paid Plans:**
- Better performance
- No sleep (always on)
- More resources
- Better support

---

## 7. Technologies & Frameworks

### Backend Technologies

#### Core
- **Node.js** (v14+) - JavaScript runtime
- **Express.js** (^4.18.2) - Web framework
- **PostgreSQL** (v12+) - Relational database
- **pg** (^8.11.3) - PostgreSQL client

#### Authentication & Security
- **jsonwebtoken** (^9.0.2) - JWT authentication
- **bcryptjs** (^2.4.3) - Password hashing
- **helmet** (^7.1.0) - Security headers
- **express-validator** (^7.0.1) - Input validation
- **cors** (^2.8.5) - CORS middleware

#### Google Services
- **@google/generative-ai** (^0.24.1) - Gemini AI SDK
- **google-auth-library** (^10.5.0) - Google OAuth

#### File Handling
- **multer** (^2.0.2) - File upload middleware
- **cloudinary** (^1.41.3) - Cloud file storage
- **multer-storage-cloudinary** (^4.0.0) - Cloudinary integration

#### Utilities
- **dotenv** (^16.3.1) - Environment variables
- **moment** (^2.29.4) - Date/time manipulation
- **uuid** (^9.0.1) - Unique ID generation
- **xlsx** (^0.18.5) - Excel file handling
- **node-fetch** (^3.3.2) - HTTP client
- **nodemailer** (^6.10.1) - Email sending

#### Development
- **nodemon** (^3.0.2) - Auto-restart on changes
- **jest** (^29.7.0) - Testing framework

### Frontend Technologies

- **HTML5** - Structure and markup
- **CSS3** - Styling and design
- **Vanilla JavaScript (ES6+)** - Client-side logic
- **Chart.js** - Data visualization (charts)
- **Server-Sent Events (SSE)** - Real-time updates

### Database

- **PostgreSQL** - Relational database
- **UUID Extension** - For unique IDs
- **Triggers** - Automated database actions
- **Functions** - Stored procedures
- **Indexes** - Performance optimization

### External Services

- **Google Gemini AI** - AI-powered insights
- **Google OAuth** - Authentication
- **Cloudinary** - File storage
- **Render** - Hosting platform
- **GitHub** - Version control

### Architecture Patterns

- **RESTful API** - Resource-based endpoints
- **MVC-like Structure** - Separation of concerns
- **Middleware Pattern** - Request processing
- **JWT Authentication** - Stateless authentication
- **Server-Sent Events** - Real-time communication

---

## 8. Frontend Resources: Icons, Animations & Libraries

### Overview
Ang frontend ay gumagamit ng iba't-ibang external libraries, font icons, at CSS animations para sa modern at interactive user interface.

### Font Icons

#### Font Awesome
**Version:** 6.0.0 at 6.4.0  
**CDN:** `https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css`

**Usage:**
- Icons para sa navigation, buttons, at UI elements
- Status indicators (check, times, warning)
- Action icons (edit, delete, view, download)
- Feature icons (bell, user, cart, etc.)

**Common Icons Used:**
```html
<!-- Navigation & UI -->
<i class="fas fa-bell"></i>          <!-- Notifications -->
<i class="fas fa-user"></i>         <!-- User -->
<i class="fas fa-shopping-cart"></i> <!-- Orders -->
<i class="fas fa-boxes"></i>         <!-- Inventory -->
<i class="fas fa-chart-bar"></i>     <!-- Analytics -->

<!-- Actions -->
<i class="fas fa-edit"></i>         <!-- Edit -->
<i class="fas fa-trash"></i>        <!-- Delete -->
<i class="fas fa-eye"></i>          <!-- View -->
<i class="fas fa-download"></i>     <!-- Download -->
<i class="fas fa-check"></i>        <!-- Success -->
<i class="fas fa-times"></i>        <!-- Close/Error -->

<!-- Status -->
<i class="fas fa-check-circle"></i> <!-- Completed -->
<i class="fas fa-clock"></i>        <!-- Pending -->
<i class="fas fa-exclamation-triangle"></i> <!-- Warning -->
<i class="fas fa-spinner fa-spin"></i> <!-- Loading -->
```

**Implementation:**
- Loaded via CDN in HTML head
- Used throughout the application for visual consistency
- Supports both solid (`fas`) and regular (`far`) styles

### Google Fonts

#### Roboto Font Family
**CDN:** `https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap`

**Usage:**
- Primary font para sa customer login page
- Weights: 400 (regular), 500 (medium), 700 (bold)
- Modern, clean typography

**Implementation:**
```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">
```

**System Font Stack (Default):**
```css
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
```

### JavaScript Libraries

#### Chart.js
**Version:** 3.9.1  
**CDN:** `https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js`

**Usage:**
- Data visualization at analytics
- Revenue charts (bar, line)
- Order distribution (pie, doughnut)
- Performance metrics
- Predictive analytics

**Chart Types Used:**
- **Bar Charts** - Revenue performance, service performance
- **Line Charts** - Trends, time series data
- **Pie Charts** - Order distribution
- **Doughnut Charts** - Satisfaction metrics
- **Multi-dataset Charts** - Comparative analysis

**Implementation:**
```javascript
// Example: Revenue Bar Chart
const ctx = document.getElementById('revenueBarChart');
new Chart(ctx, {
  type: 'bar',
  data: {
    labels: ['Jan', 'Feb', 'Mar', ...],
    datasets: [{
      label: 'Revenue',
      data: [10000, 15000, 12000, ...],
      backgroundColor: '#3B82F6'
    }]
  },
  options: {
    responsive: true,
    plugins: {
      legend: { display: false }
    }
  }
});
```

**Charts in System:**
1. Revenue Bar Chart - Monthly revenue
2. Orders Pie Chart - Order distribution
3. Trends Line Chart - Time-based trends
4. Satisfaction Doughnut Chart - Customer satisfaction
5. Processing Time Chart - Order processing metrics
6. Revenue Performance Chart - Performance analysis
7. Top Service Performance Chart - Service rankings
8. Customer Behavior Chart - Customer analytics
9. Predictive Analytics Chart - Future predictions
10. Operational Efficiency Chart - Efficiency metrics

#### jsPDF
**Version:** 2.5.1  
**CDN:** `https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js`

**Usage:**
- Generate PDF reports
- Export order receipts
- Print invoices
- Download reports as PDF

**Implementation:**
```javascript
const { jsPDF } = window.jspdf;
const doc = new jsPDF();
doc.text('Report Title', 10, 10);
doc.save('report.pdf');
```

### CSS Animations

#### Keyframe Animations

**1. Spin Animation (Loading Spinner)**
```css
@keyframes spin {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* Usage */
.fa-spinner {
    animation: spin 1s linear infinite;
}
```

**2. Float Animation (Decorative Elements)**
```css
@keyframes float {
    0%, 100% { transform: translate(0, 0) rotate(0deg); }
    33% { transform: translate(30px, -30px) rotate(120deg); }
    66% { transform: translate(-20px, 20px) rotate(240deg); }
}

/* Usage */
.floating-element {
    animation: float 20s ease-in-out infinite;
}
```

**3. Slide Down Animation (Dropdowns)**
```css
@keyframes slideDown {
    from {
        opacity: 0;
        transform: translateY(-10px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Usage */
.dropdown {
    animation: slideDown 0.3s ease;
}
```

#### CSS Transitions

**Common Transitions Used:**
```css
/* Modal Animations */
.modal {
    transition: opacity 0.3s ease, visibility 0.3s ease;
}

.modal-content {
    transform: scale(0.95);
    transition: transform 0.3s ease;
}

.modal.show .modal-content {
    transform: scale(1);
}

/* Button Hover Effects */
.btn {
    transition: all 0.2s ease;
}

.btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
}

/* Sidebar Collapse */
.sidebar {
    transition: width 0.3s ease;
}

/* Color Transitions */
body {
    transition: background-color 0.3s ease, color 0.3s ease;
}

/* Input Focus */
input:focus {
    transition: border-color 0.3s ease, box-shadow 0.3s ease;
}
```

**Transition Properties:**
- **Duration:** 0.2s to 0.5s (typically 0.3s)
- **Timing Function:** `ease`, `ease-in-out`, `cubic-bezier(0.4, 0, 0.2, 1)`
- **Properties:** `all`, `transform`, `opacity`, `background-color`, `border-color`

### UI Animation Effects

#### 1. Modal Animations
- **Fade In/Out:** Opacity transition
- **Scale:** Transform scale from 0.95 to 1
- **Backdrop Blur:** Blur effect on background

#### 2. Button Interactions
- **Hover:** TranslateY(-2px) lift effect
- **Active:** Scale(1.05) press effect
- **Loading:** Spinner animation

#### 3. Sidebar Animations
- **Collapse/Expand:** Width transition (260px ↔ 72px)
- **Smooth:** 0.3s ease transition

#### 4. Card Animations
- **Hover:** Lift effect (translateY(-4px))
- **Scale:** Slight scale increase (scale(1.02))
- **Shadow:** Enhanced shadow on hover

#### 5. Form Animations
- **Input Focus:** Border color change
- **Validation:** Error shake (if implemented)
- **Success:** Checkmark animation

#### 6. Notification Animations
- **Slide In:** From right side
- **Fade Out:** Opacity transition
- **Auto-dismiss:** After timeout

#### 7. Table Row Animations
- **Hover:** Background color change
- **Selection:** Highlight effect
- **Loading:** Skeleton loading (if implemented)

### Backdrop Filters

**Blur Effect:**
```css
.modal {
    -webkit-backdrop-filter: blur(4px);
    backdrop-filter: blur(4px);
}
```

**Usage:**
- Modal overlays
- Dropdown menus
- Notification panels

### Transform Effects

**Common Transforms:**
```css
/* Translate */
transform: translateY(-2px);  /* Lift effect */
transform: translateX(-100%);  /* Slide out */

/* Scale */
transform: scale(1.05);       /* Zoom in */
transform: scale(0.95);       /* Zoom out */

/* Rotate */
transform: rotate(180deg);     /* Rotate icon */

/* Combined */
transform: translateY(-4px) scale(1.02);  /* Lift + zoom */
```

### Performance Optimizations

#### 1. requestAnimationFrame
```javascript
// Batch DOM updates
requestAnimationFrame(() => {
    // Update UI
    renderBoard();
});
```

**Usage:**
- Prevent flickering during updates
- Smooth animations
- Better performance

#### 2. CSS Will-Change
```css
.animated-element {
    will-change: transform, opacity;
}
```

**Usage:**
- Hint browser about upcoming changes
- Optimize animations

#### 3. Hardware Acceleration
```css
.animated {
    transform: translateZ(0);  /* Force GPU acceleration */
}
```

### Responsive Animations

**Media Queries:**
```css
@media (max-width: 768px) {
    .modal-content {
        transform: scale(0.98);  /* Smaller on mobile */
    }
}
```

### Animation Best Practices

1. **Performance:**
   - Use `transform` and `opacity` for animations (GPU accelerated)
   - Avoid animating `width`, `height`, `top`, `left`
   - Use `will-change` sparingly

2. **Accessibility:**
   - Respect `prefers-reduced-motion` media query
   - Provide alternative for motion-sensitive users

3. **Timing:**
   - Fast interactions: 0.2s
   - Medium transitions: 0.3s
   - Slow animations: 0.5s+

4. **Easing:**
   - Default: `ease`
   - Smooth: `ease-in-out`
   - Custom: `cubic-bezier(0.4, 0, 0.2, 1)`

### External CDN Resources Summary

| Resource | Version | Purpose | CDN URL |
|----------|---------|---------|---------|
| **Font Awesome** | 6.4.0 | Icons | `cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css` |
| **Chart.js** | 3.9.1 | Data Visualization | `cdnjs.cloudflare.com/ajax/libs/Chart.js/3.9.1/chart.min.js` |
| **jsPDF** | 2.5.1 | PDF Generation | `cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js` |
| **Google Fonts (Roboto)** | Latest | Typography | `fonts.googleapis.com/css2?family=Roboto` |
| **Google Sign-In** | Latest | OAuth | `accounts.google.com/gsi/client` |

### Custom CSS Features

#### CSS Variables (Custom Properties)
```css
:root {
    --primary-color: #3ba1f0;
    --secondary-color: #8B5CF6;
    --background-color: #FFFFFF;
    --text-primary: #182232;
    --success-color: #10B981;
    --warning-color: #F59E0B;
    --danger-color: #EF4444;
}
```

**Benefits:**
- Easy theming
- Consistent colors
- Easy to update

#### Modern CSS Features
- **Flexbox** - Layout
- **Grid** - Complex layouts
- **CSS Variables** - Theming
- **Backdrop Filter** - Blur effects
- **Custom Properties** - Dynamic styling

---

## 9. Project Structure

```
GalitDigitalPrintingFinal_3/
│
├── backend/                          # Backend API
│   ├── config/                      # Configuration
│   │   └── database.js              # Database connection
│   │
│   ├── middleware/                  # Express middleware
│   │   ├── auth.js                 # Authentication middleware
│   │   └── upload.js               # File upload middleware
│   │
│   ├── routes/                       # API routes
│   │   ├── ai.js                   # AI endpoints
│   │   ├── auth.js                 # Authentication endpoints
│   │   ├── customers.js            # Customer endpoints
│   │   ├── inventory.js            # Inventory endpoints
│   │   ├── jobOrders.js            # Job order endpoints
│   │   ├── notifications.js        # Notification endpoints
│   │   ├── reports.js              # Report endpoints
│   │   ├── salesTransactions.js    # Sales endpoints
│   │   ├── services.js             # Service endpoints
│   │   ├── staff.js                # Staff endpoints
│   │   └── tasks.js                # Task endpoints
│   │
│   ├── services/                     # Business logic services
│   │   ├── emailService.js         # Email service
│   │   └── notify.js               # Notification service
│   │
│   ├── sql/                          # Database files
│   │   ├── migrations/             # Database migrations
│   │   ├── schema.sql              # Main schema
│   │   ├── tables.sql              # Table definitions
│   │   ├── functions.sql           # Database functions
│   │   ├── triggers.sql            # Database triggers
│   │   └── indexes.sql             # Database indexes
│   │
│   ├── utils/                        # Utility functions
│   │   └── taskAutomation.js       # Task automation logic
│   │
│   ├── uploads/                      # File uploads (local dev only)
│   │
│   ├── server.js                    # Main server file
│   ├── package.json                 # Backend dependencies
│   ├── run-migrations.js            # Migration runner
│   └── README.md                    # Backend documentation
│
├── frontend/                         # Frontend Application
│   ├── assets/                      # Static assets
│   │   └── logo.jpg                # Logo image
│   │
│   ├── components/                  # Reusable components
│   │   └── sidebar.html            # Sidebar component
│   │
│   ├── index.html                   # Admin dashboard
│   ├── clerk.html                   # Clerk dashboard
│   ├── customer.html                # Customer portal
│   ├── customer_login.html          # Customer login page
│   ├── login.html                   # Admin/Clerk login
│   │
│   ├── script.js                    # Main JavaScript (16,873 lines)
│   ├── styles.css                   # Main stylesheet
│   ├── config.js                    # Configuration (API URLs, OAuth)
│   ├── session-timeout.js           # Session timeout manager
│   ├── ai-insights.js               # AI insights functionality
│   ├── override.js                  # Configuration overrides
│   └── _redirects                   # Render redirects
│
├── README.md                         # Main documentation
├── SYSTEM_REVIEWER.md                # This file
├── AUTOMATION_EXPLANATION.md         # Task automation docs
└── package.json                      # Root package.json
```

### Key Files

**Backend:**
- `backend/server.js` - Main Express server
- `backend/config/database.js` - Database connection pool
- `backend/middleware/auth.js` - Authentication middleware
- `backend/routes/*.js` - API route handlers
- `backend/utils/taskAutomation.js` - Task automation logic
- `backend/sql/schema.sql` - Database schema

**Frontend:**
- `frontend/index.html` - Admin dashboard
- `frontend/clerk.html` - Clerk dashboard
- `frontend/customer.html` - Customer portal
- `frontend/script.js` - Main JavaScript (all functionality)
- `frontend/config.js` - API configuration
- `frontend/session-timeout.js` - Session management

---

## 10. System Features

### For Admins

#### Dashboard
- Business metrics overview
- Revenue charts and graphs
- Order statistics
- Customer analytics
- Service performance
- Real-time updates

#### Job Order Management
- Create, view, edit orders
- Order status tracking
- Priority management
- Order search and filters
- Bulk operations
- Order history

#### Customer Management
- Customer database
- Customer profiles
- Order history per customer
- Customer search
- Customer communication

#### Inventory Management
- Stock tracking
- Material management
- Low stock alerts
- Inventory transactions
- Stock reports

#### Staff Management
- Staff accounts
- Role assignment
- Workload tracking
- Task assignment
- Staff performance

#### Task Management
- Automated task creation
- Task assignment
- Task status tracking
- Kanban board view
- Task automation

#### Analytics & Reporting
- Sales reports
- Revenue analysis
- Service performance
- Customer behavior
- AI-powered insights
- Export to Excel

#### Services Management
- Service catalog
- Service categories
- Pricing management
- Service availability

### For Clerks

#### Order Creation
- Quick order entry
- Customer lookup
- Service selection
- Price calculation
- File uploads

#### Order Management
- View orders
- Update order status
- Add notes
- Print receipts

#### Customer Lookup
- Search customers
- View customer details
- Order history

#### Basic Reports
- Daily summaries
- Order statistics
- Sales overview

### For Customers

#### Order Tracking
- Real-time order status
- Order details
- Progress updates
- Estimated completion

#### Order History
- Past orders
- Order receipts
- Reorder functionality

#### Account Management
- Profile management
- Password change
- Account settings

#### Support
- Contact information
- Order inquiries
- Support requests

### System-Wide Features

#### Real-time Updates
- Server-Sent Events (SSE)
- Live notifications
- Order status updates
- Task assignments

#### Task Automation
- Automatic task creation
- Role-based assignment
- Intelligent service matching
- Workload balancing

#### File Management
- File uploads
- Cloud storage (Cloudinary)
- Image preview
- File downloads

#### Security
- JWT authentication
- Password hashing
- Session management
- Role-based access
- Input validation
- CORS protection

#### Notifications
- Real-time notifications
- Email notifications
- In-app notifications
- Notification history

---

## 11. Configuration & Environment Variables

### Backend Environment Variables

**Required Variables:**
```env
# Database Configuration
DB_HOST=localhost                    # or Render PostgreSQL host
DB_PORT=5432
DB_NAME=galit_digital_printing
DB_USER=postgres                     # or Render DB user
DB_PASSWORD=your_password            # or Render DB password

# Server Configuration
PORT=3000                            # or 10000 for Render
NODE_ENV=production                 # or development

# JWT Configuration
JWT_SECRET=your_super_secret_key    # Must be strong and random
JWT_EXPIRES_IN=24h                  # Token expiration

# Frontend URL (for CORS)
FRONTEND_URL=http://localhost:5500  # or production URL

# Google OAuth
GOOGLE_CLIENT_ID=your_client_id.apps.googleusercontent.com

# Gemini AI
GEMINI_API_KEY=your_gemini_api_key

# Cloudinary (Required for production)
CLOUDINARY_URL=cloudinary://api_key:api_secret@cloud_name
# OR separate variables:
CLOUDINARY_CLOUD_NAME=your_cloud_name
CLOUDINARY_API_KEY=your_api_key
CLOUDINARY_API_SECRET=your_api_secret

# Migrations
RUN_MIGRATIONS_ON_STARTUP=true      # Auto-run migrations on startup
```

**Optional Variables:**
```env
# Secondary Port (for local development)
SECONDARY_PORT=3001

# Auto-assign Interval
AUTO_ASSIGN_INTERVAL_MS=30000       # 30 seconds

# Custom Domain
CUSTOM_DOMAIN=https://yourdomain.com
```

### Frontend Configuration

**File:** `frontend/config.js`

```javascript
// Google OAuth Client ID
window.GOOGLE_CLIENT_ID = 'your_client_id.apps.googleusercontent.com';

// API Configuration (Auto-detects environment)
const isLocalhost = window.location.hostname === 'localhost' || 
                    window.location.hostname === '127.0.0.1';

if (isLocalhost) {
    // Local Development
    window.API_ORIGIN = 'http://localhost:3001';
    window.API_BASE = window.API_ORIGIN + '/api';
} else {
    // Production (Render)
    window.API_ORIGIN = 'https://galit-printing-backend.onrender.com';
    window.API_BASE = window.API_ORIGIN + '/api';
}
```

### Database Configuration

**Connection Pool Settings:**
```javascript
// backend/config/database.js
{
  max: 20,                    // Maximum connections
  idleTimeoutMillis: 30000,   // Idle timeout
  connectionTimeoutMillis: 2000  // Connection timeout
}
```

### Security Configuration

**JWT Settings:**
- Secret: Strong random string (minimum 32 characters)
- Expiration: 24h for admin/clerk, 7d for customers
- Algorithm: HS256 (default)

**Password Requirements:**
- Minimum 8 characters
- At least 1 uppercase letter
- At least 1 lowercase letter
- At least 1 number
- At least 1 special character (!@#$%)

**CORS Settings:**
- Allowed origins: Configured in `backend/server.js`
- Credentials: Enabled
- Methods: GET, POST, PUT, DELETE, OPTIONS

---

## Summary

### System Overview
- **Type:** Business Management System for Digital Printing
- **Architecture:** RESTful API with Static Frontend
- **Deployment:** Render (Backend + Database + Frontend)
- **Version Control:** GitHub

### Key Integrations
- **AI:** Google Gemini 2.5 Flash
- **Authentication:** Google OAuth 2.0
- **File Storage:** Cloudinary
- **Email:** Nodemailer

### Session Management
- **Customer:** 1 hour inactivity, 7 days JWT
- **Admin:** 5 hours inactivity, 24 hours JWT
- **Clerk:** 12 hours inactivity, 24 hours JWT

### Technologies
- **Backend:** Node.js + Express.js + PostgreSQL
- **Frontend:** HTML5 + CSS3 + Vanilla JavaScript
- **Authentication:** JWT + bcryptjs
- **Security:** Helmet + CORS + express-validator

### Deployment
- **Platform:** Render
- **Backend:** Web Service
- **Database:** PostgreSQL Service
- **Frontend:** Static Site
- **CI/CD:** Automatic via GitHub

---

**Note:** Lahat ng API keys, credentials, at sensitive information ay dapat naka-store sa environment variables at hindi dapat i-commit sa version control (Git). Always use `.env` file for local development at Render Environment Variables para sa production.

---

**Document Version:** 1.0  
**Last Updated:** 2024  
**System Version:** 1.0.0
