-- ============================================================
-- Query 4: Teachers allocated in more than a specified number of course instances
-- ============================================================
SELECT
    e.employment_id,
    CONCAT(p.first_name,' ',p.last_name) AS teacher_name,
    ci.study_period,
    COUNT(DISTINCT ci.id) AS no_of_courses
FROM employee_allocation ea
JOIN employee e ON ea.employee_id = e.id
JOIN person p ON e.person_id = p.id
JOIN course_instance ci ON ea.course_instance_id = ci.id
WHERE ci.study_year = '2025'  -- Current year
GROUP BY e.employment_id, teacher_name, ci.study_period
HAVING COUNT(DISTINCT ci.id) > 1  -- Change this number to set your threshold
ORDER BY ci.study_period, no_of_courses DESC, teacher_name;
