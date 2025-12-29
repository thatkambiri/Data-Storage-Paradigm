SELECT
    cl.course_code,
    ci.instance_id AS course_instance_id,
    cv.hp,

    -- Teacher info
    p.first_name || ' ' || p.last_name AS teacher_name,
    jt.job_title AS designation,

    -- Activity break-down
    SUM(
        CASE 
            WHEN ta.activity_name = 'Lecture'
            THEN pa.planned_hours * ta.factor
            ELSE 0
        END
    ) AS lecture_hours,

    SUM(
        CASE 
            WHEN ta.activity_name = 'Tutorial'
            THEN pa.planned_hours * ta.factor
            ELSE 0
        END
    ) AS tutorial_hours,

    SUM(
        CASE 
            WHEN ta.activity_name = 'Lab'
            THEN pa.planned_hours * ta.factor
            ELSE 0
        END
    ) AS lab_hours,

    SUM(
        CASE 
            WHEN ta.activity_name = 'Seminar'
            THEN pa.planned_hours * ta.factor
            ELSE 0
        END
    ) AS seminar_hours,

    SUM(
        CASE 
            WHEN ta.activity_name NOT IN ('Lecture','Tutorial','Lab','Seminar','Admin','Exam')
            THEN pa.planned_hours * ta.factor
            ELSE 0
        END
    ) AS other_overhead_hours,

    SUM(
        CASE 
            WHEN ta.activity_name = 'Admin'
            THEN pa.planned_hours * ta.factor
            ELSE 0
        END
    ) AS admin_hours,

    SUM(
        CASE 
            WHEN ta.activity_name = 'Exam'
            THEN pa.planned_hours * ta.factor
            ELSE 0
        END
    ) AS exam_hours,

    -- Total allocated hours
    SUM(pa.planned_hours * ta.factor) AS total_hours

FROM employee_allocation ea
JOIN employee e
    ON ea.employee_id = e.id
JOIN person p
    ON e.id = p.id
JOIN job_title jt
    ON e.job_id = jt.id

JOIN course_instance ci
    ON ea.instance_id = ci.instance_id
JOIN course_version cv
    ON ci.course_version_id = cv.id
JOIN course_layout cl
    ON cv.course_layout_id = cl.id

JOIN planned_activity pa
    ON pa.instance_id = ci.instance_id
   AND pa.teaching_activity_id = ea.teaching_activity_id

JOIN teaching_activity ta
    ON ta.teaching_activity_id = ea.teaching_activity_id

WHERE ci.study_year = '2025' AND cl.course_code = 'CS101'

GROUP BY
    cl.course_code,
    ci.instance_id,
    cv.hp,
    p.first_name,
    p.last_name,
    jt.job_title

ORDER BY
    cl.course_code,
    ci.instance_id,
    teacher_name;
