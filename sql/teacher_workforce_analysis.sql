-- DELHI GOVERNMENT SCHOOL DATA ANALYSIS
-- Module: Teacher Workforce and Workload
-- Tools: SQL / DuckDB

-- 1. TOTAL, FILLED AND VACANT TEACHER POSTS
SELECT
    COUNT(*) AS total_sanctioned_posts,
    SUM(CASE WHEN post_status = 'Filled' THEN 1 ELSE 0 END) AS total_filled_posts,
    SUM(CASE WHEN post_status = 'Vacant' THEN 1 ELSE 0 END) AS total_vacant_posts
FROM delhi_government_school_teacher_data;

-- 2. VACANCY PERCENTAGE
SELECT
    ROUND(
        100.0 * SUM(CASE WHEN post_status = 'Vacant' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS vacancy_percentage
FROM delhi_government_school_teacher_data;

-- 3. TEACHERS WHO LEFT / RETIRED
SELECT
    Retired,
    COUNT(*) AS teacher_count
FROM delhi_government_school_teacher_data
GROUP BY Retired;

-- 4. REPLACEMENT / GUEST TEACHER APPOINTMENTS
SELECT
    replacement_appointed_promptly,
    COUNT(*) AS teacher_count
FROM delhi_government_school_teacher_data
WHERE replacement_appointed_promptly IS NOT NULL
GROUP BY replacement_appointed_promptly;

-- 5. AVERAGE TEACHING PERIODS PER DAY
SELECT
    ROUND(AVG(periods_teach_per_day), 2) AS average_periods_per_day
FROM delhi_government_school_teacher_data
WHERE post_status = 'Filled';

-- 6. WORKLOAD EFFECT ON CLASSROOM QUALITY
SELECT
    workload_affects_classroom_quality,
    COUNT(*) AS total_teachers
FROM delhi_government_school_teacher_data
GROUP BY workload_affects_classroom_quality;

-- 7. ADMINISTRATIVE SUPPORT
SELECT
    administrative_support,
    COUNT(*) AS total_teachers
FROM delhi_government_school_teacher_data
GROUP BY administrative_support;

-- 8. TEACHER PUNCTUALITY
SELECT
    teachers_arrive_on_time,
    COUNT(*) AS total_teachers
FROM delhi_government_school_teacher_data
GROUP BY teachers_arrive_on_time;

-- 9. CLASSES LEFT UNATTENDED
SELECT
    classes_left_unattended,
    COUNT(*) AS total_teachers
FROM delhi_government_school_teacher_data
GROUP BY classes_left_unattended;

-- 10. SUBJECT-WISE STAFFING AND VACANCIES
SELECT
    subject,
    COUNT(*) AS total_posts,
    SUM(CASE WHEN post_status = 'Filled' THEN 1 ELSE 0 END) AS filled_posts,
    SUM(CASE WHEN post_status = 'Vacant' THEN 1 ELSE 0 END) AS vacant_posts,
    ROUND(
        100.0 * SUM(CASE WHEN post_status = 'Vacant' THEN 1 ELSE 0 END)
        / NULLIF(COUNT(*), 0),
        2
    ) AS vacancy_percentage
FROM delhi_government_school_teacher_data
GROUP BY subject
ORDER BY subject;
