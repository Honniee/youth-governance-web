-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 09, 2025 at 11:34 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `youth_governance`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` varchar(20) NOT NULL,
  `user_id` varchar(20) DEFAULT NULL,
  `user_type` enum('admin','lydo_staff','sk_official','youth','anonymous') DEFAULT NULL,
  `action` varchar(100) NOT NULL,
  `resource_type` varchar(50) NOT NULL,
  `resource_id` varchar(20) DEFAULT NULL,
  `resource_name` varchar(100) DEFAULT NULL,
  `details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`details`)),
  `category` enum('Authentication','User Management','Survey Management','Announcement','Activity Log','Data Export','Data Management','System Management') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `success` tinyint(1) DEFAULT 1,
  `error_message` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `user_id`, `user_type`, `action`, `resource_type`, `resource_id`, `resource_name`, `details`, `category`, `created_at`, `success`, `error_message`) VALUES
('ACT001', 'USR001', 'admin', 'create_user', 'user', 'USR002', 'Juan Cruz Jr.', '{\"user_type\": \"lydo_staff\", \"email\": \"staff1@youthgovernance.com\"}', 'User Management', '2024-01-15 01:00:00', 1, NULL),
('ACT002', 'USR001', 'admin', 'create_user', 'user', 'USR007', 'Miguel Santos Jr.', '{\"user_type\": \"sk_official\", \"barangay\": \"SJB001\"}', 'User Management', '2024-01-16 02:30:00', 1, NULL),
('ACT003', 'USR001', 'admin', 'create_survey_batch', 'survey_batch', 'BAT001', 'KK Survey 2023 Q1', '{\"start_date\": \"2023-01-01\", \"end_date\": \"2023-03-31\"}', 'Survey Management', '2023-01-01 00:00:00', 1, NULL),
('ACT004', 'USR002', 'lydo_staff', 'view_survey_responses', 'survey_batch', 'BAT001', 'KK Survey 2023 Q1', '{\"barangay_filter\": \"SJB001\"}', 'Survey Management', '2023-02-20 06:15:00', 1, NULL),
('ACT005', 'USR007', 'sk_official', 'validate_response', 'survey_response', 'RES001', 'Youth Survey Response', '{\"validation_status\": \"validated\", \"tier\": \"final\"}', 'Survey Management', '2023-02-15 02:30:00', 1, NULL),
('ACT006', 'USR008', 'sk_official', 'validate_response', 'survey_response', 'RES004', 'Youth Survey Response', '{\"validation_status\": \"validated\", \"tier\": \"final\"}', 'Survey Management', '2023-02-18 03:45:00', 1, NULL),
('ACT007', 'USR001', 'admin', 'login', 'authentication', NULL, 'User Login', '{\"ip_address\": \"192.168.1.100\", \"user_agent\": \"Mozilla/5.0\"}', 'Authentication', '2024-01-15 00:30:00', 1, NULL),
('ACT008', 'USR007', 'sk_official', 'login', 'authentication', NULL, 'User Login', '{\"ip_address\": \"192.168.1.101\", \"user_agent\": \"Mozilla/5.0\"}', 'Authentication', '2024-01-16 01:15:00', 1, NULL),
('ACT009', 'USR001', 'admin', 'create_survey_batch', 'survey_batch', 'BAT002', 'KK Survey 2023 Q2', '{\"start_date\": \"2023-04-01\", \"end_date\": \"2023-06-30\"}', 'Survey Management', '2023-04-01 00:00:00', 1, NULL),
('ACT010', 'USR001', 'admin', 'create_survey_batch', 'survey_batch', 'BAT003', 'KK Survey 2024 Q1', '{\"start_date\": \"2024-01-01\", \"end_date\": \"2024-03-31\"}', 'Survey Management', '2024-01-01 00:00:00', 1, NULL),
('ACT011', 'USR001', 'admin', 'create_survey_batch', 'survey_batch', 'BAT004', 'KK Survey 2024 Q2', '{\"start_date\": \"2024-04-01\", \"end_date\": \"2024-06-30\"}', 'Survey Management', '2024-04-01 00:00:00', 1, NULL),
('ACT012', 'USR001', 'admin', 'create_survey_batch', 'survey_batch', 'BAT005', 'KK Survey 2024 Q3', '{\"start_date\": \"2024-07-01\", \"end_date\": \"2024-09-30\"}', 'Survey Management', '2024-07-01 00:00:00', 1, NULL),
('ACT013', 'USR012', 'youth', 'submit_survey', 'survey_response', 'RES001', 'Youth Survey Response', '{\"batch_id\": \"BAT001\", \"barangay\": \"SJB001\"}', 'Survey Management', '2023-01-15 02:00:00', 1, NULL),
('ACT014', 'USR013', 'youth', 'submit_survey', 'survey_response', 'RES002', 'Youth Survey Response', '{\"batch_id\": \"BAT001\", \"barangay\": \"SJB001\"}', 'Survey Management', '2023-01-16 03:00:00', 1, NULL),
('ACT015', 'USR014', 'youth', 'submit_survey', 'survey_response', 'RES003', 'Youth Survey Response', '{\"batch_id\": \"BAT001\", \"barangay\": \"SJB001\"}', 'Survey Management', '2023-01-17 04:00:00', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `announcements`
--

CREATE TABLE `announcements` (
  `announcement_id` varchar(20) NOT NULL,
  `title` varchar(200) NOT NULL,
  `content` text NOT NULL,
  `summary` varchar(500) DEFAULT NULL,
  `category` enum('general','event','survey','meeting','deadline','achievement','update') DEFAULT 'general',
  `status` enum('draft','published','archived') DEFAULT 'draft',
  `image_url` varchar(255) DEFAULT NULL,
  `attachment_name` varchar(255) DEFAULT NULL,
  `attachment_url` varchar(255) DEFAULT NULL,
  `is_featured` tinyint(1) DEFAULT 0,
  `is_pinned` tinyint(1) DEFAULT 0,
  `published_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `announcements`
--

INSERT INTO `announcements` (`announcement_id`, `title`, `content`, `summary`, `category`, `status`, `image_url`, `attachment_name`, `attachment_url`, `is_featured`, `is_pinned`, `published_at`, `created_by`, `created_at`, `updated_at`) VALUES
('ANN001', 'Youth Leadership Summit 2024', 'Join us for the annual Youth Leadership Summit on May 15-17, 2024. This event will bring together young leaders from all 33 barangays of San Jose, Batangas to discuss youth empowerment, community development, and governance.', 'Annual youth leadership event for San Jose, Batangas', 'event', 'published', '/images/youth-summit-2024.jpg', 'summit-guidelines.pdf', '/attachments/summit-guidelines.pdf', 1, 1, '2024-04-01 01:00:00', 'USR001', '2024-04-01 01:00:00', '2025-08-09 09:33:59'),
('ANN002', 'KK Survey Q2 2024 - Now Open!', 'The Katipunan ng Kabataan (KK) Survey for Q2 2024 is now open for all eligible youth aged 15-30. Your participation helps us understand youth needs and develop better programs.', 'Q2 2024 youth survey is now open for participation', 'survey', 'published', '/images/kk-survey-2024.jpg', NULL, NULL, 0, 1, '2024-04-01 02:00:00', 'USR001', '2024-04-01 02:00:00', '2025-08-09 09:33:59'),
('ANN003', 'New Youth Programs Available', 'We are excited to announce new youth programs including skills training, entrepreneurship workshops, and sports activities. Check our website for details and registration.', 'New youth programs and activities available', 'update', 'published', NULL, 'youth-programs-2024.pdf', '/attachments/youth-programs-2024.pdf', 0, 0, '2024-04-02 03:00:00', 'USR001', '2024-04-02 03:00:00', '2025-08-09 09:33:59'),
('ANN004', 'SK Officials Monthly Meeting', 'Monthly meeting for all SK Officials scheduled for April 25, 2024 at 2:00 PM. Agenda includes Q2 survey results and upcoming youth programs.', 'Monthly SK officials meeting on April 25', 'meeting', 'published', NULL, 'meeting-agenda.pdf', '/attachments/meeting-agenda.pdf', 0, 0, '2024-04-03 06:00:00', 'USR001', '2024-04-03 06:00:00', '2025-08-09 09:33:59'),
('ANN005', 'Youth Achievers Recognition 2024', 'Congratulations to our outstanding youth achievers! We will recognize exceptional young leaders who have made significant contributions to their communities.', 'Recognition program for outstanding youth', 'achievement', 'published', '/images/youth-achievers-2024.jpg', NULL, NULL, 0, 0, '2024-04-04 08:00:00', 'USR001', '2024-04-04 08:00:00', '2025-08-09 09:33:59'),
('ANN006', 'Upcoming Youth Festival', 'Planning for the annual youth festival is underway. This event will showcase youth talents and promote cultural awareness.', 'Annual youth festival planning in progress', 'event', 'draft', NULL, NULL, NULL, 0, 0, NULL, 'USR001', '2024-04-05 02:00:00', '2025-08-09 09:33:59'),
('ANN009', 'Youth Leadership Summit 2024', 'Join us for the annual Youth Leadership Summit on May 15-17, 2024. This event will bring together young leaders from all 33 barangays of San Jose, Batangas to discuss youth empowerment, community development, and governance.', 'Annual youth leadership event for San Jose, Batangas', 'event', 'published', '/images/youth-summit-2024.jpg', 'summit-guidelines.pdf', '/attachments/summit-guidelines.pdf', 1, 0, '2024-04-01 01:00:00', 'USR001', '2024-04-01 01:00:00', '2025-08-09 09:34:00'),
('ANN010', 'KK Survey Q2 2024 - Now Open!', 'The Katipunan ng Kabataan (KK) Survey for Q2 2024 is now open for all eligible youth aged 15-30. Your participation helps us understand youth needs and develop better programs.', 'Q2 2024 youth survey is now open for participation', 'survey', 'published', '/images/kk-survey-2024.jpg', NULL, NULL, 0, 1, '2024-04-01 02:00:00', 'USR001', '2024-04-01 02:00:00', '2025-08-09 09:34:00'),
('ANN011', 'New Youth Programs Available', 'We are excited to announce new youth programs including skills training, entrepreneurship workshops, and sports activities. Check our website for details and registration.', 'New youth programs and activities available', 'update', 'published', NULL, 'youth-programs-2024.pdf', '/attachments/youth-programs-2024.pdf', 0, 0, '2024-04-02 03:00:00', 'USR001', '2024-04-02 03:00:00', '2025-08-09 09:34:00'),
('ANN012', 'SK Officials Monthly Meeting', 'Monthly meeting for all SK Officials scheduled for April 25, 2024 at 2:00 PM. Agenda includes Q2 survey results and upcoming youth programs.', 'Monthly SK officials meeting on April 25', 'meeting', 'published', NULL, 'meeting-agenda.pdf', '/attachments/meeting-agenda.pdf', 0, 0, '2024-04-03 06:00:00', 'USR001', '2024-04-03 06:00:00', '2025-08-09 09:34:00'),
('ANN013', 'Youth Achievers Recognition 2024', 'Congratulations to our outstanding youth achievers! We will recognize exceptional young leaders who have made significant contributions to their communities.', 'Recognition program for outstanding youth', 'achievement', 'published', '/images/youth-achievers-2024.jpg', NULL, NULL, 0, 0, '2024-04-04 08:00:00', 'USR001', '2024-04-04 08:00:00', '2025-08-09 09:34:00'),
('ANN014', 'Upcoming Youth Festival', 'Planning for the annual youth festival is underway. This event will showcase youth talents and promote cultural awareness.', 'Annual youth festival planning in progress', 'event', 'draft', NULL, NULL, NULL, 0, 0, NULL, 'USR001', '2024-04-05 02:00:00', '2025-08-09 09:34:00');

-- --------------------------------------------------------

--
-- Table structure for table `barangay`
--

CREATE TABLE `barangay` (
  `barangay_id` varchar(20) NOT NULL,
  `barangay_name` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `barangay`
--

INSERT INTO `barangay` (`barangay_id`, `barangay_name`, `created_at`, `updated_at`) VALUES
('SJB001', 'Aguila', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB002', 'Anus', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB003', 'Aya', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB004', 'Bagong Pook', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB005', 'Balagtasin', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB006', 'Balagtasin I', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB007', 'Banaybanay I', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB008', 'Banaybanay II', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB009', 'Bigain I', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB010', 'Bigain II', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB011', 'Bigain South', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB012', 'Calansayan', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB013', 'Dagatan', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB014', 'Don Luis', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB015', 'Galamay-Amo', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB016', 'Lalayat', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB017', 'Lapolapo I', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB018', 'Lapolapo II', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB019', 'Lepute', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB020', 'Lumil', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB021', 'Mojon-Tampoy', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB022', 'Natunuan', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB023', 'Palanca', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB024', 'Pinagtung-ulan', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB025', 'Poblacion Barangay I', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB026', 'Poblacion Barangay II', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB027', 'Poblacion Barangay III', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB028', 'Poblacion Barangay IV', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB029', 'Sabang', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB030', 'Salaban', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB031', 'Santo Cristo', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB032', 'Taysan', '2025-08-09 09:32:40', '2025-08-09 09:32:40'),
('SJB033', 'Tugtug', '2025-08-09 09:32:40', '2025-08-09 09:32:40');

-- --------------------------------------------------------

--
-- Table structure for table `kk_survey_batches`
--

CREATE TABLE `kk_survey_batches` (
  `batch_id` varchar(20) NOT NULL,
  `batch_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `target_age_min` int(11) DEFAULT 15,
  `target_age_max` int(11) DEFAULT 30,
  `created_by` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `statistics_total_responses` int(11) DEFAULT 0,
  `statistics_validated_responses` int(11) DEFAULT 0,
  `statistics_rejected_responses` int(11) DEFAULT 0,
  `statistics_pending_responses` int(11) DEFAULT 0,
  `statistics_total_youths` int(11) DEFAULT 0,
  `statistics_total_youths_surveyed` int(11) DEFAULT 0,
  `statistics_total_youths_not_surveyed` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kk_survey_batches`
--

INSERT INTO `kk_survey_batches` (`batch_id`, `batch_name`, `description`, `start_date`, `end_date`, `target_age_min`, `target_age_max`, `created_by`, `created_at`, `updated_at`, `statistics_total_responses`, `statistics_validated_responses`, `statistics_rejected_responses`, `statistics_pending_responses`, `statistics_total_youths`, `statistics_total_youths_surveyed`, `statistics_total_youths_not_surveyed`) VALUES
('BAT001', 'KK Survey 2023 Q1', 'First quarter youth survey for 2023', '2023-01-01', '2023-03-31', 15, 30, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 5, 5, 0, 0, 15, 5, 10),
('BAT002', 'KK Survey 2023 Q2', 'Second quarter youth survey for 2023', '2023-04-01', '2023-06-30', 15, 30, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 2, 2, 0, 0, 15, 2, 13),
('BAT003', 'KK Survey 2024 Q1', 'First quarter youth survey for 2024', '2024-01-01', '2024-03-31', 15, 30, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 3, 3, 0, 0, 15, 3, 12),
('BAT004', 'KK Survey 2024 Q2', 'Second quarter youth survey for 2024 (Currently Active)', '2024-04-01', '2024-06-30', 15, 30, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 4, 2, 0, 2, 15, 4, 11),
('BAT005', 'KK Survey 2024 Q3', 'Third quarter youth survey for 2024 (Draft - No responses yet)', '2024-07-01', '2024-09-30', 15, 30, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0, 0, 0, 0, 15, 0, 15);

-- --------------------------------------------------------

--
-- Table structure for table `kk_survey_responses`
--

CREATE TABLE `kk_survey_responses` (
  `response_id` varchar(20) NOT NULL,
  `batch_id` varchar(20) NOT NULL,
  `youth_id` varchar(20) NOT NULL,
  `barangay_id` varchar(20) NOT NULL,
  `civil_status` enum('Single','Married','Widowed','Divorced','Separated','Annulled','Unknown','Live-in') DEFAULT NULL,
  `youth_classification` enum('In School Youth','Out of School Youth','Working Youth','Youth w/Specific Needs') NOT NULL,
  `youth_specific_needs` enum('Person w/Disability','Children in Conflict w/ Law','Indigenous People') DEFAULT NULL,
  `youth_age_group` enum('Child Youth (15-17 yrs old)','Core Youth (18-24 yrs old)','Young Adult (15-30 yrs old)') DEFAULT NULL,
  `educational_background` enum('Elementary Level','Elementary Grad','High School Level','High School Grad','Vocational Grad','College Level','College Grad','Masters Level','Masters Grad','Doctorate Level','Doctorate Graduate') DEFAULT NULL,
  `work_status` enum('Employed','Unemployed','Self-Employed','Currently looking for a Job','Not interested looking for a job') DEFAULT NULL,
  `registered_SK_voter` tinyint(1) DEFAULT NULL,
  `registered_national_voter` tinyint(1) DEFAULT NULL,
  `attended_KK_assembly` tinyint(1) DEFAULT NULL,
  `voted_last_SK` tinyint(1) DEFAULT NULL,
  `times_attended` enum('1-2 Times','3-4 Times','5 and above') DEFAULT NULL,
  `reason_not_attended` enum('There was no KK Assembly Meeting','Not interested to Attend') DEFAULT NULL,
  `validation_status` enum('pending','validated','rejected') DEFAULT 'pending',
  `validation_tier` enum('automatic','manual','final') DEFAULT 'automatic',
  `validated_by` varchar(20) DEFAULT NULL,
  `validation_date` timestamp NULL DEFAULT NULL,
  `validation_comments` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kk_survey_responses`
--

INSERT INTO `kk_survey_responses` (`response_id`, `batch_id`, `youth_id`, `barangay_id`, `civil_status`, `youth_classification`, `youth_specific_needs`, `youth_age_group`, `educational_background`, `work_status`, `registered_SK_voter`, `registered_national_voter`, `attended_KK_assembly`, `voted_last_SK`, `times_attended`, `reason_not_attended`, `validation_status`, `validation_tier`, `validated_by`, `validation_date`, `validation_comments`, `created_at`, `updated_at`) VALUES
('RES001', 'BAT001', 'YTH001', 'SJB001', 'Single', 'In School Youth', NULL, 'Core Youth (18-24 yrs old)', 'High School Level', 'Not interested looking for a job', 1, 1, 1, 1, '3-4 Times', NULL, 'validated', 'final', 'SK001', '2023-02-15 02:30:00', 'All information verified', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES002', 'BAT001', 'YTH002', 'SJB001', 'Single', 'In School Youth', NULL, 'Core Youth (18-24 yrs old)', 'College Level', 'Not interested looking for a job', 1, 1, 1, 1, '5 and above', NULL, 'validated', 'final', 'SK001', '2023-02-16 06:20:00', 'Complete and accurate', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES003', 'BAT001', 'YTH003', 'SJB001', 'Single', 'Working Youth', NULL, 'Core Youth (18-24 yrs old)', 'College Grad', 'Employed', 1, 1, 0, 0, NULL, 'Not interested to Attend', 'validated', 'final', 'SK001', '2023-02-17 01:15:00', 'Employment verified', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES004', 'BAT001', 'YTH006', 'SJB002', 'Single', 'In School Youth', NULL, 'Core Youth (18-24 yrs old)', 'High School Level', 'Not interested looking for a job', 1, 1, 1, 1, '1-2 Times', NULL, 'validated', 'final', 'SK002', '2023-02-18 03:45:00', 'Valid response', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES005', 'BAT001', 'YTH007', 'SJB002', 'Single', 'Out of School Youth', NULL, 'Core Youth (18-24 yrs old)', 'High School Grad', 'Currently looking for a Job', 1, 1, 0, 0, NULL, 'There was no KK Assembly Meeting', 'validated', 'final', 'SK002', '2023-02-19 08:30:00', 'Job search status confirmed', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES006', 'BAT002', 'YTH004', 'SJB001', 'Single', 'Working Youth', NULL, 'Young Adult (15-30 yrs old)', 'College Grad', 'Employed', 1, 1, 1, 1, '3-4 Times', NULL, 'validated', 'final', 'SK001', '2023-05-10 05:20:00', 'Employment verified', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES007', 'BAT002', 'YTH008', 'SJB002', 'Single', 'In School Youth', NULL, 'Core Youth (18-24 yrs old)', 'College Level', 'Not interested looking for a job', 1, 1, 1, 1, '5 and above', NULL, 'validated', 'final', 'SK002', '2023-05-11 02:15:00', 'Complete information', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES008', 'BAT003', 'YTH005', 'SJB001', 'Single', 'Working Youth', NULL, 'Young Adult (15-30 yrs old)', 'College Grad', 'Self-Employed', 1, 1, 1, 1, '5 and above', NULL, 'validated', 'final', 'SK001', '2024-02-20 06:45:00', 'Self-employment verified', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES009', 'BAT003', 'YTH009', 'SJB002', 'Single', 'In School Youth', NULL, 'Core Youth (18-24 yrs old)', 'College Level', 'Not interested looking for a job', 1, 1, 1, 1, '3-4 Times', NULL, 'validated', 'final', 'SK002', '2024-02-21 03:30:00', 'Valid response', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES010', 'BAT003', 'YTH011', 'SJB003', 'Single', 'In School Youth', NULL, 'Core Youth (18-24 yrs old)', 'High School Level', 'Not interested looking for a job', 1, 1, 1, 1, '1-2 Times', NULL, 'validated', 'final', 'SK003', '2024-02-22 01:20:00', 'Complete information', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES011', 'BAT004', 'YTH012', 'SJB003', 'Single', 'In School Youth', NULL, 'Core Youth (18-24 yrs old)', 'College Level', 'Not interested looking for a job', 1, 1, 1, 1, '3-4 Times', NULL, 'validated', 'manual', 'SK003', '2024-04-15 07:30:00', 'Pending final review', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES012', 'BAT004', 'YTH013', 'SJB003', 'Single', 'Working Youth', NULL, 'Core Youth (18-24 yrs old)', 'College Grad', 'Employed', 1, 1, 0, 0, NULL, 'Not interested to Attend', 'validated', 'manual', 'SK003', '2024-04-16 02:45:00', 'Employment verified', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES013', 'BAT004', 'YTH014', 'SJB003', 'Single', 'Out of School Youth', NULL, 'Young Adult (15-30 yrs old)', 'High School Grad', 'Currently looking for a Job', 1, 1, 0, 0, NULL, 'There was no KK Assembly Meeting', 'pending', 'automatic', NULL, NULL, NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('RES014', 'BAT004', 'YTH015', 'SJB003', 'Single', 'In School Youth', NULL, 'Core Youth (18-24 yrs old)', 'High School Level', 'Not interested looking for a job', 1, 1, 1, 1, '1-2 Times', NULL, 'pending', 'automatic', NULL, NULL, NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59');

-- --------------------------------------------------------

--
-- Table structure for table `lydo`
--

CREATE TABLE `lydo` (
  `lydo_id` varchar(20) NOT NULL,
  `role_id` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `personal_email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `email_verified` tinyint(1) DEFAULT 0,
  `created_by` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deactivated` tinyint(1) DEFAULT 0,
  `deactivated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lydo`
--

INSERT INTO `lydo` (`lydo_id`, `role_id`, `email`, `personal_email`, `password_hash`, `first_name`, `last_name`, `middle_name`, `suffix`, `profile_picture`, `is_active`, `email_verified`, `created_by`, `created_at`, `updated_at`, `deactivated`, `deactivated_at`) VALUES
('LYDO001', 'ROL001', 'admin@youthgovernance.com', 'admin.personal@email.com', '$2b$10$hashedpasswordhere', 'Maria', 'Santos', 'Garcia', 'Dr.', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0, NULL),
('LYDO002', 'ROL002', 'staff1@youthgovernance.com', 'staff1.personal@email.com', '$2b$10$hashedpasswordhere', 'Juan', 'Cruz', 'Dela', 'Jr.', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0, NULL),
('LYDO003', 'ROL002', 'staff2@youthgovernance.com', 'staff2.personal@email.com', '$2b$10$hashedpasswordhere', 'Ana', 'Reyes', 'Santos', '', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0, NULL),
('LYDO004', 'ROL002', 'staff3@youthgovernance.com', 'staff3.personal@email.com', '$2b$10$hashedpasswordhere', 'Pedro', 'Mendoza', 'Lopez', 'III', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0, NULL),
('LYDO005', 'ROL002', 'staff4@youthgovernance.com', 'staff4.personal@email.com', '$2b$10$hashedpasswordhere', 'Carmen', 'Villanueva', 'Torres', '', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0, NULL),
('LYDO006', 'ROL002', 'staff5@youthgovernance.com', 'staff5.personal@email.com', '$2b$10$hashedpasswordhere', 'Roberto', 'Aquino', 'Fernandez', 'Sr.', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `notification_id` varchar(20) NOT NULL,
  `user_id` varchar(20) DEFAULT NULL,
  `user_type` enum('admin','lydo_staff','sk_official','youth','all') DEFAULT NULL,
  `barangay_id` varchar(20) DEFAULT NULL,
  `title` varchar(200) NOT NULL,
  `message` text NOT NULL,
  `type` enum('info','success','warning','error','announcement','survey_reminder','validation_needed','sk_term_end','kk_batch_end') DEFAULT 'info',
  `priority` enum('low','normal','high','urgent') DEFAULT 'normal',
  `is_read` tinyint(1) DEFAULT 0,
  `read_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_by` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`notification_id`, `user_id`, `user_type`, `barangay_id`, `title`, `message`, `type`, `priority`, `is_read`, `read_at`, `expires_at`, `created_by`, `created_at`) VALUES
('NOT001', 'USR007', 'sk_official', NULL, 'New Survey Response', 'You have a new survey response to validate from Barangay Aguila', 'validation_needed', 'normal', 0, NULL, '2024-12-31 15:59:59', 'USR001', '2024-04-15 02:00:00'),
('NOT002', 'USR008', 'sk_official', NULL, 'Survey Reminder', 'Reminder: Complete validation of pending responses in your barangay', 'survey_reminder', 'normal', 0, NULL, '2024-12-31 15:59:59', 'USR001', '2024-04-16 01:00:00'),
('NOT003', NULL, 'sk_official', 'SJB001', 'Barangay Meeting', 'SK meeting scheduled for Barangay Aguila on April 20, 2024', 'announcement', 'high', 0, NULL, '2024-04-20 15:59:59', 'USR001', '2024-04-15 06:00:00'),
('NOT004', NULL, 'sk_official', 'SJB002', 'Validation Deadline', 'Survey validation deadline for Barangay Anus: April 25, 2024', '', 'urgent', 0, NULL, '2024-04-25 15:59:59', 'USR001', '2024-04-16 03:00:00'),
('NOT005', NULL, 'lydo_staff', NULL, 'Monthly Report Due', 'Monthly youth survey report is due by April 30, 2024', '', 'high', 0, NULL, '2024-04-30 15:59:59', 'USR001', '2024-04-17 00:00:00'),
('NOT006', NULL, 'youth', NULL, 'Survey Open', 'New KK Survey is now open for Q2 2024. Please participate!', 'survey_reminder', 'normal', 0, NULL, '2024-06-30 15:59:59', 'USR001', '2024-04-18 02:00:00'),
('NOT007', NULL, 'all', NULL, 'System Maintenance', 'System will be under maintenance on April 22, 2024 from 2:00 AM to 4:00 AM', 'info', 'normal', 0, NULL, '2024-04-21 20:00:00', 'USR001', '2024-04-19 07:00:00'),
('NOT008', 'USR009', 'sk_official', NULL, 'New Survey Response', 'You have a new survey response to validate from Barangay Aya', 'validation_needed', 'normal', 0, NULL, '2024-12-31 15:59:59', 'USR001', '2024-04-17 02:00:00'),
('NOT009', 'USR010', 'sk_official', NULL, 'Survey Reminder', 'Reminder: Complete validation of pending responses in your barangay', 'survey_reminder', 'normal', 0, NULL, '2024-12-31 15:59:59', 'USR001', '2024-04-18 01:00:00'),
('NOT010', NULL, 'sk_official', 'SJB003', 'Barangay Meeting', 'SK meeting scheduled for Barangay Aya on April 22, 2024', 'announcement', 'high', 0, NULL, '2024-04-22 15:59:59', 'USR001', '2024-04-18 06:00:00'),
('NOT011', NULL, 'youth', NULL, 'Youth Month Registration', 'Registration for Youth Month 2024 events is now open. Secure your spot!', '', 'normal', 0, NULL, '2024-05-31 15:59:59', 'USR001', '2024-04-19 02:00:00'),
('NOT012', NULL, 'all', NULL, 'Youth Month 2024', 'Youth Month 2024 celebration starts June 1st. Join us for exciting events!', 'announcement', 'normal', 0, NULL, '2024-06-30 15:59:59', 'USR001', '2024-04-20 07:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `role_id` varchar(20) NOT NULL,
  `role_name` varchar(50) NOT NULL,
  `role_description` text DEFAULT NULL,
  `permissions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`permissions`)),
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`role_id`, `role_name`, `role_description`, `permissions`, `is_active`, `created_at`, `updated_at`) VALUES
('ROL001', 'admin', 'System Administrator with full access', '{\"dashboard\": true, \"users\": true, \"surveys\": true, \"reports\": true, \"settings\": true, \"barangay_management\": true, \"role_management\": true, \"validation\": true, \"analytics\": true, \"notifications\": true, \"activity_logs\": true}', 1, '2025-08-09 09:32:39', '2025-08-09 09:32:39'),
('ROL002', 'lydo_staff', 'LYDO Staff with administrative access', '{\"dashboard\": true, \"surveys\": true, \"reports\": true, \"validation\": true, \"barangay_view\": true, \"analytics\": true, \"notifications\": true, \"activity_logs\": true}', 1, '2025-08-09 09:32:39', '2025-08-09 09:32:39'),
('ROL003', 'sk_official', 'SK Official with barangay-level access', '{\"dashboard\": true, \"validation\": true, \"reports\": true, \"barangay_limited\": true, \"notifications\": true}', 1, '2025-08-09 09:32:39', '2025-08-09 09:32:39'),
('ROL004', 'youth', 'Youth participant with survey access only', '{\"survey_participation\": true, \"view_own_data\": true, \"notifications\": true}', 1, '2025-08-09 09:32:39', '2025-08-09 09:32:39');

-- --------------------------------------------------------

--
-- Table structure for table `sk_officials`
--

CREATE TABLE `sk_officials` (
  `sk_id` varchar(20) NOT NULL,
  `role_id` varchar(20) NOT NULL,
  `term_id` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `personal_email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `barangay_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `position` enum('SK Chairperson','SK Secretary','SK Treasurer','SK Councilor') NOT NULL,
  `profile_picture` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `email_verified` tinyint(1) DEFAULT 0,
  `created_by` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sk_officials`
--

INSERT INTO `sk_officials` (`sk_id`, `role_id`, `term_id`, `email`, `personal_email`, `password_hash`, `barangay_id`, `first_name`, `last_name`, `middle_name`, `suffix`, `position`, `profile_picture`, `is_active`, `email_verified`, `created_by`, `created_at`, `updated_at`) VALUES
('SK001', 'ROL003', 'TRM002', 'sk.aguila@youthgovernance.com', 'sk.aguila.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB001', 'Miguel', 'Santos', 'Dela', 'Jr.', 'SK Chairperson', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('SK002', 'ROL003', 'TRM002', 'sk.anus@youthgovernance.com', 'sk.anus.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB002', 'Sofia', 'Cruz', 'Reyes', '', 'SK Secretary', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('SK003', 'ROL003', 'TRM002', 'sk.aya@youthgovernance.com', 'sk.aya.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB003', 'Luis', 'Mendoza', 'Lopez', 'III', 'SK Treasurer', NULL, 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('SK004', 'ROL003', 'TRM001', 'sk.bagongpook@youthgovernance.com', 'sk.bagongpook.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB004', 'Isabella', 'Villanueva', 'Torres', '', 'SK Chairperson', NULL, 0, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('SK005', 'ROL003', 'TRM001', 'sk.balagtasin@youthgovernance.com', 'sk.balagtasin.personal@email.com', '$2b$10$hashedpasswordhere', 'SJB005', 'Diego', 'Aquino', 'Fernandez', 'Sr.', 'SK Secretary', NULL, 0, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59');

-- --------------------------------------------------------

--
-- Table structure for table `sk_officials_profiling`
--

CREATE TABLE `sk_officials_profiling` (
  `profiling_id` varchar(20) NOT NULL,
  `sk_id` varchar(20) NOT NULL,
  `birth_date` date NOT NULL,
  `age` int(11) NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `school_or_company` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `performance_metrics_survey_validated` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sk_officials_profiling`
--

INSERT INTO `sk_officials_profiling` (`profiling_id`, `sk_id`, `birth_date`, `age`, `gender`, `contact_number`, `school_or_company`, `created_at`, `updated_at`, `performance_metrics_survey_validated`) VALUES
('PRO001', 'SK001', '2000-03-15', 24, 'Male', '+639151234567', 'San Jose National High School', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 45),
('PRO002', 'SK002', '1999-07-22', 25, 'Female', '+639151234568', 'Batangas State University', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 38),
('PRO003', 'SK003', '2001-11-08', 23, 'Male', '+639151234569', 'San Jose College', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 42),
('PRO004', 'SK004', '1998-05-12', 26, 'Female', '+639151234570', 'University of Batangas', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0),
('PRO005', 'SK005', '1997-09-30', 27, 'Male', '+639151234571', 'Lyceum of the Philippines', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0);

-- --------------------------------------------------------

--
-- Table structure for table `sk_terms`
--

CREATE TABLE `sk_terms` (
  `term_id` varchar(20) NOT NULL,
  `term_name` varchar(100) NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','completed','upcoming') DEFAULT 'upcoming',
  `is_active` tinyint(1) DEFAULT 1,
  `is_current` tinyint(1) DEFAULT 0,
  `created_by` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `statistics_total_officials` int(11) DEFAULT 0,
  `statistics_active_officials` int(11) DEFAULT 0,
  `statistics_inactive_officials` int(11) DEFAULT 0,
  `statistics_total_sk_chairperson` int(11) DEFAULT 0,
  `statistics_total_sk_secretary` int(11) DEFAULT 0,
  `statistics_total_sk_treasurer` int(11) DEFAULT 0,
  `statistics_total_sk_councilor` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sk_terms`
--

INSERT INTO `sk_terms` (`term_id`, `term_name`, `start_date`, `end_date`, `status`, `is_active`, `is_current`, `created_by`, `created_at`, `updated_at`, `statistics_total_officials`, `statistics_active_officials`, `statistics_inactive_officials`, `statistics_total_sk_chairperson`, `statistics_total_sk_secretary`, `statistics_total_sk_treasurer`, `statistics_total_sk_councilor`) VALUES
('TRM001', '2023-2025 Term', '2023-06-30', '2025-06-30', 'completed', 1, 0, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 2, 0, 2, 1, 1, 0, 0),
('TRM002', '2025-2027 Term', '2025-06-30', '2027-06-30', 'active', 1, 1, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 3, 3, 0, 1, 1, 1, 0),
('TRM003', '2027-2029 Term', '2027-06-30', '2029-06-30', 'upcoming', 1, 0, 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59', 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` varchar(20) NOT NULL,
  `user_type` enum('admin','lydo_staff','sk_official','youth') NOT NULL,
  `lydo_id` varchar(20) DEFAULT NULL,
  `sk_id` varchar(20) DEFAULT NULL,
  `youth_id` varchar(20) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `user_type`, `lydo_id`, `sk_id`, `youth_id`, `created_at`, `updated_at`) VALUES
('USR001', 'admin', 'LYDO001', NULL, NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR002', 'lydo_staff', 'LYDO002', NULL, NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR003', 'lydo_staff', 'LYDO003', NULL, NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR004', 'lydo_staff', 'LYDO004', NULL, NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR005', 'lydo_staff', 'LYDO005', NULL, NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR006', 'lydo_staff', 'LYDO006', NULL, NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR007', 'sk_official', NULL, 'SK001', NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR008', 'sk_official', NULL, 'SK002', NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR009', 'sk_official', NULL, 'SK003', NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR010', 'sk_official', NULL, 'SK004', NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR011', 'sk_official', NULL, 'SK005', NULL, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR012', 'youth', NULL, NULL, 'YTH001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR013', 'youth', NULL, NULL, 'YTH002', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR014', 'youth', NULL, NULL, 'YTH003', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR015', 'youth', NULL, NULL, 'YTH004', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR016', 'youth', NULL, NULL, 'YTH005', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR017', 'youth', NULL, NULL, 'YTH006', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR018', 'youth', NULL, NULL, 'YTH007', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR019', 'youth', NULL, NULL, 'YTH008', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR020', 'youth', NULL, NULL, 'YTH009', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR021', 'youth', NULL, NULL, 'YTH010', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR022', 'youth', NULL, NULL, 'YTH011', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR023', 'youth', NULL, NULL, 'YTH012', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR024', 'youth', NULL, NULL, 'YTH013', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR025', 'youth', NULL, NULL, 'YTH014', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('USR026', 'youth', NULL, NULL, 'YTH015', '2025-08-09 09:33:59', '2025-08-09 09:33:59');

-- --------------------------------------------------------

--
-- Table structure for table `validation_logs`
--

CREATE TABLE `validation_logs` (
  `log_id` varchar(20) NOT NULL,
  `response_id` varchar(20) NOT NULL,
  `validated_by` varchar(20) NOT NULL,
  `validation_action` enum('validate','reject') NOT NULL,
  `validation_tier` enum('automatic','manual','final') NOT NULL,
  `validation_comments` text DEFAULT NULL,
  `validation_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `validation_logs`
--

INSERT INTO `validation_logs` (`log_id`, `response_id`, `validated_by`, `validation_action`, `validation_tier`, `validation_comments`, `validation_date`) VALUES
('LOG001', 'RES001', 'SK001', 'validate', 'final', 'All information verified and accurate', '2023-02-15 02:30:00'),
('LOG002', 'RES002', 'SK001', 'validate', 'final', 'Complete and accurate response', '2023-02-16 06:20:00'),
('LOG003', 'RES003', 'SK001', 'validate', 'final', 'Employment status verified', '2023-02-17 01:15:00'),
('LOG004', 'RES004', 'SK002', 'validate', 'final', 'Valid response from youth', '2023-02-18 03:45:00'),
('LOG005', 'RES005', 'SK002', 'validate', 'final', 'Job search status confirmed', '2023-02-19 08:30:00'),
('LOG006', 'RES006', 'SK001', 'validate', 'final', 'Employment verified', '2023-05-10 05:20:00'),
('LOG007', 'RES007', 'SK002', 'validate', 'final', 'Complete information provided', '2023-05-11 02:15:00'),
('LOG008', 'RES008', 'SK001', 'validate', 'final', 'Self-employment verified', '2024-02-20 06:45:00'),
('LOG009', 'RES009', 'SK002', 'validate', 'final', 'Valid response', '2024-02-21 03:30:00'),
('LOG010', 'RES010', 'SK003', 'validate', 'final', 'Complete information', '2024-02-22 01:20:00'),
('LOG011', 'RES011', 'SK003', 'validate', 'manual', 'Pending final review', '2024-04-15 07:30:00'),
('LOG012', 'RES012', 'SK003', 'validate', 'manual', 'Employment verified', '2024-04-16 02:45:00'),
('LOG013', 'RES001', 'SK001', 'validate', 'manual', 'All information verified and correct', '2023-02-15 02:30:00'),
('LOG014', 'RES002', 'SK001', 'validate', 'manual', 'Survey response validated', '2023-02-16 06:20:00'),
('LOG015', 'RES003', 'SK002', 'validate', 'manual', 'Information confirmed with youth', '2023-02-17 01:15:00'),
('LOG016', 'RES004', 'SK002', 'reject', 'manual', 'Incomplete information, needs resubmission', '2023-02-18 03:45:00'),
('LOG017', 'RES005', 'SK003', 'validate', 'manual', 'Survey validated successfully', '2023-02-19 08:30:00'),
('LOG018', 'RES006', 'SK001', 'validate', 'manual', 'Validated after review', '2023-05-10 05:20:00'),
('LOG019', 'RES007', 'SK002', 'validate', 'manual', 'All information correct', '2023-05-11 02:15:00'),
('LOG020', 'RES008', 'SK001', 'validate', 'manual', 'Survey validated', '2024-02-20 06:45:00'),
('LOG021', 'RES009', 'SK002', 'validate', 'manual', 'Response validated', '2024-02-21 03:30:00'),
('LOG022', 'RES010', 'SK003', 'validate', 'manual', 'Complete information', '2024-02-22 01:20:00'),
('LOG023', 'RES011', 'SK003', 'validate', 'manual', 'Pending final review', '2024-04-15 07:30:00'),
('LOG024', 'RES012', 'SK003', 'validate', 'manual', 'Employment verified', '2024-04-16 02:45:00');

-- --------------------------------------------------------

--
-- Table structure for table `voters_list`
--

CREATE TABLE `voters_list` (
  `voter_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `birth_date` date NOT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  `created_by` varchar(20) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `voters_list`
--

INSERT INTO `voters_list` (`voter_id`, `first_name`, `last_name`, `middle_name`, `suffix`, `birth_date`, `gender`, `created_by`, `created_at`, `updated_at`) VALUES
('VOT001', 'Maria', 'Santos', 'Garcia', '', '2005-03-15', 'Female', 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('VOT002', 'Jose', 'Cruz', 'Reyes', 'Jr.', '2004-07-22', 'Male', 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('VOT003', 'Ana', 'Mendoza', 'Lopez', '', '2003-11-08', 'Female', 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('VOT004', 'Pedro', 'Villanueva', 'Torres', 'III', '2002-05-12', 'Male', 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('VOT005', 'Carmen', 'Aquino', 'Fernandez', '', '2001-09-30', 'Female', 'LYDO001', '2025-08-09 09:33:59', '2025-08-09 09:33:59');

-- --------------------------------------------------------

--
-- Table structure for table `youth_profiling`
--

CREATE TABLE `youth_profiling` (
  `youth_id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `middle_name` varchar(50) DEFAULT NULL,
  `suffix` varchar(50) DEFAULT NULL,
  `region` varchar(50) NOT NULL DEFAULT 'Region IV-A (CALABARZON)',
  `province` varchar(50) NOT NULL DEFAULT 'Batangas',
  `municipality` varchar(50) NOT NULL DEFAULT 'San Jose',
  `barangay_id` varchar(20) NOT NULL,
  `purok_zone` varchar(50) DEFAULT NULL,
  `birth_date` date NOT NULL,
  `age` int(11) NOT NULL,
  `gender` enum('Male','Female') NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `youth_profiling`
--

INSERT INTO `youth_profiling` (`youth_id`, `first_name`, `last_name`, `middle_name`, `suffix`, `region`, `province`, `municipality`, `barangay_id`, `purok_zone`, `birth_date`, `age`, `gender`, `contact_number`, `email`, `is_active`, `created_at`, `updated_at`) VALUES
('YTH001', 'Maria', 'Garcia', 'Santos', '', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB001', 'Zone 1', '2006-03-15', 18, 'Female', '+639151234572', 'maria.garcia@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH002', 'Jose', 'Reyes', 'Cruz', 'Jr.', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB001', 'Zone 2', '2005-07-22', 19, 'Male', '+639151234573', 'jose.reyes@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH003', 'Ana', 'Lopez', 'Mendoza', '', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB001', 'Zone 3', '2004-11-08', 20, 'Female', '+639151234574', 'ana.lopez@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH004', 'Pedro', 'Torres', 'Villanueva', 'III', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB001', 'Zone 1', '2003-05-12', 21, 'Male', '+639151234575', 'pedro.torres@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH005', 'Carmen', 'Fernandez', 'Aquino', '', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB001', 'Zone 2', '2002-09-30', 22, 'Female', '+639151234576', 'carmen.fernandez@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH006', 'Roberto', 'Santos', 'Garcia', 'Sr.', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB002', 'Zone 1', '2006-01-15', 18, 'Male', '+639151234577', 'roberto.santos@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH007', 'Lucia', 'Cruz', 'Reyes', '', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB002', 'Zone 2', '2005-04-22', 19, 'Female', '+639151234578', 'lucia.cruz@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH008', 'Fernando', 'Mendoza', 'Lopez', 'Jr.', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB002', 'Zone 3', '2004-08-08', 20, 'Male', '+639151234579', 'fernando.mendoza@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH009', 'Elena', 'Villanueva', 'Torres', '', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB002', 'Zone 1', '2003-12-12', 21, 'Female', '+639151234580', 'elena.villanueva@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH010', 'Carlos', 'Aquino', 'Fernandez', 'III', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB002', 'Zone 2', '2002-06-30', 22, 'Male', '+639151234581', 'carlos.aquino@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH011', 'Isabella', 'Garcia', 'Santos', '', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB003', 'Zone 1', '2006-02-15', 18, 'Female', '+639151234582', 'isabella.garcia@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH012', 'Manuel', 'Reyes', 'Cruz', 'Jr.', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB003', 'Zone 2', '2005-06-22', 19, 'Male', '+639151234583', 'manuel.reyes@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH013', 'Rosa', 'Lopez', 'Mendoza', '', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB003', 'Zone 3', '2004-10-08', 20, 'Female', '+639151234584', 'rosa.lopez@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH014', 'Antonio', 'Torres', 'Villanueva', 'III', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB003', 'Zone 1', '2003-04-12', 21, 'Male', '+639151234585', 'antonio.torres@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59'),
('YTH015', 'Patricia', 'Fernandez', 'Aquino', '', 'Region IV-A (CALABARZON)', 'Batangas', 'San Jose', 'SJB003', 'Zone 2', '2002-08-30', 22, 'Female', '+639151234586', 'patricia.fernandez@email.com', 1, '2025-08-09 09:33:59', '2025-08-09 09:33:59');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_user_type` (`user_type`),
  ADD KEY `idx_action` (`action`),
  ADD KEY `idx_resource` (`resource_type`,`resource_id`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `announcements`
--
ALTER TABLE `announcements`
  ADD PRIMARY KEY (`announcement_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_is_featured` (`is_featured`),
  ADD KEY `idx_is_pinned` (`is_pinned`),
  ADD KEY `idx_category` (`category`),
  ADD KEY `idx_published_at` (`published_at`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `barangay`
--
ALTER TABLE `barangay`
  ADD PRIMARY KEY (`barangay_id`),
  ADD UNIQUE KEY `barangay_name` (`barangay_name`),
  ADD KEY `idx_barangay_name` (`barangay_name`);

--
-- Indexes for table `kk_survey_batches`
--
ALTER TABLE `kk_survey_batches`
  ADD PRIMARY KEY (`batch_id`),
  ADD KEY `idx_dates` (`start_date`,`end_date`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- Indexes for table `kk_survey_responses`
--
ALTER TABLE `kk_survey_responses`
  ADD PRIMARY KEY (`response_id`),
  ADD KEY `validated_by` (`validated_by`),
  ADD KEY `idx_batch_id` (`batch_id`),
  ADD KEY `idx_youth_id` (`youth_id`),
  ADD KEY `idx_barangay_id` (`barangay_id`),
  ADD KEY `idx_validation_status` (`validation_status`),
  ADD KEY `idx_validation_tier` (`validation_tier`),
  ADD KEY `idx_created_at` (`created_at`);

--
-- Indexes for table `lydo`
--
ALTER TABLE `lydo`
  ADD PRIMARY KEY (`lydo_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `personal_email` (`personal_email`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role_id` (`role_id`),
  ADD KEY `idx_active` (`is_active`),
  ADD KEY `idx_created_by` (`created_by`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_user_id` (`user_id`),
  ADD KEY `idx_user_type` (`user_type`),
  ADD KEY `idx_barangay_id` (`barangay_id`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_priority` (`priority`),
  ADD KEY `idx_is_read` (`is_read`),
  ADD KEY `idx_created_at` (`created_at`),
  ADD KEY `idx_expires_at` (`expires_at`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`role_id`),
  ADD UNIQUE KEY `role_name` (`role_name`),
  ADD KEY `idx_role_name` (`role_name`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `sk_officials`
--
ALTER TABLE `sk_officials`
  ADD PRIMARY KEY (`sk_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `personal_email` (`personal_email`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_full_name` (`last_name`,`first_name`,`middle_name`,`suffix`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_role_id` (`role_id`),
  ADD KEY `idx_barangay_id` (`barangay_id`),
  ADD KEY `idx_term_id` (`term_id`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `sk_officials_profiling`
--
ALTER TABLE `sk_officials_profiling`
  ADD PRIMARY KEY (`profiling_id`),
  ADD UNIQUE KEY `contact_number` (`contact_number`),
  ADD KEY `idx_sk_id` (`sk_id`);

--
-- Indexes for table `sk_terms`
--
ALTER TABLE `sk_terms`
  ADD PRIMARY KEY (`term_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_term_name` (`term_name`),
  ADD KEY `idx_dates` (`start_date`,`end_date`),
  ADD KEY `idx_status` (`status`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `idx_user_type` (`user_type`),
  ADD KEY `idx_lydo_id` (`lydo_id`),
  ADD KEY `idx_sk_id` (`sk_id`),
  ADD KEY `idx_youth_id` (`youth_id`);

--
-- Indexes for table `validation_logs`
--
ALTER TABLE `validation_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `idx_response_id` (`response_id`),
  ADD KEY `idx_validated_by` (`validated_by`),
  ADD KEY `idx_validation_action` (`validation_action`),
  ADD KEY `idx_validation_date` (`validation_date`);

--
-- Indexes for table `voters_list`
--
ALTER TABLE `voters_list`
  ADD PRIMARY KEY (`voter_id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `idx_name` (`first_name`,`last_name`);

--
-- Indexes for table `youth_profiling`
--
ALTER TABLE `youth_profiling`
  ADD PRIMARY KEY (`youth_id`),
  ADD UNIQUE KEY `contact_number` (`contact_number`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idx_barangay_id` (`barangay_id`),
  ADD KEY `idx_age` (`age`),
  ADD KEY `idx_active` (`is_active`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `activity_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE SET NULL;

--
-- Constraints for table `announcements`
--
ALTER TABLE `announcements`
  ADD CONSTRAINT `announcements_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `kk_survey_batches`
--
ALTER TABLE `kk_survey_batches`
  ADD CONSTRAINT `kk_survey_batches_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `lydo` (`lydo_id`);

--
-- Constraints for table `kk_survey_responses`
--
ALTER TABLE `kk_survey_responses`
  ADD CONSTRAINT `kk_survey_responses_ibfk_1` FOREIGN KEY (`batch_id`) REFERENCES `kk_survey_batches` (`batch_id`),
  ADD CONSTRAINT `kk_survey_responses_ibfk_2` FOREIGN KEY (`youth_id`) REFERENCES `youth_profiling` (`youth_id`),
  ADD CONSTRAINT `kk_survey_responses_ibfk_3` FOREIGN KEY (`barangay_id`) REFERENCES `barangay` (`barangay_id`),
  ADD CONSTRAINT `kk_survey_responses_ibfk_4` FOREIGN KEY (`validated_by`) REFERENCES `sk_officials` (`sk_id`) ON DELETE SET NULL;

--
-- Constraints for table `lydo`
--
ALTER TABLE `lydo`
  ADD CONSTRAINT `lydo_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  ADD CONSTRAINT `lydo_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `lydo` (`lydo_id`);

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`barangay_id`) REFERENCES `barangay` (`barangay_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_3` FOREIGN KEY (`created_by`) REFERENCES `users` (`user_id`) ON DELETE CASCADE;

--
-- Constraints for table `sk_officials`
--
ALTER TABLE `sk_officials`
  ADD CONSTRAINT `sk_officials_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`),
  ADD CONSTRAINT `sk_officials_ibfk_2` FOREIGN KEY (`barangay_id`) REFERENCES `barangay` (`barangay_id`),
  ADD CONSTRAINT `sk_officials_ibfk_3` FOREIGN KEY (`term_id`) REFERENCES `sk_terms` (`term_id`),
  ADD CONSTRAINT `sk_officials_ibfk_4` FOREIGN KEY (`created_by`) REFERENCES `lydo` (`lydo_id`);

--
-- Constraints for table `sk_officials_profiling`
--
ALTER TABLE `sk_officials_profiling`
  ADD CONSTRAINT `sk_officials_profiling_ibfk_1` FOREIGN KEY (`sk_id`) REFERENCES `sk_officials` (`sk_id`) ON DELETE CASCADE;

--
-- Constraints for table `sk_terms`
--
ALTER TABLE `sk_terms`
  ADD CONSTRAINT `sk_terms_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `lydo` (`lydo_id`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`lydo_id`) REFERENCES `lydo` (`lydo_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`sk_id`) REFERENCES `sk_officials` (`sk_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`youth_id`) REFERENCES `youth_profiling` (`youth_id`) ON DELETE CASCADE;

--
-- Constraints for table `validation_logs`
--
ALTER TABLE `validation_logs`
  ADD CONSTRAINT `validation_logs_ibfk_1` FOREIGN KEY (`response_id`) REFERENCES `kk_survey_responses` (`response_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `validation_logs_ibfk_2` FOREIGN KEY (`validated_by`) REFERENCES `sk_officials` (`sk_id`);

--
-- Constraints for table `voters_list`
--
ALTER TABLE `voters_list`
  ADD CONSTRAINT `voters_list_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `lydo` (`lydo_id`);

--
-- Constraints for table `youth_profiling`
--
ALTER TABLE `youth_profiling`
  ADD CONSTRAINT `youth_profiling_ibfk_1` FOREIGN KEY (`barangay_id`) REFERENCES `barangay` (`barangay_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
