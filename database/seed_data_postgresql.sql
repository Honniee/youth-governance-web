-- PostgreSQL Sample Data for Youth Governance System
-- This file contains sample data to populate the database

-- Insert Roles
INSERT INTO roles (role_id, role_name, role_description, permissions, is_active) VALUES
('ROL001', 'admin', 'System Administrator with full access', '{"dashboard": true, "users": true, "surveys": true, "reports": true, "settings": true, "barangay_management": true, "role_management": true, "validation": true, "analytics": true, "notifications": true, "activity_logs": true}', TRUE),
('ROL002', 'lydo_staff', 'LYDO Staff with administrative access', '{"dashboard": true, "surveys": true, "reports": true, "validation": true, "barangay_view": true, "analytics": true, "notifications": true, "activity_logs": true}', TRUE),
('ROL003', 'sk_official', 'SK Official with barangay-level access', '{"dashboard": true, "validation": true, "reports": true, "barangay_limited": true, "notifications": true}', TRUE),
('ROL004', 'youth', 'Youth participant with survey access only', '{"survey_participation": true, "view_own_data": true, "notifications": true}', TRUE);

-- Insert Barangays (all 33 barangays of San Jose, Batangas)
INSERT INTO barangay (barangay_id, barangay_name) VALUES
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

-- Insert LYDO staff
INSERT INTO lydo (lydo_id, role_id, email, personal_email, password_hash, first_name, last_name, middle_name, suffix, is_active, email_verified, created_by) VALUES
('LYDO001', 'ROL001', 'admin@youthgovernance.com', 'admin.personal@email.com', '$2b$10$hashedpasswordhere', 'Maria', 'Santos', 'Garcia', 'Dr.', TRUE, TRUE, 'LYDO001'),
('LYDO002', 'ROL002', 'staff1@youthgovernance.com', 'staff1.personal@email.com', '$2b$10$hashedpasswordhere', 'Juan', 'Cruz', 'Dela', 'Jr.', TRUE, TRUE, 'LYDO001'),
('LYDO003', 'ROL002', 'staff2@youthgovernance.com', 'staff2.personal@email.com', '$2b$10$hashedpasswordhere', 'Ana', 'Reyes', 'Santos', '', TRUE, TRUE, 'LYDO001'),
('LYDO004', 'ROL002', 'staff3@youthgovernance.com', 'staff3.personal@email.com', '$2b$10$hashedpasswordhere', 'Pedro', 'Mendoza', 'Lopez', 'III', TRUE, TRUE, 'LYDO001'),
('LYDO005', 'ROL002', 'staff4@youthgovernance.com', 'staff4.personal@email.com', '$2b$10$hashedpasswordhere', 'Carmen', 'Villanueva', 'Torres', '', TRUE, TRUE, 'LYDO001'),
('LYDO006', 'ROL002', 'staff5@youthgovernance.com', 'staff5.personal@email.com', '$2b$10$hashedpasswordhere', 'Roberto', 'Aquino', 'Fernandez', 'Sr.', TRUE, TRUE, 'LYDO001');

-- Insert SK Terms
INSERT INTO sk_terms (term_id, term_name, start_date, end_date, status, is_active, is_current, created_by, statistics_total_officials, statistics_active_officials, statistics_total_sk_chairperson, statistics_total_sk_secretary, statistics_total_sk_treasurer) VALUES
('TRM001', '2023-2025 Term', '2023-06-30', '2025-06-30', 'completed', TRUE, FALSE, 'LYDO001', 2, 0, 1, 1, 0),
('TRM002', '2025-2027 Term', '2025-06-30', '2027-06-30', 'active', TRUE, TRUE, 'LYDO001', 3, 3, 1, 1, 1),
('TRM003', '2027-2029 Term', '2027-06-30', '2029-06-30', 'upcoming', TRUE, FALSE, 'LYDO001', 0, 0, 0, 0, 0);

-- Insert SK Officials
INSERT INTO sk_officials (sk_id, role_id, term_id, email, personal_email, password_hash, barangay_id, first_name, last_name, middle_name, suffix, position, is_active, email_verified, created_by) VALUES
('SK001', 'ROL003', 'TRM002', 'sk.aguila@youthgovernance.com', 'sk.aguila.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB001', 'Miguel', 'Santos', 'Dela', 'Jr.', 'SK Chairperson', TRUE, TRUE, 'LYDO001'),
('SK002', 'ROL003', 'TRM002', 'sk.anus@youthgovernance.com', 'sk.anus.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB002', 'Sofia', 'Cruz', 'Reyes', '', 'SK Secretary', TRUE, TRUE, 'LYDO001'),
('SK003', 'ROL003', 'TRM002', 'sk.aya@youthgovernance.com', 'sk.aya.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB003', 'Luis', 'Mendoza', 'Lopez', 'III', 'SK Treasurer', TRUE, TRUE, 'LYDO001'),
('SK004', 'ROL003', 'TRM001', 'sk.bagongpook@youthgovernance.com', 'sk.bagongpook.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB004', 'Isabella', 'Villanueva', 'Torres', '', 'SK Chairperson', FALSE, TRUE, 'LYDO001'),
('SK005', 'ROL003', 'TRM001', 'sk.balagtasin@youthgovernance.com', 'sk.balagtasin.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB005', 'Diego', 'Aquino', 'Fernandez', 'Sr.', 'SK Secretary', FALSE, TRUE, 'LYDO001');

-- Insert SK Officials Profiling
INSERT INTO sk_officials_profiling (profiling_id, sk_id, birth_date, age, gender, contact_number, school_or_company, performance_metrics_survey_validated) VALUES
('PRO001', 'SK001', '2000-03-15', 24, 'Male', '+639151234567', 'San Jose National High School', 45),
('PRO002', 'SK002', '1999-07-22', 25, 'Female', '+639151234568', 'Batangas State University', 38),
('PRO003', 'SK003', '2001-11-08', 23, 'Male', '+639151234569', 'San Jose College', 42),
('PRO004', 'SK004', '1998-05-12', 26, 'Female', '+639151234570', 'University of Batangas', 0),
('PRO005', 'SK005', '1997-09-30', 27, 'Male', '+639151234571', 'Lyceum of the Philippines', 0);

-- Insert Youth Profiling
INSERT INTO youth_profiling (youth_id, first_name, last_name, middle_name, suffix, barangay_id, purok_zone, birth_date, age, gender, contact_number, email) VALUES
('YTH001', 'Maria', 'Garcia', 'Santos', '', 'SJB001', 'Zone 1', '2006-03-15', 18, 'Female', '+639151234572', 'maria.garcia@email.com'),
('YTH002', 'Jose', 'Reyes', 'Cruz', 'Jr.', 'SJB001', 'Zone 2', '2005-07-22', 19, 'Male', '+639151234573', 'jose.reyes@email.com'),
('YTH003', 'Ana', 'Lopez', 'Mendoza', '', 'SJB001', 'Zone 3', '2004-11-08', 20, 'Female', '+639151234574', 'ana.lopez@email.com'),
('YTH004', 'Pedro', 'Torres', 'Villanueva', 'III', 'SJB001', 'Zone 1', '2003-05-12', 21, 'Male', '+639151234575', 'pedro.torres@email.com'),
('YTH005', 'Carmen', 'Fernandez', 'Aquino', '', 'SJB001', 'Zone 2', '2002-09-30', 22, 'Female', '+639151234576', 'carmen.fernandez@email.com'),
('YTH006', 'Roberto', 'Santos', 'Garcia', 'Sr.', 'SJB002', 'Zone 1', '2006-01-15', 18, 'Male', '+639151234577', 'roberto.santos@email.com'),
('YTH007', 'Lucia', 'Cruz', 'Reyes', '', 'SJB002', 'Zone 2', '2005-04-22', 19, 'Female', '+639151234578', 'lucia.cruz@email.com'),
('YTH008', 'Fernando', 'Mendoza', 'Lopez', 'Jr.', 'SJB002', 'Zone 3', '2004-08-08', 20, 'Male', '+639151234579', 'fernando.mendoza@email.com'),
('YTH009', 'Elena', 'Villanueva', 'Torres', '', 'SJB002', 'Zone 1', '2003-12-12', 21, 'Female', '+639151234580', 'elena.villanueva@email.com'),
('YTH010', 'Carlos', 'Aquino', 'Fernandez', 'III', 'SJB002', 'Zone 2', '2002-06-30', 22, 'Male', '+639151234581', 'carlos.aquino@email.com'),
('YTH011', 'Isabella', 'Garcia', 'Santos', '', 'SJB003', 'Zone 1', '2006-02-15', 18, 'Female', '+639151234582', 'isabella.garcia@email.com'),
('YTH012', 'Manuel', 'Reyes', 'Cruz', 'Jr.', 'SJB003', 'Zone 2', '2005-06-22', 19, 'Male', '+639151234583', 'manuel.reyes@email.com'),
('YTH013', 'Rosa', 'Lopez', 'Mendoza', '', 'SJB003', 'Zone 3', '2004-10-08', 20, 'Female', '+639151234584', 'rosa.lopez@email.com'),
('YTH014', 'Antonio', 'Torres', 'Villanueva', 'III', 'SJB003', 'Zone 1', '2003-04-12', 21, 'Male', '+639151234585', 'antonio.torres@email.com'),
('YTH015', 'Patricia', 'Fernandez', 'Aquino', '', 'SJB003', 'Zone 2', '2002-08-30', 22, 'Female', '+639151234586', 'patricia.fernandez@email.com');

-- Insert Users
INSERT INTO users (user_id, user_type, lydo_id, sk_id, youth_id) VALUES
('USR001', 'admin', 'LYDO001', NULL, NULL),
('USR002', 'lydo_staff', 'LYDO002', NULL, NULL),
('USR003', 'lydo_staff', 'LYDO003', NULL, NULL),
('USR004', 'lydo_staff', 'LYDO004', NULL, NULL),
('USR005', 'lydo_staff', 'LYDO005', NULL, NULL),
('USR006', 'lydo_staff', 'LYDO006', NULL, NULL),
('USR007', 'sk_official', NULL, 'SK001', NULL),
('USR008', 'sk_official', NULL, 'SK002', NULL),
('USR009', 'sk_official', NULL, 'SK003', NULL),
('USR010', 'sk_official', NULL, 'SK004', NULL),
('USR011', 'sk_official', NULL, 'SK005', NULL),
('USR012', 'youth', NULL, NULL, 'YTH001'),
('USR013', 'youth', NULL, NULL, 'YTH002'),
('USR014', 'youth', NULL, NULL, 'YTH003'),
('USR015', 'youth', NULL, NULL, 'YTH004'),
('USR016', 'youth', NULL, NULL, 'YTH005'),
('USR017', 'youth', NULL, NULL, 'YTH006'),
('USR018', 'youth', NULL, NULL, 'YTH007'),
('USR019', 'youth', NULL, NULL, 'YTH008'),
('USR020', 'youth', NULL, NULL, 'YTH009'),
('USR021', 'youth', NULL, NULL, 'YTH010'),
('USR022', 'youth', NULL, NULL, 'YTH011'),
('USR023', 'youth', NULL, NULL, 'YTH012'),
('USR024', 'youth', NULL, NULL, 'YTH013'),
('USR025', 'youth', NULL, NULL, 'YTH014'),
('USR026', 'youth', NULL, NULL, 'YTH015');

-- Insert KK Survey Batches
INSERT INTO kk_survey_batches (batch_id, batch_name, description, start_date, end_date, target_age_min, target_age_max, created_by, statistics_total_responses, statistics_validated_responses, statistics_total_youths, statistics_total_youths_surveyed, statistics_total_youths_not_surveyed) VALUES
('BAT001', 'KK Survey 2023 Q1', 'First quarter youth survey for 2023', '2023-01-01', '2023-03-31', 15, 30, 'LYDO001', 5, 5, 15, 5, 10),
('BAT002', 'KK Survey 2023 Q2', 'Second quarter youth survey for 2023', '2023-04-01', '2023-06-30', 15, 30, 'LYDO001', 2, 2, 15, 2, 13),
('BAT003', 'KK Survey 2024 Q1', 'First quarter youth survey for 2024', '2024-01-01', '2024-03-31', 15, 30, 'LYDO001', 3, 3, 15, 3, 12),
('BAT004', 'KK Survey 2024 Q2', 'Second quarter youth survey for 2024 (Currently Active)', '2024-04-01', '2024-06-30', 15, 30, 'LYDO001', 4, 2, 15, 4, 11),
('BAT005', 'KK Survey 2024 Q3', 'Third quarter youth survey for 2024 (Draft - No responses yet)', '2024-07-01', '2024-09-30', 15, 30, 'LYDO001', 0, 0, 15, 0, 15);

-- Insert Voters List
INSERT INTO voters_list (voter_id, first_name, last_name, middle_name, suffix, birth_date, gender, created_by) VALUES
('VOT001', 'Maria', 'Santos', 'Garcia', '', '2005-03-15', 'Female', 'LYDO001'),
('VOT002', 'Jose', 'Cruz', 'Reyes', 'Jr.', '2004-07-22', 'Male', 'LYDO001'),
('VOT003', 'Ana', 'Mendoza', 'Lopez', '', '2003-11-08', 'Female', 'LYDO001'),
('VOT004', 'Pedro', 'Villanueva', 'Torres', 'III', '2002-05-12', 'Male', 'LYDO001'),
('VOT005', 'Carmen', 'Aquino', 'Fernandez', '', '2001-09-30', 'Female', 'LYDO001'); 