# Youth Governance App Database Documentation

## Table of Contents
1. [Database Overview](#database-overview)
2. [Table Definitions](#table-definitions)
3. [Relationships & Foreign Keys](#relationships--foreign-keys)
4. [Indexes & Performance](#indexes--performance)
5. [Data Types & Constraints](#data-types--constraints)
6. [Sample Data & Queries](#sample-data--queries)

## Database Overview

**Purpose:** Youth Governance App for San Jose, Batangas  
**Database Type:** MySQL/MariaDB  
**Tables:** 15  
**Total Indexes:** 50+  
**User Types:** Admin, LYDO Staff, SK Officials, Youth  

### Core Features
- Multi-role user management
- Geographic management (33 barangays)
- SK term management with statistics
- Survey system with validation workflows
- Notification and announcement systems
- Comprehensive audit trails

## Table Definitions

### 1. Barangay Table
**Purpose:** Geographic management of San Jose, Batangas barangays

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `barangay_id` | VARCHAR(20) | PRIMARY KEY | Unique identifier (e.g., 'SJB001') |
| `barangay_name` | VARCHAR(100) | NOT NULL, UNIQUE | Barangay name |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |

**Indexes:**
- `idx_barangay_name (barangay_name)`

**Sample Data:** 33 barangays (SJB001-Aguila to SJB033-Tugtug)

---

### 2. Roles Table
**Purpose:** Role-based access control with JSON permissions

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `role_id` | VARCHAR(20) | PRIMARY KEY | Role identifier (e.g., 'ROL001') |
| `role_name` | VARCHAR(50) | NOT NULL, UNIQUE | Role name |
| `role_description` | TEXT | NULL | Role description |
| `permissions` | JSON | NULL | JSON permissions object |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |

**Indexes:**
- `idx_role_name (role_name)`
- `idx_active (is_active)`

**Available Roles:**
- **ROL001**: admin (Full system access)
- **ROL002**: lydo_staff (Administrative access)
- **ROL003**: sk_official (Barangay-level access)
- **ROL004**: youth (Survey participation only)

---

### 3. LYDO Table
**Purpose:** Admin and LYDO staff management

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `lydo_id` | VARCHAR(20) | PRIMARY KEY | LYDO identifier (e.g., 'LYDO001') |
| `role_id` | VARCHAR(20) | NOT NULL | Role reference |
| `email` | VARCHAR(100) | UNIQUE, NOT NULL | Official email |
| `personal_email` | VARCHAR(100) | UNIQUE, NOT NULL | Personal email |
| `password_hash` | VARCHAR(255) | NOT NULL | Bcrypt hash |
| `first_name` | VARCHAR(50) | NOT NULL | First name |
| `last_name` | VARCHAR(50) | NOT NULL | Last name |
| `middle_name` | VARCHAR(50) | NULL | Middle name |
| `suffix` | VARCHAR(50) | NULL | Name suffix |
| `profile_picture` | VARCHAR(255) | NULL | Profile picture file path |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `email_verified` | BOOLEAN | DEFAULT FALSE | Email verification status |
| `created_by` | VARCHAR(20) | NOT NULL | Creator reference |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |
| `deactivated` | BOOLEAN | DEFAULT FALSE | Deactivation status |
| `deactivated_at` | TIMESTAMP | NULL | Deactivation timestamp |

**Foreign Keys:**
- `role_id` → `Roles(role_id)` ON DELETE RESTRICT

**Indexes:**
- `idx_email (email)`
- `idx_role_id (role_id)`
- `idx_active (is_active)`

---

### 4. SK_Terms Table
**Purpose:** SK term management with comprehensive statistics

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `term_id` | VARCHAR(20) | PRIMARY KEY | Term identifier (e.g., 'TRM001') |
| `term_name` | VARCHAR(100) | NOT NULL | Term name (e.g., '2023-2025 Term') |
| `start_date` | DATE | NOT NULL | Term start date |
| `end_date` | DATE | NOT NULL | Term end date |
| `status` | ENUM | DEFAULT 'upcoming' | Term status |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `is_current` | BOOLEAN | DEFAULT FALSE | Current term flag |
| `created_by` | VARCHAR(20) | NOT NULL | LYDO who created |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |
| `statistics_total_officials` | INTEGER | DEFAULT 0 | Total officials count |
| `statistics_active_officials` | INTEGER | DEFAULT 0 | Active officials count |
| `statistics_inactive_officials` | INTEGER | DEFAULT 0 | Inactive officials count |
| `statistics_total_sk_chairperson` | INTEGER | DEFAULT 0 | Chairperson count |
| `statistics_total_sk_secretary` | INTEGER | DEFAULT 0 | Secretary count |
| `statistics_total_sk_treasurer` | INTEGER | DEFAULT 0 | Treasurer count |
| `statistics_total_sk_councilor` | INTEGER | DEFAULT 0 | Councilor count |

**ENUM Values:**
- `status`: 'active', 'completed', 'upcoming'

**Foreign Keys:**
- `created_by` → `LYDO(lydo_id)` ON DELETE RESTRICT

**Indexes:**
- `idx_dates (start_date, end_date)`
- `idx_status (status)`
- `idx_active (is_active)`

---

### 5. SK_Officials Table
**Purpose:** SK official management with term association

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `sk_id` | VARCHAR(20) | PRIMARY KEY | SK official identifier (e.g., 'SK001') |
| `role_id` | VARCHAR(20) | NOT NULL | Role reference |
| `term_id` | VARCHAR(20) | NOT NULL | Term reference |
| `email` | VARCHAR(100) | UNIQUE, NOT NULL | Official email |
| `personal_email` | VARCHAR(100) | UNIQUE, NOT NULL | Personal email |
| `password_hash` | VARCHAR(255) | NOT NULL | Bcrypt hash |
| `barangay_id` | VARCHAR(20) | NOT NULL | Barangay assignment |
| `first_name` | VARCHAR(50) | NOT NULL | First name |
| `last_name` | VARCHAR(50) | NOT NULL | Last name |
| `middle_name` | VARCHAR(50) | NULL | Middle name |
| `suffix` | VARCHAR(50) | NULL | Name suffix |
| `position` | ENUM | NOT NULL | SK position |
| `profile_picture` | VARCHAR(255) | NULL | Profile picture file path |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `email_verified` | BOOLEAN | DEFAULT FALSE | Email verification status |
| `created_by` | VARCHAR(20) | NOT NULL | Creator reference |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |

**ENUM Values:**
- `position`: 'SK Chairperson', 'SK Secretary', 'SK Treasurer', 'SK Councilor'

**Foreign Keys:**
- `role_id` → `Roles(role_id)` ON DELETE RESTRICT
- `barangay_id` → `Barangay(barangay_id)` ON DELETE RESTRICT
- `term_id` → `SK_Terms(term_id)` ON DELETE RESTRICT
- `created_by` → `LYDO(lydo_id)` ON DELETE RESTRICT

**Indexes:**
- `idx_email (email)`
- `idx_role_id (role_id)`
- `idx_barangay_id (barangay_id)`
- `idx_term_id (term_id)`
- `idx_active (is_active)`

---

### 6. SK_Officials_Profiling Table
**Purpose:** Extended SK official information

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `profiling_id` | VARCHAR(20) | PRIMARY KEY | Profiling identifier (e.g., 'PRO001') |
| `sk_id` | VARCHAR(20) | NOT NULL | SK official reference |
| `birth_date` | DATE | NOT NULL | Birth date |
| `age` | INTEGER | NOT NULL | Age |
| `gender` | ENUM | NOT NULL | Gender |
| `contact_number` | VARCHAR(20) | UNIQUE, NOT NULL | Contact number |
| `school_or_company` | VARCHAR(100) | NOT NULL | School or company |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |
| `performance_metrics_survey_validated` | INTEGER | DEFAULT 0 | Survey validation count |

**ENUM Values:**
- `gender`: 'Male', 'Female'

**Foreign Keys:**
- `sk_id` → `SK_Officials(sk_id)` ON DELETE CASCADE

**Indexes:**
- `idx_sk_id (sk_id)`

---

### 7. Youth_Profiling Table
**Purpose:** Youth community member management

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `youth_id` | VARCHAR(20) | PRIMARY KEY | Youth identifier (e.g., 'YTH001') |
| `first_name` | VARCHAR(50) | NOT NULL | First name |
| `last_name` | VARCHAR(50) | NOT NULL | Last name |
| `middle_name` | VARCHAR(50) | NULL | Middle name |
| `suffix` | VARCHAR(50) | NULL | Name suffix |
| `region` | VARCHAR(50) | NOT NULL, DEFAULT 'Region IV-A (CALABARZON)' | Region |
| `province` | VARCHAR(50) | NOT NULL, DEFAULT 'Batangas' | Province |
| `municipality` | VARCHAR(50) | NOT NULL, DEFAULT 'San Jose' | Municipality |
| `barangay_id` | VARCHAR(20) | NOT NULL | Barangay residence |
| `purok_zone` | VARCHAR(50) | NULL | Purok/Zone within barangay |
| `birth_date` | DATE | NOT NULL | Birth date |
| `age` | INTEGER | NOT NULL | Age |
| `gender` | ENUM | NOT NULL | Gender |
| `contact_number` | VARCHAR(20) | UNIQUE, NOT NULL | Contact number |
| `email` | VARCHAR(100) | UNIQUE, NOT NULL | Email address |
| `is_active` | BOOLEAN | DEFAULT TRUE | Active status |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |

**ENUM Values:**
- `gender`: 'Male', 'Female'

**Foreign Keys:**
- `barangay_id` → `Barangay(barangay_id)` ON DELETE RESTRICT

**Indexes:**
- `idx_barangay_id (barangay_id)`
- `idx_age (age)`
- `idx_active (is_active)`

---

### 8. Users Table
**Purpose:** Unified user tracking across all user types

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `user_id` | VARCHAR(20) | PRIMARY KEY | User identifier (e.g., 'USR001') |
| `user_type` | ENUM | NOT NULL | User type |
| `lydo_id` | VARCHAR(20) | NULL | LYDO reference (if applicable) |
| `sk_id` | VARCHAR(20) | NULL | SK official reference (if applicable) |
| `youth_id` | VARCHAR(20) | NULL | Youth reference (if applicable) |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |

**ENUM Values:**
- `user_type`: 'admin', 'lydo_staff', 'sk_official', 'youth'

**Foreign Keys:**
- `lydo_id` → `LYDO(lydo_id)` ON DELETE CASCADE
- `sk_id` → `SK_Officials(sk_id)` ON DELETE CASCADE
- `youth_id` → `Youth_Profiling(youth_id)` ON DELETE CASCADE

**Indexes:**
- `idx_user_type (user_type)`
- `idx_lydo_id (lydo_id)`
- `idx_sk_id (sk_id)`
- `idx_youth_id (youth_id)`

---

### 9. Voters_List Table
**Purpose:** Voter registration tracking

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `voter_id` | VARCHAR(20) | PRIMARY KEY | Voter identifier (e.g., 'VOT001') |
| `first_name` | VARCHAR(50) | NOT NULL | First name |
| `last_name` | VARCHAR(50) | NOT NULL | Last name |
| `middle_name` | VARCHAR(50) | NULL | Middle name |
| `suffix` | VARCHAR(50) | NULL | Name suffix |
| `birth_date` | DATE | NOT NULL | Birth date |
| `gender` | ENUM | NULL | Gender |
| `created_by` | VARCHAR(20) | NOT NULL | Creator reference |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |

**ENUM Values:**
- `gender`: 'Male', 'Female'

**Foreign Keys:**
- `created_by` → `LYDO(lydo_id)` ON DELETE RESTRICT

**Indexes:**
- `idx_name (first_name, last_name)`

---

### 10. KK_Survey_Batches Table
**Purpose:** Survey batch management

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `batch_id` | VARCHAR(20) | PRIMARY KEY | Batch identifier (e.g., 'BAT001') |
| `batch_name` | VARCHAR(100) | NOT NULL | Batch name (e.g., 'KK Survey 2024 Q1') |
| `description` | TEXT | NULL | Batch description |
| `start_date` | DATE | NOT NULL | Survey start date |
| `end_date` | DATE | NOT NULL | Survey end date |
| `target_age_min` | INTEGER | DEFAULT 15 | Minimum target age |
| `target_age_max` | INTEGER | DEFAULT 30 | Maximum target age |
| `created_by` | VARCHAR(20) | NOT NULL | LYDO who created |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |
| `statistics_total_responses` | INTEGER | DEFAULT 0 | Total responses count |
| `statistics_validated_responses` | INTEGER | DEFAULT 0 | Validated responses count |
| `statistics_rejected_responses` | INTEGER | DEFAULT 0 | Rejected responses count |
| `statistics_pending_responses` | INTEGER | DEFAULT 0 | Pending responses count |
| `statistics_total_youths` | INTEGER | DEFAULT 0 | Total youths count |
| `statistics_total_youths_surveyed` | INTEGER | DEFAULT 0 | Surveyed youths count |
| `statistics_total_youths_not_surveyed` | INTEGER | DEFAULT 0 | Non-surveyed youths count |

**Foreign Keys:**
- `created_by` → `LYDO(lydo_id)` ON DELETE RESTRICT

**Indexes:**
- `idx_dates (start_date, end_date)`
- `idx_created_by (created_by)`

---

### 11. KK_Survey_Responses Table
**Purpose:** Individual survey responses with validation

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `response_id` | VARCHAR(20) | PRIMARY KEY | Response identifier (e.g., 'RES001') |
| `batch_id` | VARCHAR(20) | NOT NULL | Survey batch reference |
| `youth_id` | VARCHAR(20) | NOT NULL | Youth reference |
| `barangay_id` | VARCHAR(20) | NOT NULL | Barangay reference |
| `civil_status` | ENUM | NULL | Civil status |
| `youth_classification` | ENUM | NOT NULL | Youth classification |
| `youth_specific_needs` | ENUM | NULL | Specific needs |
| `youth_age_group` | ENUM | NULL | Age group |
| `educational_background` | ENUM | NULL | Educational background |
| `work_status` | ENUM | NULL | Work status |
| `registered_SK_voter` | BOOLEAN | NULL | SK voter registration |
| `registered_national_voter` | BOOLEAN | NULL | National voter registration |
| `attended_KK_assembly` | BOOLEAN | NULL | KK assembly attendance |
| `voted_last_SK` | BOOLEAN | NULL | Last SK voting |
| `times_attended` | ENUM | NULL | Assembly attendance frequency |
| `reason_not_attended` | ENUM | NULL | Non-attendance reason |
| `validation_status` | ENUM | DEFAULT 'pending' | Validation status |
| `validation_tier` | ENUM | DEFAULT 'automatic' | Validation tier |
| `validated_by` | VARCHAR(20) | NULL | SK Official who validated |
| `validation_date` | TIMESTAMP | NULL | Validation date |
| `validation_comments` | TEXT | NULL | Validation comments |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |

**ENUM Values:**
- `civil_status`: 'Single', 'Married', 'Widowed', 'Divorced', 'Separated', 'Annulled', 'Unknown', 'Live-in'
- `youth_classification`: 'In School Youth', 'Out of School Youth', 'Working Youth', 'Youth w/Specific Needs'
- `youth_specific_needs`: 'Person w/Disability', 'Children in Conflict w/ Law', 'Indigenous People'
- `youth_age_group`: 'Child Youth (15-17 yrs old)', 'Core Youth (18-24 yrs old)', 'Young Adult (15-30 yrs old)'
- `educational_background`: 'Elementary Level', 'Elementary Grad', 'High School Level', 'High School Grad', 'Vocational Grad', 'College Level', 'College Grad', 'Masters Level', 'Masters Grad', 'Doctorate Level', 'Doctorate Graduate'
- `work_status`: 'Employed', 'Unemployed', 'Self-Employed', 'Currently looking for a Job', 'Not interested looking for a job'
- `times_attended`: '1-2 Times', '3-4 Times', '5 and above'
- `reason_not_attended`: 'There was no KK Assembly Meeting', 'Not interested to Attend'
- `validation_status`: 'pending', 'validated', 'rejected'
- `validation_tier`: 'automatic', 'manual', 'final'

**Foreign Keys:**
- `batch_id` → `KK_Survey_Batches(batch_id)` ON DELETE RESTRICT
- `youth_id` → `Youth_Profiling(youth_id)` ON DELETE RESTRICT
- `barangay_id` → `Barangay(barangay_id)` ON DELETE RESTRICT
- `validated_by` → `SK_Officials(sk_id)` ON DELETE SET NULL

**Indexes:**
- `idx_batch_id (batch_id)`
- `idx_youth_id (youth_id)`
- `idx_barangay_id (barangay_id)`
- `idx_validation_status (validation_status)`
- `idx_validation_tier (validation_tier)`
- `idx_created_at (created_at)`

---

### 12. Validation_Logs Table
**Purpose:** Audit trail for survey validation

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `log_id` | VARCHAR(20) | PRIMARY KEY | Log identifier (e.g., 'LOG001') |
| `response_id` | VARCHAR(20) | NOT NULL | Survey response reference |
| `validated_by` | VARCHAR(20) | NOT NULL | SK Official who validated |
| `validation_action` | ENUM | NOT NULL | Validation action |
| `validation_tier` | ENUM | NOT NULL | Validation tier |
| `validation_comments` | TEXT | NULL | Validation notes |
| `validation_date` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Validation timestamp |

**ENUM Values:**
- `validation_action`: 'validate', 'reject'
- `validation_tier`: 'automatic', 'manual', 'final'

**Foreign Keys:**
- `response_id` → `KK_Survey_Responses(response_id)` ON DELETE CASCADE
- `validated_by` → `SK_Officials(sk_id)` ON DELETE RESTRICT

**Indexes:**
- `idx_response_id (response_id)`
- `idx_validated_by (validated_by)`
- `idx_validation_action (validation_action)`
- `idx_validation_date (validation_date)`

---

### 13. Activity_Logs Table
**Purpose:** Comprehensive system activity tracking

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `log_id` | VARCHAR(20) | PRIMARY KEY | Log identifier (e.g., 'ACT001') |
| `user_id` | VARCHAR(20) | NULL | User who performed action |
| `user_type` | ENUM | NULL | User type |
| `action` | VARCHAR(100) | NOT NULL | Action performed |
| `resource_type` | VARCHAR(50) | NOT NULL | Resource type affected |
| `resource_id` | VARCHAR(20) | NULL | Resource identifier |
| `resource_name` | VARCHAR(100) | NULL | Resource name |
| `details` | JSON | NULL | Additional action details |
| `category` | ENUM | NOT NULL | Action category |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Action timestamp |
| `success` | BOOLEAN | DEFAULT TRUE | Action success status |
| `error_message` | TEXT | NULL | Error details if failed |

**ENUM Values:**
- `user_type`: 'admin', 'lydo_staff', 'sk_official', 'youth', 'anonymous'
- `category`: 'Authentication', 'User Management', 'Survey Management', 'Announcement', 'Activity Log', 'Data Export', 'Data Management', 'System Management'

**Foreign Keys:**
- `user_id` → `Users(user_id)` ON DELETE SET NULL

**Indexes:**
- `idx_user_id (user_id)`
- `idx_user_type (user_type)`
- `idx_action (action)`
- `idx_resource (resource_type, resource_id)`
- `idx_created_at (created_at)`

---

### 14. Notifications Table
**Purpose:** Multi-target notification system

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `notification_id` | VARCHAR(20) | PRIMARY KEY | Notification identifier (e.g., 'NOT001') |
| `user_id` | VARCHAR(20) | NULL | Target user (NULL for broadcast) |
| `user_type` | ENUM | NULL | Target user type |
| `barangay_id` | VARCHAR(20) | NULL | Target barangay |
| `title` | VARCHAR(200) | NOT NULL | Notification title |
| `message` | TEXT | NOT NULL | Notification content |
| `type` | ENUM | DEFAULT 'info' | Notification type |
| `priority` | ENUM | DEFAULT 'normal' | Priority level |
| `is_read` | BOOLEAN | DEFAULT FALSE | Read status |
| `read_at` | TIMESTAMP | NULL | Read timestamp |
| `expires_at` | TIMESTAMP | NULL | Expiration date |
| `created_by` | VARCHAR(20) | NOT NULL | Notification creator |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |

**ENUM Values:**
- `user_type`: 'admin', 'lydo_staff', 'sk_official', 'youth', 'all'
- `type`: 'info', 'success', 'warning', 'error', 'announcement', 'survey_reminder', 'validation_needed', 'sk_term_end', 'kk_batch_end'
- `priority`: 'low', 'normal', 'high', 'urgent'

**Foreign Keys:**
- `user_id` → `Users(user_id)` ON DELETE CASCADE
- `barangay_id` → `Barangay(barangay_id)` ON DELETE CASCADE
- `created_by` → `Users(user_id)` ON DELETE CASCADE

**Indexes:**
- `idx_user_id (user_id)`
- `idx_user_type (user_type)`
- `idx_barangay_id (barangay_id)`
- `idx_type (type)`
- `idx_priority (priority)`
- `idx_is_read (is_read)`
- `idx_created_at (created_at)`
- `idx_expires_at (expires_at)`

---

### 15. Announcements Table
**Purpose:** Public announcement management

| Column | Type | Constraint | Description |
|--------|------|------------|-------------|
| `announcement_id` | VARCHAR(20) | PRIMARY KEY | Announcement identifier (e.g., 'ANN001') |
| `title` | VARCHAR(200) | NOT NULL | Announcement title |
| `content` | TEXT | NOT NULL | Announcement content |
| `summary` | VARCHAR(500) | NULL | Short summary |
| `category` | ENUM | DEFAULT 'general' | Announcement category |
| `status` | ENUM | DEFAULT 'draft' | Publication status |
| `image_url` | VARCHAR(255) | NULL | Featured image |
| `attachment_name` | VARCHAR(255) | NULL | Attachment filename |
| `attachment_url` | VARCHAR(255) | NULL | Attachment file path |
| `is_featured` | BOOLEAN | DEFAULT FALSE | Featured announcement |
| `is_pinned` | BOOLEAN | DEFAULT FALSE | Pinned to top |
| `published_at` | TIMESTAMP | NULL | Publication date |
| `created_by` | VARCHAR(20) | NOT NULL | Announcement creator |
| `created_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP | Creation timestamp |
| `updated_at` | TIMESTAMP | DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP | Last update timestamp |

**ENUM Values:**
- `category`: 'general', 'event', 'survey', 'meeting', 'deadline', 'achievement', 'update'
- `status`: 'draft', 'published', 'archived'

**Foreign Keys:**
- `created_by` → `Users(user_id)` ON DELETE CASCADE

**Indexes:**
- `idx_status (status)`
- `idx_is_featured (is_featured)`
- `idx_is_pinned (is_pinned)`
- `idx_category (category)`
- `idx_published_at (published_at)`
- `idx_created_at (created_at)`

## Relationships & Foreign Keys

### Primary Relationships Diagram
```
Barangay (1) ←→ (N) SK_Officials
Barangay (1) ←→ (N) Youth_Profiling
Barangay (1) ←→ (N) KK_Survey_Responses
Barangay (1) ←→ (N) Notifications

Roles (1) ←→ (N) LYDO
Roles (1) ←→ (N) SK_Officials

SK_Terms (1) ←→ (N) SK_Officials
LYDO (1) ←→ (N) SK_Terms
LYDO (1) ←→ (N) KK_Survey_Batches
LYDO (1) ←→ (N) SK_Officials
LYDO (1) ←→ (N) Voters_List

Users (1) ←→ (1) LYDO (optional)
Users (1) ←→ (1) SK_Officials (optional)
Users (1) ←→ (1) Youth_Profiling (optional)

KK_Survey_Batches (1) ←→ (N) KK_Survey_Responses
Youth_Profiling (1) ←→ (N) KK_Survey_Responses
SK_Officials (1) ←→ (N) KK_Survey_Responses (validation)
SK_Officials (1) ←→ (N) Validation_Logs

KK_Survey_Responses (1) ←→ (N) Validation_Logs
Users (1) ←→ (N) Notifications
Users (1) ←→ (N) Announcements
```

### Foreign Key Details

| Table | Column | References | On Delete | On Update |
|-------|--------|------------|-----------|-----------|
| `LYDO` | `role_id` | `Roles(role_id)` | RESTRICT | CASCADE |
| `SK_Terms` | `created_by` | `LYDO(lydo_id)` | RESTRICT | CASCADE |
| `SK_Officials` | `role_id` | `Roles(role_id)` | RESTRICT | CASCADE |
| `SK_Officials` | `term_id` | `SK_Terms(term_id)` | RESTRICT | CASCADE |
| `SK_Officials` | `barangay_id` | `Barangay(barangay_id)` | RESTRICT | CASCADE |
| `SK_Officials` | `created_by` | `LYDO(lydo_id)` | RESTRICT | CASCADE |
| `SK_Officials_Profiling` | `sk_id` | `SK_Officials(sk_id)` | CASCADE | CASCADE |
| `Youth_Profiling` | `barangay_id` | `Barangay(barangay_id)` | RESTRICT | CASCADE |
| `Users` | `lydo_id` | `LYDO(lydo_id)` | CASCADE | CASCADE |
| `Users` | `sk_id` | `SK_Officials(sk_id)` | CASCADE | CASCADE |
| `Users` | `youth_id` | `Youth_Profiling(youth_id)` | CASCADE | CASCADE |
| `Voters_List` | `created_by` | `LYDO(lydo_id)` | RESTRICT | CASCADE |
| `KK_Survey_Batches` | `created_by` | `LYDO(lydo_id)` | RESTRICT | CASCADE |
| `KK_Survey_Responses` | `batch_id` | `KK_Survey_Batches(batch_id)` | RESTRICT | CASCADE |
| `KK_Survey_Responses` | `youth_id` | `Youth_Profiling(youth_id)` | RESTRICT | CASCADE |
| `KK_Survey_Responses` | `barangay_id` | `Barangay(barangay_id)` | RESTRICT | CASCADE |
| `KK_Survey_Responses` | `validated_by` | `SK_Officials(sk_id)` | SET NULL | CASCADE |
| `Validation_Logs` | `response_id` | `KK_Survey_Responses(response_id)` | CASCADE | CASCADE |
| `Validation_Logs` | `validated_by` | `SK_Officials(sk_id)` | RESTRICT | CASCADE |
| `Activity_Logs` | `user_id` | `Users(user_id)` | SET NULL | CASCADE |
| `Notifications` | `user_id` | `Users(user_id)` | CASCADE | CASCADE |
| `Notifications` | `barangay_id` | `Barangay(barangay_id)` | CASCADE | CASCADE |
| `Notifications` | `created_by` | `Users(user_id)` | CASCADE | CASCADE |
| `Announcements` | `created_by` | `Users(user_id)` | CASCADE | CASCADE |

## Indexes & Performance

### Complete Index List

| Table | Index Name | Columns | Type | Purpose |
|-------|------------|---------|------|---------|
| `Barangay` | `idx_barangay_name` | `barangay_name` | UNIQUE | Fast barangay lookups |
| `Roles` | `idx_role_name` | `role_name` | UNIQUE | Fast role lookups |
| `Roles` | `idx_active` | `is_active` | BTREE | Active role filtering |
| `LYDO` | `idx_email` | `email` | UNIQUE | Fast email lookups |
| `LYDO` | `idx_role_id` | `role_id` | BTREE | Role-based queries |
| `LYDO` | `idx_active` | `is_active` | BTREE | Active user filtering |
| `SK_Terms` | `idx_dates` | `start_date, end_date` | BTREE | Date range queries |
| `SK_Terms` | `idx_status` | `status` | BTREE | Status filtering |
| `SK_Terms` | `idx_active` | `is_active` | BTREE | Active term filtering |
| `SK_Officials` | `idx_email` | `email` | UNIQUE | Fast email lookups |
| `SK_Officials` | `idx_role_id` | `role_id` | BTREE | Role-based queries |
| `SK_Officials` | `idx_barangay_id` | `barangay_id` | BTREE | Barangay-based queries |
| `SK_Officials` | `idx_term_id` | `term_id` | BTREE | Term-based queries |
| `SK_Officials` | `idx_active` | `is_active` | BTREE | Active official filtering |
| `SK_Officials_Profiling` | `idx_sk_id` | `sk_id` | BTREE | Fast profiling lookups |
| `Youth_Profiling` | `idx_barangay_id` | `barangay_id` | BTREE | Barangay-based queries |
| `Youth_Profiling` | `idx_age` | `age` | BTREE | Age-based queries |
| `Youth_Profiling` | `idx_active` | `is_active` | BTREE | Active youth filtering |
| `Users` | `idx_user_type` | `user_type` | BTREE | User type filtering |
| `Users` | `idx_lydo_id` | `lydo_id` | BTREE | LYDO user lookups |
| `Users` | `idx_sk_id` | `sk_id` | BTREE | SK user lookups |
| `Users` | `idx_youth_id` | `youth_id` | BTREE | Youth user lookups |
| `Voters_List` | `idx_name` | `first_name, last_name` | BTREE | Name-based searches |
| `KK_Survey_Batches` | `idx_dates` | `start_date, end_date` | BTREE | Date range queries |
| `KK_Survey_Batches` | `idx_created_by` | `created_by` | BTREE | Creator-based queries |
| `KK_Survey_Responses` | `idx_batch_id` | `batch_id` | BTREE | Batch-based queries |
| `KK_Survey_Responses` | `idx_youth_id` | `youth_id` | BTREE | Youth-based queries |
| `KK_Survey_Responses` | `idx_barangay_id` | `barangay_id` | BTREE | Barangay-based queries |
| `KK_Survey_Responses` | `idx_validation_status` | `validation_status` | BTREE | Status filtering |
| `KK_Survey_Responses` | `idx_validation_tier` | `validation_tier` | BTREE | Tier filtering |
| `KK_Survey_Responses` | `idx_created_at` | `created_at` | BTREE | Date-based queries |
| `Validation_Logs` | `idx_response_id` | `response_id` | BTREE | Response-based queries |
| `Validation_Logs` | `idx_validated_by` | `validated_by` | BTREE | Validator-based queries |
| `Validation_Logs` | `idx_validation_action` | `validation_action` | BTREE | Action filtering |
| `Validation_Logs` | `idx_validation_date` | `validation_date` | BTREE | Date-based queries |
| `Activity_Logs` | `idx_user_id` | `user_id` | BTREE | User-based queries |
| `Activity_Logs` | `idx_user_type` | `user_type` | BTREE | User type filtering |
| `Activity_Logs` | `idx_action` | `action` | BTREE | Action-based queries |
| `Activity_Logs` | `idx_resource` | `resource_type, resource_id` | BTREE | Resource-based queries |
| `Activity_Logs` | `idx_created_at` | `created_at` | BTREE | Date-based queries |
| `Notifications` | `idx_user_id` | `user_id` | BTREE | User-based queries |
| `Notifications` | `idx_user_type` | `user_type` | BTREE | User type filtering |
| `Notifications` | `idx_barangay_id` | `barangay_id` | BTREE | Barangay-based queries |
| `Notifications` | `idx_type` | `type` | BTREE | Type filtering |
| `Notifications` | `idx_priority` | `priority` | BTREE | Priority filtering |
| `Notifications` | `idx_is_read` | `is_read` | BTREE | Read status filtering |
| `Notifications` | `idx_created_at` | `created_at` | BTREE | Date-based queries |
| `Notifications` | `idx_expires_at` | `expires_at` | BTREE | Expiration filtering |
| `Announcements` | `idx_status` | `status` | BTREE | Status filtering |
| `Announcements` | `idx_is_featured` | `is_featured` | BTREE | Featured filtering |
| `Announcements` | `idx_is_pinned` | `is_pinned` | BTREE | Pinned filtering |
| `Announcements` | `idx_category` | `category` | BTREE | Category filtering |
| `Announcements` | `idx_published_at` | `published_at` | BTREE | Publication date queries |
| `Announcements` | `idx_created_at` | `created_at` | BTREE | Creation date queries |

## Data Types & Constraints

### String Types
- **VARCHAR(20)**: IDs and short codes
- **VARCHAR(50)**: Names and short text
- **VARCHAR(100)**: Medium text fields
- **VARCHAR(200)**: Titles and longer text
- **VARCHAR(255)**: File paths and URLs
- **VARCHAR(500)**: Summaries
- **TEXT**: Long content and descriptions

### Numeric Types
- **INTEGER**: Counts, ages, and statistics
- **BOOLEAN**: True/false flags

### Date/Time Types
- **DATE**: Birth dates and term dates
- **TIMESTAMP**: Audit timestamps with auto-update

### Enumerated Types
- **ENUM**: Predefined value sets for consistency
- **JSON**: Flexible permission and detail storage

### Constraint Types
- **NOT NULL**: Required fields
- **UNIQUE**: Unique values (emails, IDs)
- **DEFAULT**: Default values for optional fields
- **PRIMARY KEY**: Primary identifiers
- **FOREIGN KEY**: Referential integrity

## Sample Data & Queries

### Common Queries

#### Get Active SK Officials by Barangay
```sql
SELECT 
    so.sk_id,
    so.first_name,
    so.last_name,
    so.position,
    b.barangay_name,
    st.term_name
FROM SK_Officials so
JOIN Barangay b ON so.barangay_id = b.barangay_id
JOIN SK_Terms st ON so.term_id = st.term_id
WHERE so.is_active = TRUE 
AND st.status = 'active'
ORDER BY b.barangay_name, so.position;
```

#### Get Survey Statistics by Batch
```sql
SELECT 
    batch_name,
    statistics_total_responses,
    statistics_validated_responses,
    statistics_rejected_responses,
    statistics_pending_responses,
    ROUND((statistics_validated_responses / statistics_total_responses) * 100, 2) as validation_rate
FROM KK_Survey_Batches
ORDER BY start_date DESC;
```

#### Get Youth Demographics by Barangay
```sql
SELECT 
    b.barangay_name,
    COUNT(*) as total_youth,
    AVG(yp.age) as average_age,
    SUM(CASE WHEN yp.gender = 'Male' THEN 1 ELSE 0 END) as male_count,
    SUM(CASE WHEN yp.gender = 'Female' THEN 1 ELSE 0 END) as female_count
FROM Youth_Profiling yp
JOIN Barangay b ON yp.barangay_id = b.barangay_id
WHERE yp.is_active = TRUE
GROUP BY b.barangay_id, b.barangay_name
ORDER BY total_youth DESC;
```

#### Get Unread Notifications for User
```sql
SELECT 
    notification_id,
    title,
    message,
    type,
    priority,
    created_at
FROM Notifications
WHERE user_id = ? 
AND is_read = FALSE
AND (expires_at IS NULL OR expires_at > NOW())
ORDER BY priority DESC, created_at DESC;
```

---

**Last Updated:** December 2024  
**Version:** 2.0  
**Maintained By:** Youth Governance App Development Team 