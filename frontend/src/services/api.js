import axios from 'axios';

// Create axios instance with base configuration
const api = axios.create({
  baseURL: 'http://localhost:3001',
  timeout: 10000,
  headers: {
    'Content-Type': 'application/json',
  },
});

// Request interceptor to add auth token
api.interceptors.request.use(
  (config) => {
    const token = localStorage.getItem('token');
    if (token) {
      config.headers.Authorization = `Bearer ${token}`;
    }
    return config;
  },
  (error) => {
    return Promise.reject(error);
  }
);

// Response interceptor to handle errors
api.interceptors.response.use(
  (response) => response,
  (error) => {
    if (error.response?.status === 401) {
      // Handle unauthorized access
      localStorage.removeItem('token');
      window.location.href = '/login';
    }
    return Promise.reject(error);
  }
);

// API endpoints
export const authAPI = {
  login: (credentials) => api.post('/auth/login', credentials),
  register: (userData) => api.post('/auth/register', userData),
  logout: () => api.post('/auth/logout'),
  refreshToken: () => api.post('/auth/refresh'),
};

export const userAPI = {
  getProfile: () => api.get('/users/profile'),
  updateProfile: (data) => api.put('/users/profile', data),
  getUsers: () => api.get('/users'),
  getUserById: (id) => api.get(`/users/${id}`),
};

export const surveyAPI = {
  getSurveys: () => api.get('/surveys'),
  getSurveyById: (id) => api.get(`/surveys/${id}`),
  createSurvey: (data) => api.post('/surveys', data),
  updateSurvey: (id, data) => api.put(`/surveys/${id}`, data),
  deleteSurvey: (id) => api.delete(`/surveys/${id}`),
  submitResponse: (surveyId, responses) => api.post(`/surveys/${surveyId}/responses`, responses),
};

export const recommendationAPI = {
  getRecommendations: () => api.get('/recommendations'),
  getRecommendationById: (id) => api.get(`/recommendations/${id}`),
  createRecommendation: (data) => api.post('/recommendations', data),
  updateRecommendation: (id, data) => api.put(`/recommendations/${id}`, data),
  deleteRecommendation: (id) => api.delete(`/recommendations/${id}`),
};

export const analyticsAPI = {
  getDashboardStats: () => api.get('/analytics/dashboard'),
  getSurveyAnalytics: (surveyId) => api.get(`/analytics/surveys/${surveyId}`),
  getRecommendationAnalytics: () => api.get('/analytics/recommendations'),
  getEmailAnalytics: () => api.get('/analytics/emails'),
};

export default api; 