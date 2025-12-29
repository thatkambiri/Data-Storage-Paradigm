
SELECT 
    cl.course_code,
    ci.instance_id AS course_instance_id,
    cv.hp,
    p.period,
    ci.num_students,

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

    SUM(pa.planned_hours * ta.factor) AS total_hours

FROM course_instance ci
JOIN course_version cv
    ON ci.course_version_id = cv.id
JOIN course_layout cl
    ON cv.course_layout_id = cl.id

JOIN course_instance_period cip
    ON ci.instance_id = cip.instance_id
JOIN period p
    ON cip.period_id = p.id

JOIN planned_activity pa
    ON pa.instance_id = ci.instance_id
JOIN teaching_activity ta
    ON pa.teaching_activity_id = ta.teaching_activity_id

WHERE ci.study_year = '2025'

GROUP BY 
    cl.course_code,
    ci.instance_id,
    cv.hp,
    p.period,
    ci.num_students

ORDER BY 
    cl.course_code,
    ci.instance_id;
