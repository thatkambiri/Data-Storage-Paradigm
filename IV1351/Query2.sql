SELECT
    cl.course_code,
    ci.instance_id AS course_instance_id,
    CONCAT(p.first_name,' ',p.last_name) AS teacher_name,
    jt.job_title AS designation,
    SUM(CASE WHEN ta.activity_name = 'Lecture' THEN pa.planned_hours * ta.factor ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN ta.activity_name = 'Tutorial' THEN pa.planned_hours * ta.factor ELSE 0 END) AS tutorial_hours,
    SUM(CASE WHEN ta.activity_name = 'Lab' THEN pa.planned_hours * ta.factor ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN ta.activity_name = 'Seminar' THEN pa.planned_hours * ta.factor ELSE 0 END) AS seminar_hours,
    SUM(CASE WHEN ta.activity_name NOT IN ('Lecture','Tutorial','Lab','Seminar') THEN pa.planned_hours * ta.factor ELSE 0 END) AS other_hours,
    SUM(CASE WHEN ta.activity_name = 'Admin' THEN pa.planned_hours * ta.factor ELSE 0 END) AS admin_hours,
    SUM(CASE WHEN ta.activity_name = 'Exam' THEN pa.planned_hours * ta.factor ELSE 0 END) AS exam_hours,
    SUM(pa.planned_hours * ta.factor) AS total_hours
FROM employee_allocation ea
JOIN employee e ON ea.employee_id = e.id
JOIN person p ON e.person_id = p.id
JOIN job_title jt ON e.job_title_id = jt.id
JOIN teaching_activity ta ON ea.teaching_activity_id = ta.id
JOIN course_instance ci ON ea.course_instance_id = ci.id
JOIN course_layout cl ON ci.course_layout_id = cl.id
JOIN planned_activity pa ON pa.course_layout_id = ci.course_layout_id AND pa.teaching_activity_id = ta.id
WHERE ci.study_year = '2022' AND cl.course_code = 'IV1350'
GROUP BY cl.course_code, ci.instance_id, teacher_name, jt.job_title
ORDER BY cl.course_code, ci.instance_id, teacher_name;
