------------------------------------------------------------
-- 1. Base reference data: departments, job titles, skills
------------------------------------------------------------

INSERT INTO department (id, department_name, manager)
VALUES
  (1, 'CS',   NULL),
  (2, 'MATH', NULL),
  (3, 'EE',   NULL),
  (4, 'IND',  NULL);

INSERT INTO job_title (id, job_title)
VALUES
  (1, 'PROF'),
  (2, 'LECT'),
  (3, 'TA'),
  (4, 'ADMIN');

INSERT INTO skill_set (skill_id, skill)
VALUES
  (1, 'SQL'),
  (2, 'PYTHON'),
  (3, 'LINUX'),
  (4, 'TEACH'),
  (5, 'ADMIN');


------------------------------------------------------------
-- 2. Persons
------------------------------------------------------------

INSERT INTO person (id, personal_number, first_name, last_name)
VALUES
  (1, '900101123456', 'Anna',   'Svensson'),
  (2, '910202234567', 'Bjorn',  'Karlsson'),
  (3, '920303345678', 'Carla',  'Nguyen'),
  (4, '930404456789', 'David',  'Ali'),
  (5, '940505567890', 'Ella',   'Persson'),
  (6, '950606678901', 'Farid',  'Johansson'),
  (7, '960707789012', 'Greta',  'Lindberg'),
  (8, '970808890123', 'Hugo',   'Eriksson'),
  (9, '980909901234', 'Ines',   'Petrov'),
  (10,'991010012345', 'Jonas',  'Nilsson');


------------------------------------------------------------
-- 3. Phone numbers (1 per person for first 6 persons)
------------------------------------------------------------

INSERT INTO phone_number (phone_id, phone_number, person_id)
VALUES
  (1, '0700000001', 1),
  (2, '0700000002', 2),
  (3, '0700000003', 3),
  (4, '0700000004', 4),
  (5, '0700000005', 5),
  (6, '0700000006', 6);


------------------------------------------------------------
-- 4. Addresses (some persons have addresses, some NULL)
------------------------------------------------------------

INSERT INTO address (address_id, address, person_id)
VALUES
  (1, 'ADDR000001', 1),
  (2, 'ADDR000002', 2),
  (3, 'ADDR000003', 3),
  (4, 'ADDR000004', 4),
  (5, 'ADDR000005', 5),
  (6, 'ADDR000006', 7),
  (7, 'ADDR000007', 8);


------------------------------------------------------------
-- 5. Employees (persons 1–8 are employees)
--    supervisor_manager and manager fields are just text,
--    not foreign keys, so we reuse employment_id codes there.
------------------------------------------------------------

INSERT INTO employee (id, employment_id, salary, supervisor_manager,
                      person_id, job_id, department_id)
VALUES
  (1, 'E0001', '70000', NULL,     1, 1, 1),  -- professor CS
  (2, 'E0002', '62000', 'E0001',  2, 2, 1),  -- lecturer CS, supervised by E0001
  (3, 'E0003', '60000', NULL,     3, 2, 2),  -- lecturer MATH
  (4, 'E0004', '45000', 'E0003',  4, 3, 2),  -- TA MATH
  (5, 'E0005', '65000', NULL,     5, 2, 3),  -- lecturer EE
  (6, 'E0006', '48000', 'E0005',  6, 3, 3),  -- TA EE
  (7, 'E0007', '52000', NULL,     7, 2, 4),  -- lecturer IND
  (8, 'E0008', '40000', 'E0007',  8, 4, 4);  -- admin IND

-- set department.manager = some employment_id strings (text field)
UPDATE department SET manager = 'E0001' WHERE id = 1;
UPDATE department SET manager = 'E0003' WHERE id = 2;
UPDATE department SET manager = 'E0005' WHERE id = 3;
UPDATE department SET manager = 'E0007' WHERE id = 4;


------------------------------------------------------------
-- 6. Employee skills
------------------------------------------------------------

INSERT INTO employee_skill (id, employee_id, skill_id)
VALUES
  (1, 1, 4),   -- E0001 TEACH
  (2, 1, 1),   -- E0001 SQL
  (3, 2, 1),   -- E0002 SQL
  (4, 2, 2),   -- E0002 PYTHON
  (5, 3, 4),   -- E0003 TEACH
  (6, 4, 2),   -- E0004 PYTHON
  (7, 5, 3),   -- E0005 LINUX
  (8, 5, 4),   -- E0005 TEACH
  (9, 6, 3),   -- E0006 LINUX
  (10,7, 5),   -- E0007 ADMIN
  (11,8, 5);   -- E0008 ADMIN


------------------------------------------------------------
-- 7. Course layouts
------------------------------------------------------------

INSERT INTO course_layout (id, course_code, course_name,
                           min_students, max_students, hp)
VALUES
  (1, 'DA101', 'Introduction to Databases', '10', '200', '7.5'),
  (2, 'PG201', 'Programming Fundamentals',   '15', '250', '7.5'),
  (3, 'MG301', 'Industrial Management',      '20', '180', '6.0');


------------------------------------------------------------
-- 8. Course instances (offerings)
------------------------------------------------------------

INSERT INTO course_instance (course_instance_id, instance_id,
                             num_students, study_period, study_year,
                             course_layout_id)
VALUES
  (1, 'DA101-25P1', '120', 'P1', '2025', 1),
  (2, 'DA101-25P3', ' 90', 'P3', '2025', 1),
  (3, 'PG201-25P2', '150', 'P2', '2025', 2),
  (4, 'PG201-25P4', '130', 'P4', '2025', 2),
  (5, 'MG301-25P1', ' 80', 'P1', '2025', 3),
  (6, 'MG301-25P3', ' 70', 'P3', '2025', 3);


------------------------------------------------------------
-- 9. Teaching activities
------------------------------------------------------------

INSERT INTO teaching_activity (teaching_activity_id, activity_name, factor)
VALUES
  (1, 'LECTURE', 2),
  (2, 'LAB',     2),
  (3, 'SEMINAR', 1),
  (4, 'EXAM',    1);


------------------------------------------------------------
-- 10. Planned activities
------------------------------------------------------------

INSERT INTO planned_activity (id, planned_hours,
                              course_inst_id, teaching_activity_id)
VALUES
  (1, '2', 1, 1),   -- lecture for DA101-25P1
  (2, '2', 1, 1),
  (3, '3', 1, 2),   -- lab
  (4, '2', 2, 1),
  (5, '3', 2, 2),
  (6, '2', 3, 1),
  (7, '2', 3, 3),   -- seminar
  (8, '2', 4, 1),
  (9, '2', 5, 3),
  (10,'4', 6, 4);   -- exam


------------------------------------------------------------
-- 11. Employee allocation to planned activities
------------------------------------------------------------

INSERT INTO employee_allocation (employee_allocation_id,
                                 employee_id, planned_activity_id)
VALUES
  (1, 1, 1),   -- Prof E0001 teaches first DA lecture
  (2, 2, 2),   -- Lecturer E0002 second lecture
  (3, 2, 3),   -- E0002 lab
  (4, 3, 6),   -- E0003 math/related lecture
  (5, 4, 7),   -- TA E0004 seminar
  (6, 5, 8),   -- E0005 lecture
  (7, 7, 9),   -- E0007 seminar for management
  (8, 5,10),   -- E0005 exam
  (9, 6, 3),   -- E0006 assists lab
  (10,6,10);   -- E0006 assists exam
