SELECT
    e.employment_id                         AS "Employment ID",
    p.first_name || ' ' || p.last_name     AS "Teacher's Name",
    per.period                              AS "Period",
    COUNT(DISTINCT ea.instance_id)          AS "No of courses"

FROM employee_allocation ea
JOIN employee e
    ON ea.employee_id = e.id
JOIN person p
    ON e.id = p.id

JOIN course_instance ci
    ON ea.instance_id = ci.instance_id
JOIN course_instance_period cip
    ON ci.instance_id = cip.instance_id
JOIN period per
    ON cip.period_id = per.id

WHERE ci.study_year = '2025'
  AND per.period = 'P1'        -- specific period
GROUP BY
    e.employment_id,
    p.first_name,
    p.last_name,
    per.period

HAVING COUNT(DISTINCT ea.instance_id) > 1   -- specific number of courses

ORDER BY
    "No of courses" DESC,
    "Teacher's Name";
