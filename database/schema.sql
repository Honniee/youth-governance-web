-- YOUTH GOVERNANCE APP DATABASE SCHEMA
-- Complete permission system with Roles table

-- 1. BARANGAY TABLE
CREATE TABLE Barangay (
    barangay_id VARCHAR(20) PRIMARY KEY, -- e.g., 'SJB001', 'SJB002'
    barangay_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_barangay_name (barangay_name)
);

-- 2. ROLES TABLE
CREATE TABLE Roles (
    role_id VARCHAR(20) PRIMARY KEY, -- e.g., 'ROL001', 'ROL002'
    role_name VARCHAR(50) NOT NULL UNIQUE,
    role_description TEXT,
    permissions JSON, -- Store permissions as JSON
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_role_name (role_name),
    INDEX idx_active (is_active)
);

-- 3. LYDO TABLE (Admin and LYDO Staff)
CREATE TABLE LYDO (
    lydo_id VARCHAR(20) PRIMARY KEY, -- e.g., 'LYDO001', 'LYDO002'
    role_id VARCHAR(20) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    personal_email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    suffix VARCHAR(50),
    profile_picture VARCHAR(255), -- File path to profile picture
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    created_by VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    deactivated BOOLEAN DEFAULT FALSE,
    deactivated_at TIMESTAMP NULL,
    FOREIGN KEY (role_id) REFERENCES Roles(role_id) ON DELETE RESTRICT,
    FOREIGN KEY (created_by) REFERENCES LYDO(lydo_id) ON DELETE RESTRICT,  -- LYDO SELF-REFERENCE
    INDEX idx_email (email),
    INDEX idx_role_id (role_id),
    INDEX idx_active (is_active),
    INDEX idx_created_by (created_by)
);

-- 4. SK_TERMS TABLE (New table for term management)
CREATE TABLE SK_Terms (
    term_id VARCHAR(20) PRIMARY KEY, -- e.g., 'TRM001', 'TRM002'
    term_name VARCHAR(100) NOT NULL, -- e.g., '2023-2025 Term', '2025-2027 Term'
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('active', 'completed', 'upcoming') DEFAULT 'upcoming',
    is_active BOOLEAN DEFAULT TRUE,
    is_current BOOLEAN DEFAULT FALSE,
    created_by VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    statistics_total_officials INTEGER DEFAULT 0,
    statistics_active_officials INTEGER DEFAULT 0,
    statistics_inactive_officials INTEGER DEFAULT 0,
    statistics_total_sk_chairperson INTEGER DEFAULT 0,
    statistics_total_sk_secretary INTEGER DEFAULT 0,
    statistics_total_sk_treasurer INTEGER DEFAULT 0,
    statistics_total_sk_councilor INTEGER DEFAULT 0,
    FOREIGN KEY (created_by) REFERENCES LYDO(lydo_id) ON DELETE RESTRICT,
    INDEX idx_term_name (term_name),
    INDEX idx_dates (start_date, end_date),
    INDEX idx_status (status),
    INDEX idx_active (is_active)
);

-- 5. SK_OFFICIALS TABLE
CREATE TABLE SK_Officials (
    sk_id VARCHAR(20) PRIMARY KEY, -- e.g., 'SK001', 'SK002'
    role_id VARCHAR(20) NOT NULL,
    term_id VARCHAR(20) NOT NULL, -- NEW: Link to specific term
    email VARCHAR(100) UNIQUE NOT NULL,
    personal_email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    barangay_id VARCHAR(20) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    suffix VARCHAR(50),
    position ENUM('SK Chairperson', 'SK Secretary', 'SK Treasurer', 'SK Councilor') NOT NULL,
    profile_picture VARCHAR(255), -- File path to profile picture
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    created_by VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (role_id) REFERENCES Roles(role_id) ON DELETE RESTRICT,
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id) ON DELETE RESTRICT,
    FOREIGN KEY (term_id) REFERENCES SK_Terms(term_id) ON DELETE RESTRICT, -- NEW
    FOREIGN KEY (created_by) REFERENCES LYDO(lydo_id) ON DELETE RESTRICT,
    INDEX idx_full_name (last_name, first_name, middle_name, suffix),
    INDEX idx_email (email),
    INDEX idx_role_id (role_id),
    INDEX idx_barangay_id (barangay_id),
    INDEX idx_term_id (term_id), -- NEW
    INDEX idx_active (is_active)
);

-- 6. SK_OFFICIALS_PROFILING TABLE
CREATE TABLE SK_Officials_Profiling (
    profiling_id VARCHAR(20) PRIMARY KEY, -- e.g., 'PRO001', 'PRO002'
    sk_id VARCHAR(20) NOT NULL,
    birth_date DATE NOT NULL,
    age INTEGER NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    contact_number VARCHAR(20) UNIQUE NOT NULL,
    school_or_company VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    performance_metrics_survey_validated INTEGER DEFAULT 0,
    FOREIGN KEY (sk_id) REFERENCES SK_Officials(sk_id) ON DELETE CASCADE,
    INDEX idx_sk_id (sk_id)
);

-- 7. YOUTH_PROFILING TABLE
CREATE TABLE Youth_Profiling (
    youth_id VARCHAR(20) PRIMARY KEY, -- e.g., 'YTH001', 'YTH002'
    
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    suffix VARCHAR(50),
    region VARCHAR(50) NOT NULL DEFAULT 'Region IV-A (CALABARZON)',
    province VARCHAR(50) NOT NULL DEFAULT 'Batangas',
    municipality VARCHAR(50) NOT NULL DEFAULT 'San Jose',
    barangay_id VARCHAR(20) NOT NULL,
    purok_zone VARCHAR(50),
    birth_date DATE NOT NULL,
    age INTEGER NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    contact_number VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id) ON DELETE RESTRICT,
    INDEX idx_barangay_id (barangay_id),
    INDEX idx_age (age),
    INDEX idx_active (is_active)
);

-- 8. USERS TABLE (for tracking all users)
CREATE TABLE Users (
    user_id VARCHAR(20) PRIMARY KEY, -- e.g., 'USR001', 'USR002'
    user_type ENUM('admin', 'lydo_staff', 'sk_official', 'youth') NOT NULL,
    lydo_id VARCHAR(20) NULL,
    sk_id VARCHAR(20) NULL,
    youth_id VARCHAR(20) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (lydo_id) REFERENCES LYDO(lydo_id) ON DELETE CASCADE,
    FOREIGN KEY (sk_id) REFERENCES SK_Officials(sk_id) ON DELETE CASCADE,
    FOREIGN KEY (youth_id) REFERENCES Youth_Profiling(youth_id) ON DELETE CASCADE,
    INDEX idx_user_type (user_type),
    INDEX idx_lydo_id (lydo_id),
    INDEX idx_sk_id (sk_id),
    INDEX idx_youth_id (youth_id)
);

-- 9. VOTERS_LIST TABLE
CREATE TABLE Voters_List (
    voter_id VARCHAR(20) PRIMARY KEY, -- e.g., 'VOT001', 'VOT002'
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    suffix VARCHAR(50),
    birth_date DATE NOT NULL,
    gender ENUM('Male', 'Female'),
    created_by VARCHAR(20) NOT NULL,
    FOREIGN KEY (created_by) REFERENCES LYDO(lydo_id) ON DELETE RESTRICT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_name (first_name, last_name)      
);

-- 10. KK_SURVEY_BATCHES TABLE
CREATE TABLE KK_Survey_Batches (
    batch_id VARCHAR(20) PRIMARY KEY, -- e.g., 'BAT001', 'BAT002'
    batch_name VARCHAR(100) NOT NULL, -- e.g., 'KK Survey 2024 Q1', 'KK Survey 2024 Q2', 'KK Survey 2025 Q1', 'KK Survey 2025 Q2', 'KK Survey 2026 Q1', 'KK Survey 2026 Q2'
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status ENUM('active', 'closed', 'draft') DEFAULT 'draft',
    target_age_min INTEGER DEFAULT 15,
    target_age_max INTEGER DEFAULT 30,
    created_by VARCHAR(20) NOT NULL, -- LYDO ID
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    statistics_total_responses INTEGER DEFAULT 0,
    statistics_validated_responses INTEGER DEFAULT 0,
    statistics_rejected_responses INTEGER DEFAULT 0,
    statistics_pending_responses INTEGER DEFAULT 0,
    statistics_total_youths INTEGER DEFAULT 0,
    statistics_total_youths_surveyed INTEGER DEFAULT 0,
    statistics_total_youths_not_surveyed INTEGER DEFAULT 0,
    FOREIGN KEY (created_by) REFERENCES LYDO(lydo_id) ON DELETE RESTRICT,
    INDEX idx_dates (start_date, end_date),
    INDEX idx_created_by (created_by)
);

-- 11. KK_SURVEY_RESPONSES TABLE
CREATE TABLE KK_Survey_Responses (
    response_id VARCHAR(20) PRIMARY KEY, -- e.g., 'RES001', 'RES002'
    batch_id VARCHAR(20) NOT NULL,
    youth_id VARCHAR(20) NOT NULL, -- ADDED: Missing column
    barangay_id VARCHAR(20) NOT NULL, -- ADDED: Missing column
    
    -- I. PROFILE Section (from questionnaire)
    civil_status ENUM('Single', 'Married', 'Widowed', 'Divorced', 'Separated', 'Annulled', 'Unknown', 'Live-in'),
    youth_classification ENUM('In School Youth', 'Out of School Youth', 'Working Youth', 'Youth w/Specific Needs') NOT NULL,
    youth_specific_needs ENUM('Person w/Disability', 'Children in Conflict w/ Law', 'Indigenous People') NULL,
    youth_age_group ENUM('Child Youth (15-17 yrs old)', 'Core Youth (18-24 yrs old)', 'Young Adult (15-30 yrs old)'),
    educational_background ENUM('Elementary Level', 'Elementary Grad', 'High School Level', 'High School Grad', 'Vocational Grad', 'College Level', 'College Grad', 'Masters Level', 'Masters Grad', 'Doctorate Level', 'Doctorate Graduate'),
    work_status ENUM('Employed', 'Unemployed', 'Self-Employed', 'Currently looking for a Job', 'Not interested looking for a job'),
    registered_SK_voter BOOLEAN,
    registered_national_voter BOOLEAN,
    attended_KK_assembly BOOLEAN,
    voted_last_SK BOOLEAN,
    times_attended ENUM('1-2 Times', '3-4 Times', '5 and above') NULL,
    reason_not_attended ENUM('There was no KK Assembly Meeting', 'Not interested to Attend') NULL,
    
    -- Validation and technical fields
    validation_status ENUM('pending', 'validated', 'rejected') DEFAULT 'pending',
    validation_tier ENUM('automatic', 'manual', 'final') DEFAULT 'automatic',
    validated_by VARCHAR(20) NULL, -- SK Official ID
    validation_date TIMESTAMP NULL,
    validation_comments TEXT,
    
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (batch_id) REFERENCES KK_Survey_Batches(batch_id) ON DELETE RESTRICT,
    FOREIGN KEY (youth_id) REFERENCES Youth_Profiling(youth_id) ON DELETE RESTRICT, -- ADDED: Missing foreign key
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id) ON DELETE RESTRICT,
    FOREIGN KEY (validated_by) REFERENCES SK_Officials(sk_id) ON DELETE SET NULL,
    INDEX idx_batch_id (batch_id),
    INDEX idx_youth_id (youth_id), -- ADDED: Missing index
    INDEX idx_barangay_id (barangay_id),
    INDEX idx_validation_status (validation_status),
    INDEX idx_validation_tier (validation_tier),
    INDEX idx_created_at (created_at)
);

-- 12. VALIDATION_LOGS TABLE
CREATE TABLE Validation_Logs (
    log_id VARCHAR(20) PRIMARY KEY, -- e.g., 'LOG001', 'LOG002'
    response_id VARCHAR(20) NOT NULL,
    validated_by VARCHAR(20) NOT NULL, -- SK Official ID
    validation_action ENUM('validate', 'reject') NOT NULL,
    validation_tier ENUM('automatic', 'manual', 'final') NOT NULL,
    validation_comments TEXT,
    validation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (response_id) REFERENCES KK_Survey_Responses(response_id) ON DELETE CASCADE,
    FOREIGN KEY (validated_by) REFERENCES SK_Officials(sk_id) ON DELETE RESTRICT,
    INDEX idx_response_id (response_id),
    INDEX idx_validated_by (validated_by),
    INDEX idx_validation_action (validation_action),
    INDEX idx_validation_date (validation_date)
);

-- 13. ACTIVITY_LOGS TABLE
CREATE TABLE Activity_Logs (
    log_id VARCHAR(20) PRIMARY KEY, -- e.g., 'ACT001', 'ACT002'
    user_id VARCHAR(20) NULL, -- Can be NULL for anonymous actions
    user_type ENUM('admin', 'lydo_staff', 'sk_official', 'youth', 'anonymous') NULL,
    action VARCHAR(100) NOT NULL,
    resource_type VARCHAR(50) NOT NULL, -- 'survey', 'user', 'validation', etc.
    resource_id VARCHAR(20) NULL,
    resource_name VARCHAR(100) NULL,
    details JSON, -- Additional details about the action
    category ENUM('Authentication', 'User Management', 'Survey Management', 'Announcement', 'Activity Log', 'Data Export', 'Data Management', 'System Management') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    success BOOLEAN DEFAULT TRUE,
    error_message TEXT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE SET NULL,
    INDEX idx_user_id (user_id),
    INDEX idx_user_type (user_type),
    INDEX idx_action (action),
    INDEX idx_resource (resource_type, resource_id),
    INDEX idx_created_at (created_at)
);

-- 14. NOTIFICATIONS TABLE
CREATE TABLE Notifications (
    notification_id VARCHAR(20) PRIMARY KEY, -- e.g., 'NOT001', 'NOT002'
    user_id VARCHAR(20) NULL, -- NULL for broadcast notifications
    user_type ENUM('admin', 'lydo_staff', 'sk_official', 'youth', 'all') NULL, -- Target user type
    barangay_id VARCHAR(20) NULL, -- Target specific barangay
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    type ENUM('info', 'success', 'warning', 'error', 'announcement', 'survey_reminder', 'validation_needed', 'sk_term_end', 'kk_batch_end') DEFAULT 'info',
    priority ENUM('low', 'normal', 'high', 'urgent') DEFAULT 'normal',
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP NULL,
    expires_at TIMESTAMP NULL, -- Auto-expire notifications
    created_by VARCHAR(20) NOT NULL, -- Who created the notification
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (barangay_id) REFERENCES Barangay(barangay_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES Users(user_id) ON DELETE CASCADE,
    INDEX idx_user_id (user_id),
    INDEX idx_user_type (user_type),
    INDEX idx_barangay_id (barangay_id),
    INDEX idx_type (type),
    INDEX idx_priority (priority),
    INDEX idx_is_read (is_read),
    INDEX idx_created_at (created_at),
    INDEX idx_expires_at (expires_at)
);

-- 15. ANNOUNCEMENTS TABLE
CREATE TABLE Announcements (
    announcement_id VARCHAR(20) PRIMARY KEY, -- e.g., 'ANN001', 'ANN002'
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    summary VARCHAR(500) NULL, -- Short summary for preview
    category ENUM('general', 'event', 'survey', 'meeting', 'deadline', 'achievement', 'update') DEFAULT 'general',
    status ENUM('draft', 'published', 'archived') DEFAULT 'draft',
    image_url VARCHAR(255) NULL,
    attachment_name VARCHAR(255) NULL,
    attachment_url VARCHAR(255) NULL,
    is_featured BOOLEAN DEFAULT FALSE, -- Featured announcements appear first
    is_pinned BOOLEAN DEFAULT FALSE, -- Pinned announcements stay at top
    published_at TIMESTAMP NULL,
    created_by VARCHAR(20) NOT NULL, -- Who created the announcement
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES Users(user_id) ON DELETE CASCADE,
    INDEX idx_status (status),
    INDEX idx_is_featured (is_featured),
    INDEX idx_is_pinned (is_pinned),
    INDEX idx_category (category),
    INDEX idx_published_at (published_at),
    INDEX idx_created_at (created_at)
);

-- Insert default roles with comprehensive permissions
INSERT INTO Roles (role_id, role_name, role_description, permissions) VALUES
('ROL001', 'admin', 'System Administrator with full access', 
'{"dashboard": true, "users": true, "surveys": true, "reports": true, "settings": true, "barangay_management": true, "role_management": true, "validation": true, "analytics": true, "notifications": true, "activity_logs": true}'),

('ROL002', 'lydo_staff', 'LYDO Staff with administrative access', 
'{"dashboard": true, "surveys": true, "reports": true, "validation": true, "barangay_view": true, "analytics": true, "notifications": true, "activity_logs": true}'),

('ROL003', 'sk_official', 'SK Official with barangay-level access', 
'{"dashboard": true, "validation": true, "reports": true, "barangay_limited": true, "notifications": true}'),

('ROL004', 'youth', 'Youth participant with survey access only', 
'{"survey_participation": true, "view_own_data": true, "notifications": true}');




-- Insert the 33 barangays of San Jose, Batangas
INSERT INTO Barangay (barangay_id, barangay_name) VALUES
('SJB001', 'Aguila'),
('SJB002', 'Anus'),
('SJB003', 'Aya'),
('SJB004', 'Bagong Pook'),
('SJB005', 'Balagtasin'),
('SJB006', 'Balagtasin I'),
('SJB007', 'Banaybanay I'),
('SJB008', 'Banaybanay II'),
('SJB009', 'Bigain I'),
('SJB010', 'Bigain II'),
('SJB011', 'Bigain South'),
('SJB012', 'Calansayan'),
('SJB013', 'Dagatan'),
('SJB014', 'Don Luis'),
('SJB015', 'Galamay-Amo'),
('SJB016', 'Lalayat'),
('SJB017', 'Lapolapo I'),
('SJB018', 'Lapolapo II'),
('SJB019', 'Lepute'),
('SJB020', 'Lumil'),
('SJB021', 'Mojon-Tampoy'),
('SJB022', 'Natunuan'),
('SJB023', 'Palanca'),
('SJB024', 'Pinagtung-ulan'),
('SJB025', 'Poblacion Barangay I'),
('SJB026', 'Poblacion Barangay II'),
('SJB027', 'Poblacion Barangay III'),
('SJB028', 'Poblacion Barangay IV'),
('SJB029', 'Sabang'),
('SJB030', 'Salaban'),
('SJB031', 'Santo Cristo'),
('SJB032', 'Taysan'),
('SJB033', 'Tugtug');



-- Insert sample admin user
INSERT INTO LYDO (lydo_id, role_id, email, personal_email, password_hash, first_name, last_name) VALUES
('LYDO001', 'ROL001', 'admin@youthgovernance.com', 'admin.personal@email.com', '$2b$10$hashedpasswordhere', 'System', 'Administrator');

-- Insert sample LYDO staff
INSERT INTO LYDO (lydo_id, role_id, email, personal_email, password_hash, first_name, last_name) VALUES
('LYDO002', 'ROL002', 'staff@youthgovernance.com', 'staff.personal@email.com', '$2b$10$hashedpasswordhere', 'LYDO', 'Staff');

-- Insert sample SK official
INSERT INTO SK_Officials (sk_id, email, personal_email, password_hash, role_id, barangay_id, term_id, first_name, last_name, position) VALUES
('SK001', 'sk@youthgovernance.com', 'sk.personal@email.com', '$2b$10$hashedpasswordhere', 'ROL003', 'SJB001', 'TRM001', 'SK', 'Official', 'SK Chairperson');

-- Insert corresponding user records
INSERT INTO Users (user_id, user_type, lydo_id, sk_id, youth_id) VALUES
('USR001', 'admin', 'LYDO001', NULL, NULL),
('USR002', 'lydo_staff', 'LYDO002', NULL, NULL),
('USR003', 'sk_official', NULL, 'SK001', NULL);
