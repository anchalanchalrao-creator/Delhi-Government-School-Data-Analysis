SELECT *
FROM delhi_government_school_teacher_data;

-- 1. TOTAL TEACHER POSTS
SELECT
    COUNT(*) AS total_sanctioned_posts,
    SUM(CASE WHEN post_status = 'Filled' THEN 1 ELSE 0 END) AS total_filled_posts,
    SUM(CASE WHEN post_status = 'Vacant' THEN 1 ELSE 0 END) AS total_vacant_posts
FROM delhi_government_school_teacher_data;


-- 2. VACANCY PERCENTAGE
SELECT
    ROUND(
        SUM(CASE WHEN post_status = 'Vacant' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*), 2
    ) AS vacancy_percentage
FROM delhi_government_school_teacher_data;


-- 3. TEACHERS WHO LEFT / RETIRED
SELECT
    SUM("Retired") AS total_retired
FROM delhi_government_school_teacher_data;


-- 4. REPLACEMENT / GUEST TEACHER APPOINTMENT
SELECT
    replacement_appointed_promptly,
    COUNT(*) AS total
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
WHERE post_status = 'Filled'
GROUP BY workload_affects_classroom_quality;


-- 7. ADMINISTRATIVE SUPPORT
SELECT
    administrative_support,
    COUNT(*) AS total_teachers
FROM delhi_government_school_teacher_data
WHERE post_status = 'Filled'
GROUP BY administrative_support;


-- 8. TEACHERS ARRIVING ON TIME
SELECT
    teachers_arrive_on_time,
    COUNT(*) AS total_teachers
FROM delhi_government_school_teacher_data
WHERE post_status = 'Filled'
GROUP BY teachers_arrive_on_time;


--9. CLASSES LEFT UNATTENDED
SELECT
    classes_left_unattended,
    COUNT(*) AS total_teachers
FROM delhi_government_school_teacher_data
WHERE post_status = 'Filled'
GROUP BY classes_left_unattended;


--10. SUBJECT-WISE TEACHER & VACANCY ANALYSIS
SELECT
    subject,
    SUM(CASE WHEN post_status = 'Filled' THEN 1 ELSE 0 END) AS filled_posts,
    SUM(CASE WHEN post_status = 'Vacant' THEN 1 ELSE 0 END) AS vacant_posts
FROM delhi_government_school_teacher_data
GROUP BY subject
ORDER BY subject;
