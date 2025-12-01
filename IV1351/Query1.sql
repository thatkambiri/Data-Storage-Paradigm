SELECT 
    cl.course_code,
    ci.instance_id AS course_instance_id,
    cl.hp,
    ci.study_period AS period,
    ci.num_students,
    SUM(CASE WHEN ta.activity_name = 'Lecture' THEN pa.planned_hours * ta.factor ELSE 0 END) AS lecture_hours,
    SUM(CASE WHEN ta.activity_name = 'Tutorial' THEN pa.planned_hours * ta.factor ELSE 0 END) AS tutorial_hours,
    SUM(CASE WHEN ta.activity_name = 'Lab' THEN pa.planned_hours * ta.factor ELSE 0 END) AS lab_hours,
    SUM(CASE WHEN ta.activity_name = 'Seminar' THEN pa.planned_hours * ta.factor ELSE 0 END) AS seminar_hours,
    SUM(CASE WHEN ta.activity_name NOT IN ('Lecture','Tutorial','Lab','Seminar') THEN pa.planned_hours * ta.factor ELSE 0 END) AS other_hours,
    SUM(CASE WHEN ta.activity_name = 'Admin' THEN pa.planned_hours * ta.factor ELSE 0 END) AS admin_hours,
    SUM(CASE WHEN ta.activity_name = 'Exam' THEN pa.planned_hours * ta.factor ELSE 0 END) AS exam_hours,
    SUM(pa.planned_hours * ta.factor) AS total_hours
FROM course_instance ci
JOIN course_layout cl ON ci.course_layout_id = cl.id
JOIN planned_activity pa ON pa.course_layout_id = cl.id
JOIN teaching_activity ta ON pa.teaching_activity_id = ta.id
WHERE ci.study_year = '2025'
GROUP BY cl.course_code, ci.instance_id, cl.hp, ci.study_period, ci.num_students
ORDER BY cl.course_code, ci.instance_id;
