# YOUTH GOVERNANCE APP - PROJECT STRUCTURE SETUP GUIDE

## Complete Project Structure

```
youth-governance-web/
├── frontend/                          # React.js Frontend Application
│   ├── public/
│   │   ├── index.html
│   │   ├── favicon.ico
│   │   ├── manifest.json
│   │   └── robots.txt
│   ├── src/
│   │   ├── components/
│   │   │   ├── common/
│   │   │   │   ├── Header.jsx
│   │   │   │   ├── Sidebar.jsx
│   │   │   │   ├── Footer.jsx
│   │   │   │   ├── Loading.jsx
│   │   │   │   ├── ErrorBoundary.jsx
│   │   │   │   ├── ProtectedRoute.jsx
│   │   │   │   └── Navigation.jsx
│   │   │   ├── forms/
│   │   │   │   ├── LoginForm.jsx
│   │   │   │   ├── RegisterForm.jsx
│   │   │   │   ├── SurveyForm.jsx
│   │   │   │   ├── UserForm.jsx
│   │   │   │   └── ProgramForm.jsx
│   │   │   ├── dashboard/
│   │   │   │   ├── AdminDashboard.jsx
│   │   │   │   ├── StaffDashboard.jsx
│   │   │   │   ├── SKDashboard.jsx
│   │   │   │   └── PublicDashboard.jsx
│   │   │   ├── recommendations/
│   │   │   │   ├── RecommendationCard.jsx
│   │   │   │   ├── RecommendationList.jsx
│   │   │   │   ├── RecommendationFilters.jsx
│   │   │   │   └── RecommendationAnalytics.jsx
│   │   │   ├── surveys/
│   │   │   │   ├── SurveyCard.jsx
│   │   │   │   ├── SurveyList.jsx
│   │   │   │   ├── SurveyBuilder.jsx
│   │   │   │   └── SurveyAnalytics.jsx
│   │   │   ├── charts/
│   │   │   │   ├── ResponseChart.jsx
│   │   │   │   ├── AnalyticsChart.jsx
│   │   │   │   ├── RecommendationChart.jsx
│   │   │   │   └── EmailChart.jsx
│   │   │   └── email/
│   │   │       ├── EmailTemplateEditor.jsx
│   │   │       ├── EmailLogs.jsx
│   │   │       └── EmailAnalytics.jsx
│   │   ├── pages/
│   │   │   ├── public/
│   │   │   │   ├── Home.jsx
│   │   │   │   ├── About.jsx
│   │   │   │   ├── Login.jsx
│   │   │   │   ├── Register.jsx
│   │   │   │   ├── Survey.jsx
│   │   │   │   ├── Recommendations.jsx
│   │   │   │   └── Contact.jsx
│   │   │   ├── admin/
│   │   │   │   ├── Dashboard.jsx
│   │   │   │   ├── Users.jsx
│   │   │   │   ├── Surveys.jsx
│   │   │   │   ├── Programs.jsx
│   │   │   │   ├── Recommendations.jsx
│   │   │   │   ├── EmailTemplates.jsx
│   │   │   │   ├── Reports.jsx
│   │   │   │   └── Settings.jsx
│   │   │   ├── staff/
│   │   │   │   ├── Dashboard.jsx
│   │   │   │   ├── Responses.jsx
│   │   │   │   ├── Analytics.jsx
│   │   │   │   ├── Recommendations.jsx
│   │   │   │   └── Reports.jsx
│   │   │   └── sk/
│   │   │       ├── Dashboard.jsx
│   │   │       ├── Validation.jsx
│   │   │       ├── Reports.jsx
│   │   │       └── Profile.jsx
│   │   ├── hooks/
│   │   │   ├── useAuth.js
│   │   │   ├── useApi.js
│   │   │   ├── useRecommendations.js
│   │   │   ├── useLocalStorage.js
│   │   │   └── useEmail.js
│   │   ├── services/
│   │   │   ├── api.js
│   │   │   ├── auth.js
│   │   │   ├── recommendations.js
│   │   │   ├── email.js
│   │   │   └── storage.js
│   │   ├── store/
│   │   │   ├── index.js
│   │   │   ├── authSlice.js
│   │   │   ├── surveySlice.js
│   │   │   ├── recommendationSlice.js
│   │   │   └── emailSlice.js
│   │   ├── utils/
│   │   │   ├── constants.js
│   │   │   ├── helpers.js
│   │   │   ├── validation.js
│   │   │   ├── recommendationAlgorithms.js
│   │   │   └── emailTemplates.js
│   │   ├── styles/
│   │   │   ├── theme.js
│   │   │   ├── global.css
│   │   │   └── components.css
│   │   ├── App.jsx         
│   │   ├── index.jsx
│   │   └── main.jsx
│   ├── package.json
│   ├── vite.config.js
│   ├── .env.example
│   ├── .env
│   ├── .gitignore
│   └── README.md
├── backend/                           # Node.js Backend Application
│   ├── src/
│   │   ├── controllers/
│   │   │   ├── authController.js
│   │   │   ├── userController.js
│   │   │   ├── surveyController.js
│   │   │   ├── responseController.js
│   │   │   ├── programController.js
│   │   │   ├── recommendationController.js
│   │   │   ├── emailController.js
│   │   │   ├── analyticsController.js
│   │   │   └── skController.js
│   │   ├── models/
│   │   │   ├── User.js
│   │   │   ├── SurveyBatch.js
│   │   │   ├── SurveyResponse.js
│   │   │   ├── Program.js
│   │   │   ├── Recommendation.js
│   │   │   ├── EmailTemplate.js
│   │   │   ├── EmailLog.js
│   │   │   ├── SKTerm.js
│   │   │   ├── SKOfficial.js
│   │   │   ├── ActivityLog.js
│   │   │   ├── ValidationLog.js
│   │   │   └── AnalyticsData.js
│   │   ├── routes/
│   │   │   ├── auth.js
│   │   │   ├── users.js
│   │   │   ├── surveys.js
│   │   │   ├── responses.js
│   │   │   ├── programs.js
│   │   │   ├── recommendations.js
│   │   │   ├── emails.js
│   │   │   ├── analytics.js
│   │   │   ├── sk.js
│   │   │   └── index.js
│   │   ├── middleware/
│   │   │   ├── auth.js
│   │   │   ├── validation.js
│   │   │   ├── rateLimit.js
│   │   │   ├── errorHandler.js
│   │   │   ├── cors.js
│   │   │   └── logger.js
│   │   ├── services/
│   │   │   ├── recommendationService.js
│   │   │   ├── emailService.js
│   │   │   ├── analyticsService.js
│   │   │   ├── exportService.js
│   │   │   └── notificationService.js
│   │   ├── utils/
│   │   │   ├── database.js
│   │   │   ├── jwt.js
│   │   │   ├── bcrypt.js
│   │   │   ├── validation.js
│   │   │   ├── recommendationAlgorithms.js
│   │   │   ├── emailTemplates.js
│   │   │   └── helpers.js
│   │   ├── config/
│   │   │   ├── database.js
│   │   │   ├── email.js
│   │   │   ├── recommendation.js
│   │   │   └── app.js
│   │   └── app.js
│   ├── package.json
│   ├── server.js
│   ├── .env.example
│   ├── .env
│   ├── .gitignore
│   └── README.md
├── database/                          # Database Scripts and Migrations
│   ├── migrations/
│   │   ├── 001_create_users_table.sql
│   │   ├── 002_create_survey_batches_table.sql
│   │   ├── 003_create_survey_responses_table.sql
│   │   ├── 004_create_programs_table.sql
│   │   ├── 005_create_recommendations_table.sql
│   │   ├── 006_create_email_templates_table.sql
│   │   ├── 007_create_email_logs_table.sql
│   │   ├── 008_create_sk_terms_table.sql
│   │   ├── 009_create_sk_officials_table.sql
│   │   ├── 010_create_activity_logs_table.sql
│   │   ├── 011_create_validation_logs_table.sql
│   │   └── 012_create_analytics_data_table.sql
│   ├── seeds/
│   │   ├── 001_seed_users.sql
│   │   ├── 002_seed_programs.sql
│   │   ├── 003_seed_email_templates.sql
│   │   └── 004_seed_sk_terms.sql
│   ├── schema.sql
│   └── setup.sql
├── docs/                              # Documentation
│   ├── Final_Capstone_Specification.md
│   ├── Deployment_Guide.md
│   ├── API_Documentation.md
│   ├── Database_Documentation.md
│   └── User_Manual.md
├── docker/                            # Docker Configuration
│   ├── docker-compose.yml
│   ├── Dockerfile.frontend
│   ├── Dockerfile.backend
│   └── nginx.conf
├── scripts/                           # Utility Scripts
│   ├── setup.sh
│   ├── deploy.sh
│   ├── backup.sh
│   └── migrate.sh
├── .gitignore
├── README.md
└── package.json
```

## Setup Instructions

### Step 1: Create Main Project Directory
```bash
mkdir youth-governance-web
cd youth-governance-web
```

### Step 2: Create Frontend Structure
```bash
# Create frontend directory
mkdir -p frontend/public
mkdir -p frontend/src/components/{common,forms,dashboard,recommendations,surveys,charts,email}
mkdir -p frontend/src/pages/{public,admin,staff,sk}
mkdir -p frontend/src/hooks
mkdir -p frontend/src/services
mkdir -p frontend/src/store
mkdir -p frontend/src/utils
mkdir -p frontend/src/styles
```

### Step 3: Create Backend Structure
```bash
# Create backend directory
mkdir -p backend/src/{controllers,models,routes,middleware,services,utils,config}
```

### Step 4: Create Database Structure
```bash
# Create database directory
mkdir -p database/{migrations,seeds}
```

### Step 5: Create Documentation Structure
```bash
# Create docs directory
mkdir docs
```

### Step 6: Create Docker Structure
```bash
# Create docker directory
mkdir docker
```

### Step 7: Create Scripts Structure
```bash
# Create scripts directory
mkdir scripts
```

## Package.json Files

### Root package.json
```json
{
  "name": "youth-governance-web",
  "version": "1.0.0",
  "description": "Youth Governance App - Web-Based Survey and Recommendation System",
  "scripts": {
    "dev": "concurrently \"npm run dev:backend\" \"npm run dev:frontend\"",
    "dev:frontend": "cd frontend && npm run dev",
    "dev:backend": "cd backend && npm run dev",
    "build": "npm run build:frontend && npm run build:backend",
    "build:frontend": "cd frontend && npm run build",
    "build:backend": "cd backend && npm run build",
    "install:all": "npm install && cd frontend && npm install && cd ../backend && npm install",
    "setup": "npm run install:all && npm run migrate && npm run seed",
    "migrate": "cd backend && npm run migrate",
    "seed": "cd backend && npm run seed",
    "test": "npm run test:frontend && npm run test:backend",
    "test:frontend": "cd frontend && npm test",
    "test:backend": "cd backend && npm test"
  },
  "keywords": [
    "youth-governance",
    "survey",
    "recommendation-system",
    "react",
    "nodejs",
    "mysql"
  ],
  "author": "Your Name",
  "license": "MIT",
  "devDependencies": {
    "concurrently": "^8.2.2"
  }
}
```

### Frontend package.json
```json
{
  "name": "youth-governance-frontend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build",
    "preview": "vite preview",
    "test": "vitest",
    "lint": "eslint . --ext js,jsx --report-unused-disable-directives --max-warnings 0"
  },
  "dependencies": {
    "react": "^18.2.0",
    "react-dom": "^18.2.0",
    "react-router-dom": "^6.20.1",
    "@reduxjs/toolkit": "^1.9.7",
    "react-redux": "^8.1.3",
    "@mui/material": "^5.14.18",
    "@mui/icons-material": "^5.14.18",
    "@emotion/react": "^11.11.1",
    "@emotion/styled": "^11.11.0",
    "axios": "^1.6.2",
    "react-hook-form": "^7.48.2",
    "react-query": "^3.39.3",
    "chart.js": "^4.4.0",
    "react-chartjs-2": "^5.2.0",
    "emailjs-com": "^3.2.0",
    "date-fns": "^2.30.0",
    "react-hot-toast": "^2.4.1"
  },
  "devDependencies": {
    "@types/react": "^18.2.37",
    "@types/react-dom": "^18.2.15",
    "@vitejs/plugin-react": "^4.1.1",
    "eslint": "^8.53.0",
    "eslint-plugin-react": "^7.33.2",
    "eslint-plugin-react-hooks": "^4.6.0",
    "eslint-plugin-react-refresh": "^0.4.4",
    "vite": "^4.5.0",
    "vitest": "^0.34.6"
  }
}
```

### Backend package.json
```json
{
  "name": "youth-governance-backend",
  "version": "1.0.0",
  "description": "Youth Governance App Backend API",
  "main": "server.js",
  "scripts": {
    "start": "node server.js",
    "dev": "nodemon server.js",
    "build": "echo 'No build step required'",
    "test": "jest",
    "migrate": "node src/utils/migrate.js",
    "seed": "node src/utils/seed.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "mysql2": "^3.6.5",
    "sequelize": "^6.35.1",
    "jsonwebtoken": "^9.0.2",
    "bcryptjs": "^2.4.3",
    "cors": "^2.8.5",
    "helmet": "^7.1.0",
    "express-rate-limit": "^7.1.5",
    "express-validator": "^7.0.1",
    "multer": "^1.4.5-lts.1",
    "nodemailer": "^6.9.7",
    "handlebars": "^4.7.8",
    "bull": "^4.12.0",
    "redis": "^4.6.11",
    "socket.io": "^4.7.4",
    "moment": "^2.29.4",
    "xlsx": "^0.18.5",
    "compression": "^1.7.4",
    "morgan": "^1.10.0",
    "dotenv": "^16.3.1"
  },
  "devDependencies": {
    "nodemon": "^3.0.1",
    "jest": "^29.7.0",
    "supertest": "^6.3.3"
  }
}
```

## Environment Files

### Frontend .env.example
```env
VITE_API_URL=http://localhost:5000/api
VITE_APP_NAME=Youth Governance App
VITE_EMAIL_SERVICE=emailjs
VITE_EMAIL_USER_ID=your-emailjs-user-id
VITE_EMAIL_TEMPLATE_ID=your-emailjs-template-id
```

### Backend .env.example
```env
NODE_ENV=development
PORT=5000

# Database Configuration
DB_HOST=localhost
DB_PORT=3306
DB_NAME=youth_governance
DB_USER=root
DB_PASSWORD=password

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-here
JWT_EXPIRES_IN=24h

# Email Configuration
EMAIL_SERVICE=gmail
EMAIL_USER=your-email@gmail.com
EMAIL_PASSWORD=your-app-password
EMAIL_FROM=Youth Governance App <noreply@youthgovernance.com>

# Redis Configuration (for email queue)
REDIS_HOST=localhost
REDIS_PORT=6379

# Recommendation System
RECOMMENDATION_ALGORITHM=hybrid
MIN_RECOMMENDATION_SCORE=0.3
MAX_RECOMMENDATIONS_PER_USER=5

# CORS Configuration
CORS_ORIGIN=http://localhost:3000

# Rate Limiting
RATE_LIMIT_WINDOW=15m
RATE_LIMIT_MAX=100
```

## Next Steps After Creating Structure

1. **Initialize Frontend**: `cd frontend && npm create vite@latest . -- --template react`
2. **Initialize Backend**: `cd backend && npm init -y`
3. **Install Dependencies**: Run `npm run install:all` from root
4. **Set up Database**: Configure MySQL and run migrations
5. **Configure Environment**: Copy .env.example files and update with your values
6. **Start Development**: Run `npm run dev` from root

This structure provides a complete foundation for your Youth Governance App web version with all the necessary components for the recommendation system and email functionality. 