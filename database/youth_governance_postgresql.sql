-- PostgreSQL Database Schema for Youth Governance System
-- Converted from MySQL/MariaDB format
-- Database: youth_governance

-- Enable UUID extension for better ID generation
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create custom ENUM types
CREATE TYPE user_type_enum AS ENUM ('admin', 'lydo_staff', 'sk_official', 'youth', 'anonymous');
CREATE TYPE civil_status_enum AS ENUM ('Single', 'Married', 'Widowed', 'Divorced', 'Separated', 'Annulled', 'Unknown', 'Live-in');
CREATE TYPE youth_classification_enum AS ENUM ('In School Youth', 'Out of School Youth', 'Working Youth', 'Youth w/Specific Needs');
CREATE TYPE youth_specific_needs_enum AS ENUM ('Person w/Disability', 'Children in Conflict w/ Law', 'Indigenous People');
CREATE TYPE youth_age_group_enum AS ENUM ('Child Youth (15-17 yrs old)', 'Core Youth (18-24 yrs old)', 'Young Adult (15-30 yrs old)');
CREATE TYPE educational_background_enum AS ENUM ('Elementary Level', 'Elementary Grad', 'High School Level', 'High School Grad', 'Vocational Grad', 'College Level', 'College Grad', 'Masters Level', 'Masters Grad', 'Doctorate Level', 'Doctorate Graduate');
CREATE TYPE work_status_enum AS ENUM ('Employed', 'Unemployed', 'Self-Employed', 'Currently looking for a Job', 'Not interested looking for a job');
CREATE TYPE attendance_enum AS ENUM ('1-2 Times', '3-4 Times', '5 and above');
CREATE TYPE reason_not_attended_enum AS ENUM ('There was no KK Assembly Meeting', 'Not interested to Attend');
CREATE TYPE validation_status_enum AS ENUM ('pending', 'validated', 'rejected');
CREATE TYPE validation_tier_enum AS ENUM ('automatic', 'manual', 'final');
CREATE TYPE gender_enum AS ENUM ('Male', 'Female');
CREATE TYPE sk_position_enum AS ENUM ('SK Chairperson', 'SK Secretary', 'SK Treasurer', 'SK Councilor');
CREATE TYPE announcement_category_enum AS ENUM ('general', 'event', 'survey', 'meeting', 'deadline', 'achievement', 'update');
CREATE TYPE announcement_status_enum AS ENUM ('draft', 'published', 'archived');
CREATE TYPE notification_type_enum AS ENUM ('info', 'success', 'warning', 'error', 'announcement', 'survey_reminder', 'validation_needed', 'sk_term_end', 'kk_batch_end');
CREATE TYPE priority_enum AS ENUM ('low', 'normal', 'high', 'urgent');
CREATE TYPE term_status_enum AS ENUM ('active', 'completed', 'upcoming');
CREATE TYPE activity_category_enum AS ENUM ('Authentication', 'User Management', 'Survey Management', 'Announcement', 'Activity Log', 'Data Export', 'Data Management', 'System Management');
CREATE TYPE validation_action_enum AS ENUM ('validate', 'reject');

-- Create tables

-- Roles table
CREATE TABLE roles (
    role_id VARCHAR(20) PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    role_description TEXT,
    permissions JSONB,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Barangay table
CREATE TABLE barangay (
    barangay_id VARCHAR(20) PRIMARY KEY,
    barangay_name VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- LYDO table
CREATE TABLE lydo (
    lydo_id VARCHAR(20) PRIMARY KEY,
    role_id VARCHAR(20) NOT NULL REFERENCES roles(role_id),
    email VARCHAR(100) NOT NULL UNIQUE,
    personal_email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    suffix VARCHAR(50),
    profile_picture VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    created_by VARCHAR(20) REFERENCES lydo(lydo_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    deactivated BOOLEAN DEFAULT FALSE,
    deactivated_at TIMESTAMP
);

-- SK Terms table
CREATE TABLE sk_terms (
    term_id VARCHAR(20) PRIMARY KEY,
    term_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status term_status_enum DEFAULT 'upcoming',
    is_active BOOLEAN DEFAULT TRUE,
    is_current BOOLEAN DEFAULT FALSE,
    created_by VARCHAR(20) NOT NULL REFERENCES lydo(lydo_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statistics_total_officials INTEGER DEFAULT 0,
    statistics_active_officials INTEGER DEFAULT 0,
    statistics_inactive_officials INTEGER DEFAULT 0,
    statistics_total_sk_chairperson INTEGER DEFAULT 0,
    statistics_total_sk_secretary INTEGER DEFAULT 0,
    statistics_total_sk_treasurer INTEGER DEFAULT 0,
    statistics_total_sk_councilor INTEGER DEFAULT 0
);

-- SK Officials table
CREATE TABLE sk_officials (
    sk_id VARCHAR(20) PRIMARY KEY,
    role_id VARCHAR(20) NOT NULL REFERENCES roles(role_id),
    term_id VARCHAR(20) NOT NULL REFERENCES sk_terms(term_id),
    email VARCHAR(100) NOT NULL UNIQUE,
    personal_email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    barangay_id VARCHAR(20) NOT NULL REFERENCES barangay(barangay_id),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    suffix VARCHAR(50),
    position sk_position_enum NOT NULL,
    profile_picture VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    email_verified BOOLEAN DEFAULT FALSE,
    created_by VARCHAR(20) NOT NULL REFERENCES lydo(lydo_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- SK Officials Profiling table
CREATE TABLE sk_officials_profiling (
    profiling_id VARCHAR(20) PRIMARY KEY,
    sk_id VARCHAR(20) NOT NULL REFERENCES sk_officials(sk_id) ON DELETE CASCADE,
    birth_date DATE NOT NULL,
    age INTEGER NOT NULL,
    gender gender_enum NOT NULL,
    contact_number VARCHAR(20) NOT NULL UNIQUE,
    school_or_company VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    performance_metrics_survey_validated INTEGER DEFAULT 0
);

-- Youth Profiling table
CREATE TABLE youth_profiling (
    youth_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    suffix VARCHAR(50),
    region VARCHAR(50) NOT NULL DEFAULT 'Region IV-A (CALABARZON)',
    province VARCHAR(50) NOT NULL DEFAULT 'Batangas',
    municipality VARCHAR(50) NOT NULL DEFAULT 'San Jose',
    barangay_id VARCHAR(20) NOT NULL REFERENCES barangay(barangay_id),
    purok_zone VARCHAR(50),
    birth_date DATE NOT NULL,
    age INTEGER NOT NULL,
    gender gender_enum NOT NULL,
    contact_number VARCHAR(20) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Users table
CREATE TABLE users (
    user_id VARCHAR(20) PRIMARY KEY,
    user_type user_type_enum NOT NULL,
    lydo_id VARCHAR(20) REFERENCES lydo(lydo_id) ON DELETE CASCADE,
    sk_id VARCHAR(20) REFERENCES sk_officials(sk_id) ON DELETE CASCADE,
    youth_id VARCHAR(20) REFERENCES youth_profiling(youth_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- KK Survey Batches table
CREATE TABLE kk_survey_batches (
    batch_id VARCHAR(20) PRIMARY KEY,
    batch_name VARCHAR(100) NOT NULL,
    description TEXT,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    target_age_min INTEGER DEFAULT 15,
    target_age_max INTEGER DEFAULT 30,
    created_by VARCHAR(20) NOT NULL REFERENCES lydo(lydo_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    statistics_total_responses INTEGER DEFAULT 0,
    statistics_validated_responses INTEGER DEFAULT 0,
    statistics_rejected_responses INTEGER DEFAULT 0,
    statistics_pending_responses INTEGER DEFAULT 0,
    statistics_total_youths INTEGER DEFAULT 0,
    statistics_total_youths_surveyed INTEGER DEFAULT 0,
    statistics_total_youths_not_surveyed INTEGER DEFAULT 0
);

-- KK Survey Responses table
CREATE TABLE kk_survey_responses (
    response_id VARCHAR(20) PRIMARY KEY,
    batch_id VARCHAR(20) NOT NULL REFERENCES kk_survey_batches(batch_id),
    youth_id VARCHAR(20) NOT NULL REFERENCES youth_profiling(youth_id),
    barangay_id VARCHAR(20) NOT NULL REFERENCES barangay(barangay_id),
    civil_status civil_status_enum,
    youth_classification youth_classification_enum NOT NULL,
    youth_specific_needs youth_specific_needs_enum,
    youth_age_group youth_age_group_enum,
    educational_background educational_background_enum,
    work_status work_status_enum,
    registered_sk_voter BOOLEAN,
    registered_national_voter BOOLEAN,
    attended_kk_assembly BOOLEAN,
    voted_last_sk BOOLEAN,
    times_attended attendance_enum,
    reason_not_attended reason_not_attended_enum,
    validation_status validation_status_enum DEFAULT 'pending',
    validation_tier validation_tier_enum DEFAULT 'automatic',
    validated_by VARCHAR(20) REFERENCES sk_officials(sk_id),
    validation_date TIMESTAMP,
    validation_comments TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Validation Logs table
CREATE TABLE validation_logs (
    log_id VARCHAR(20) PRIMARY KEY,
    response_id VARCHAR(20) NOT NULL REFERENCES kk_survey_responses(response_id) ON DELETE CASCADE,
    validated_by VARCHAR(20) NOT NULL REFERENCES sk_officials(sk_id),
    validation_action validation_action_enum NOT NULL,
    validation_tier validation_tier_enum NOT NULL,
    validation_comments TEXT,
    validation_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Announcements table
CREATE TABLE announcements (
    announcement_id VARCHAR(20) PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT NOT NULL,
    summary VARCHAR(500),
    category announcement_category_enum DEFAULT 'general',
    status announcement_status_enum DEFAULT 'draft',
    image_url VARCHAR(255),
    attachment_name VARCHAR(255),
    attachment_url VARCHAR(255),
    is_featured BOOLEAN DEFAULT FALSE,
    is_pinned BOOLEAN DEFAULT FALSE,
    published_at TIMESTAMP,
    created_by VARCHAR(20) NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Notifications table
CREATE TABLE notifications (
    notification_id VARCHAR(20) PRIMARY KEY,
    user_id VARCHAR(20) REFERENCES users(user_id) ON DELETE CASCADE,
    user_type user_type_enum,
    barangay_id VARCHAR(20) REFERENCES barangay(barangay_id) ON DELETE CASCADE,
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    type notification_type_enum DEFAULT 'info',
    priority priority_enum DEFAULT 'normal',
    is_read BOOLEAN DEFAULT FALSE,
    read_at TIMESTAMP,
    expires_at TIMESTAMP,
    created_by VARCHAR(20) NOT NULL REFERENCES users(user_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Activity Logs table
CREATE TABLE activity_logs (
    log_id VARCHAR(20) PRIMARY KEY,
    user_id VARCHAR(20) REFERENCES users(user_id) ON DELETE SET NULL,
    user_type user_type_enum,
    action VARCHAR(100) NOT NULL,
    resource_type VARCHAR(50) NOT NULL,
    resource_id VARCHAR(20),
    resource_name VARCHAR(100),
    details JSONB,
    category activity_category_enum NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    success BOOLEAN DEFAULT TRUE,
    error_message TEXT
);

-- Voters List table
CREATE TABLE voters_list (
    voter_id VARCHAR(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    middle_name VARCHAR(50),
    suffix VARCHAR(50),
    birth_date DATE NOT NULL,
    gender gender_enum,
    created_by VARCHAR(20) NOT NULL REFERENCES lydo(lydo_id),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX idx_users_user_type ON users(user_type);
CREATE INDEX idx_users_lydo_id ON users(lydo_id);
CREATE INDEX idx_users_sk_id ON users(sk_id);
CREATE INDEX idx_users_youth_id ON users(youth_id);

CREATE INDEX idx_activity_logs_user_id ON activity_logs(user_id);
CREATE INDEX idx_activity_logs_user_type ON activity_logs(user_type);
CREATE INDEX idx_activity_logs_action ON activity_logs(action);
CREATE INDEX idx_activity_logs_created_at ON activity_logs(created_at);

CREATE INDEX idx_kk_survey_responses_batch_id ON kk_survey_responses(batch_id);
CREATE INDEX idx_kk_survey_responses_youth_id ON kk_survey_responses(youth_id);
CREATE INDEX idx_kk_survey_responses_barangay_id ON kk_survey_responses(barangay_id);
CREATE INDEX idx_kk_survey_responses_validation_status ON kk_survey_responses(validation_status);
CREATE INDEX idx_kk_survey_responses_created_at ON kk_survey_responses(created_at);

CREATE INDEX idx_notifications_user_id ON notifications(user_id);
CREATE INDEX idx_notifications_user_type ON notifications(user_type);
CREATE INDEX idx_notifications_is_read ON notifications(is_read);
CREATE INDEX idx_notifications_created_at ON notifications(created_at);

CREATE INDEX idx_youth_profiling_barangay_id ON youth_profiling(barangay_id);
CREATE INDEX idx_youth_profiling_age ON youth_profiling(age);
CREATE INDEX idx_youth_profiling_is_active ON youth_profiling(is_active);

-- Function to automatically update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers for updated_at
CREATE TRIGGER update_roles_updated_at BEFORE UPDATE ON roles FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_barangay_updated_at BEFORE UPDATE ON barangay FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_lydo_updated_at BEFORE UPDATE ON lydo FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_sk_terms_updated_at BEFORE UPDATE ON sk_terms FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_sk_officials_updated_at BEFORE UPDATE ON sk_officials FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_sk_officials_profiling_updated_at BEFORE UPDATE ON sk_officials_profiling FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_youth_profiling_updated_at BEFORE UPDATE ON youth_profiling FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_kk_survey_batches_updated_at BEFORE UPDATE ON kk_survey_batches FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_kk_survey_responses_updated_at BEFORE UPDATE ON kk_survey_responses FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_announcements_updated_at BEFORE UPDATE ON announcements FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_voters_list_updated_at BEFORE UPDATE ON voters_list FOR EACH ROW EXECUTE FUNCTION update_updated_at_column(); 