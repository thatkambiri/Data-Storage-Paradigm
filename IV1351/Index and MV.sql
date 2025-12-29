----------INDEX FOR QUERY 1
CREATE INDEX idx_pa_instance ON planned_activity(instance_id);
CREATE INDEX idx_ci_study_year ON course_instance(study_year);
CREATE INDEX idx_cip_instance ON course_instance_period(instance_id);
CREATE INDEX idx_period_id ON period(id);

-----------INDEX FOR QUERY 2
CREATE INDEX idx_ea_employee_instance ON employee_allocation(employee_id, instance_id);
CREATE INDEX idx_pa_teaching_instance ON planned_activity(teaching_activity_id, instance_id);
CREATE INDEX idx_ci_study_year ON course_instance(study_year);

------------INDEX FOR QUERY 3 AND 4
CREATE INDEX idx_course_instance_study_year 
ON course_instance(study_year) 
WHERE study_year = '2025';




---------- MATERIALIZED VIEW FOR QUERY 2 AND 3
CREATE MATERIALIZED VIEW mv_allocated_hours_per_teacher AS
SELECT 
    ci.instance_id,
    cv.hp,
    ((p.first_name || ' ' || p.last_name)) AS teacher_name,
    jt.job_title AS designation,
    ta.activity_name,
    SUM(pa.planned_hours * ta.factor) AS hours
FROM employee_allocation ea
JOIN employee e ON ea.employee_id = e.id
JOIN person p ON e.id = p.id
JOIN job_title jt ON e.job_id = jt.id
JOIN planned_activity pa ON ea.teaching_activity_id = pa.teaching_activity_id AND ea.instance_id = pa.instance_id
JOIN teaching_activity ta ON pa.teaching_activity_id = ta.teaching_activity_id
JOIN course_instance ci ON ea.instance_id = ci.instance_id
JOIN course_version cv ON ci.course_version_id = cv.id
WHERE ci.study_year = '2025'
GROUP BY ci.instance_id, cv.hp, p.first_name, p.last_name, jt.job_title, ta.activity_name;

----------MATERIALIZED VIEW FOR QUERY 4
CREATE MATERIALIZED VIEW mv_teacher_course_count AS
SELECT
    e.employment_id,
    CONCAT(p.first_name, ' ', p.last_name) AS full_name,
    cip.period_id,
    COUNT(DISTINCT ea.instance_id) AS course_count
FROM employee_allocation ea
JOIN employee e ON ea.employee_id = e.id
JOIN person p ON e.id = p.id
JOIN course_instance ci ON ea.instance_id = ci.instance_id
JOIN course_instance_period cip ON ci.instance_id = cip.instance_id
JOIN period per ON cip.period_id = per.id
WHERE ci.study_year = '2025'
GROUP BY e.employment_id, full_name, cip.period_id;




