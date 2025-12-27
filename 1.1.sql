-- ==========================
-- Sample Data Insertions
-- ==========================

-- 1. Persons
INSERT INTO person (id, personal_number, first_name, last_name) VALUES
(1,'199001010001','Alice','Andersson'),
(2,'199002020002','Bob','Berg'),
(3,'199003030003','Charlie','Carlsson'),
(4,'199004040004','David','Dahl'),
(5,'199005050005','Eva','Ek'),
(6,'199006060006','Fred','Falk'),
(7,'199007070007','Gina','Gran'),
(8,'199008080008','Hugo','Hansson'),
(9,'199009090009','Iris','Isaksson'),
(10,'199010100010','Jonas','Johansson'),
(11,'199011110011','Karin','Karlsson'),
(12,'199012120012','Lars','Lind'),
(13,'199101010013','Mia','Magnusson'),
(14,'199102020014','Nils','Nilsson'),
(15,'199103030015','Olivia','Olofsson'),
(16,'199104040016','Patrik','Persson'),
(17,'199105050017','Quinn','Qvist'),
(18,'199106060018','Rebecka','Rosen'),
(19,'199107070019','Stefan','Svensson'),
(20,'199108080020','Tina','Thorsson'),
(21,'199109090021','Ulf','Ulriksson'),
(22,'199110100022','Vera','Viklund'),
(23,'199111110023','William','Wallin'),
(24,'199112120024','Xenia','Xander'),
(25,'199201010025','Yasmin','Ylva'),
(26,'199202020026','Zara','Zetterberg'),
(27,'199203030027','Aaron','Alm'),
(28,'199204040028','Britta','Bergman'),
(29,'199205050029','Carl','Claesson'),
(30,'199206060030','Diana','Dahlberg');

-- 2. Job Titles
INSERT INTO job_title (id, job_title) VALUES
(1,'Lecturer'),
(2,'Assistant Professor'),
(3,'Professor'),
(4,'Researcher'),
(5,'Lab Assistant'),
(6,'Administrator'),
(7,'IT Specialist'),
(8,'HR Manager'),
(9,'Finance Officer'),
(10,'Project Coordinator');

-- 3. Skill Sets
INSERT INTO skill_set (skill_id, skill) VALUES
(1,'Python'),(2,'C Programming'),(3,'SQL'),(4,'Data Analysis'),(5,'Machine Learning'),
(6,'Teaching'),(7,'Project Management'),(8,'Communication'),(9,'Research'),(10,'Statistics'),
(11,'Lab Management'),(12,'Public Speaking'),(13,'Leadership'),(14,'Writing'),(15,'Budgeting');

-- 4. Departments (manager_id will be updated later)
INSERT INTO department (id, department_name) VALUES
(1,'Computer Science'),
(2,'Mathematics'),
(3,'Physics'),
(4,'Chemistry'),
(5,'Administration');

-- 5. Employees (random supervisors for simplicity)
INSERT INTO employee (id, employment_id, salary, supervisor_manager_id, job_id, department_id) VALUES
(1,'EMP001',50000,NULL,3,1),
(2,'EMP002',45000,1,2,1),
(3,'EMP003',40000,1,1,1),
(4,'EMP004',48000,NULL,3,2),
(5,'EMP005',42000,4,2,2),
(6,'EMP006',38000,4,1,2),
(7,'EMP007',47000,NULL,3,3),
(8,'EMP008',41000,7,2,3),
(9,'EMP009',39000,7,1,3),
(10,'EMP010',52000,NULL,4,4),
(11,'EMP011',45000,10,2,4),
(12,'EMP012',37000,10,5,4),
(13,'EMP013',43000,NULL,6,5),
(14,'EMP014',40000,13,7,5),
(15,'EMP015',39000,13,8,5),
(16,'EMP016',41000,NULL,2,1),
(17,'EMP017',39000,16,1,1),
(18,'EMP018',45000,NULL,3,2),
(19,'EMP019',42000,18,2,2),
(20,'EMP020',39000,18,1,2),
(21,'EMP021',47000,NULL,3,3),
(22,'EMP022',40000,21,1,3),
(23,'EMP023',45000,NULL,2,4),
(24,'EMP024',38000,23,1,4),
(25,'EMP025',41000,NULL,6,5),
(26,'EMP026',39000,25,7,5),
(27,'EMP027',42000,NULL,4,1),
(28,'EMP028',40000,27,1,1),
(29,'EMP029',43000,NULL,3,2),
(30,'EMP030',39000,29,1,2);

-- 6. Update department managers
UPDATE department SET manager_id = 1 WHERE id=1;
UPDATE department SET manager_id = 4 WHERE id=2;
UPDATE department SET manager_id = 7 WHERE id=3;
UPDATE department SET manager_id = 10 WHERE id=4;
UPDATE department SET manager_id = 13 WHERE id=5;

-- 7. Phone numbers
INSERT INTO phone_number (phone_id, phone_number, person_id) VALUES
(1,'0701000001',1),(2,'0701000002',2),(3,'0701000003',3),(4,'0701000004',4),
(5,'0701000005',5),(6,'0701000006',6),(7,'0701000007',7),(8,'0701000008',8),
(9,'0701000009',9),(10,'0701000010',10),(11,'0701000011',11),(12,'0701000012',12),
(13,'0701000013',13),(14,'0701000014',14),(15,'0701000015',15),(16,'0701000016',16),
(17,'0701000017',17),(18,'0701000018',18),(19,'0701000019',19),(20,'0701000020',20),
(21,'0701000021',21),(22,'0701000022',22),(23,'0701000023',23),(24,'0701000024',24),
(25,'0701000025',25),(26,'0701000026',26),(27,'0701000027',27),(28,'0701000028',28),
(29,'0701000029',29),(30,'0701000030',30);

-- 8. Addresses
INSERT INTO address (address_id, address, person_id) VALUES
(1,'Street 1, City A',1),(2,'Street 2, City B',2),(3,'Street 3, City C',3),
(4,'Street 4, City D',4),(5,'Street 5, City E',5),(6,'Street 6, City F',6),
(7,'Street 7, City G',7),(8,'Street 8, City H',8),(9,'Street 9, City I',9),
(10,'Street 10, City J',10),(11,'Street 11, City K',11),(12,'Street 12, City L',12),
(13,'Street 13, City M',13),(14,'Street 14, City N',14),(15,'Street 15, City O',15),
(16,'Street 16, City P',16),(17,'Street 17, City Q',17),(18,'Street 18, City R',18),
(19,'Street 19, City S',19),(20,'Street 20, City T',20),(21,'Street 21, City U',21),
(22,'Street 22, City V',22),(23,'Street 23, City W',23),(24,'Street 24, City X',24),
(25,'Street 25, City Y',25),(26,'Street 26, City Z',26),(27,'Street 27, City AA',27),
(28,'Street 28, City AB',28),(29,'Street 29, City AC',29),(30,'Street 30, City AD',30);

-- 9. Employee skills (M:N)
INSERT INTO employee_skill (employee_id, skill_id) VALUES
(1,3),(1,6),(2,1),(2,6),(3,2),(3,6),(4,3),(4,6),(5,2),(5,6),
(6,1),(6,6),(7,4),(7,6),(8,5),(8,6),(9,1),(9,6),(10,3),(10,6),
(11,2),(11,6),(12,5),(12,6),(13,7),(13,8),(14,7),(14,8),(15,7),(15,8),
(16,1),(16,6),(17,2),(17,6),(18,3),(18,6),(19,4),(19,6),(20,5),(20,6),
(21,1),(21,6),(22,2),(22,6),(23,7),(23,8),(24,7),(24,8),(25,7),(25,8),
(26,1),(26,6),(27,3),(27,6),(28,2),(28,6),(29,4),(29,6),(30,5),(30,6);

-- 10. Course layouts
INSERT INTO course_layout (id, course_code, course_name) VALUES
(1,'CS101','Intro to Computer Science'),
(2,'CS102','Data Structures'),
(3,'CS103','Algorithms'),
(4,'MATH101','Calculus I'),
(5,'MATH102','Linear Algebra'),
(6,'MATH103','Statistics'),
(7,'PHYS101','Mechanics'),
(8,'PHYS102','Electromagnetism'),
(9,'CHEM101','General Chemistry'),
(10,'CHEM102','Organic Chemistry'),
(11,'CS201','Databases'),
(12,'CS202','Operating Systems'),
(13,'CS203','Networks'),
(14,'CS204','Software Engineering'),
(15,'CS205','Artificial Intelligence');

-- 11. Course Versions (HP, min/max students, start/end date)
INSERT INTO course_version (id, hp, min_students, max_students, start_date, end_date, course_layout_id) VALUES
(1,'7.5','50','250','2025-01-01','2025-06-30',1),
(2,'7.5','50','150','2025-01-01','2025-06-30',2),
(3,'7.5','20','100','2025-01-01','2025-06-30',3),
(4,'7.5','20','100','2025-01-01','2025-06-30',4),
(5,'7.5','20','100','2025-01-01','2025-06-30',5),
(6,'7.5','30','120','2025-01-01','2025-06-30',6),
(7,'7.5','30','120','2025-01-01','2025-06-30',7),
(8,'7.5','25','110','2025-01-01','2025-06-30',8),
(9,'7.5','25','110','2025-01-01','2025-06-30',9),
(10,'7.5','30','130','2025-01-01','2025-06-30',10),
(11,'7.5','20','100','2025-01-01','2025-06-30',11),
(12,'7.5','20','100','2025-01-01','2025-06-30',12),
(13,'7.5','20','100','2025-01-01','2025-06-30',13),
(14,'7.5','20','100','2025-01-01','2025-06-30',14),
(15,'7.5','20','100','2025-01-01','2025-06-30',15);

-- 12. Course Instances (assigning courses to periods)
INSERT INTO course_instance (instance_id, num_students, study_year, course_version_id) VALUES
(1,'120','2025',1),
(2,'100','2025',2),
(3,'90','2025',3),
(4,'80','2025',4),
(5,'70','2025',5),
(6,'60','2025',6),
(7,'50','2025',7),
(8,'40','2025',8),
(9,'30','2025',9),
(10,'25','2025',10),
(11,'100','2025',11),
(12,'90','2025',12),
(13,'80','2025',13),
(14,'70','2025',14),
(15,'60','2025',15);

-- 13. Periods (4 periods)
INSERT INTO period (id, period) VALUES
(1,'P1'),(2,'P2'),(3,'P3'),(4,'P4');

-- 14. Course Instance Period mapping
INSERT INTO course_instance_period (instance_id, period_id) VALUES
(1,1),(2,1),(3,2),(4,2),(5,3),(6,3),(7,4),(8,4),(9,1),(10,2),
(11,3),(12,4),(13,1),(14,2),(15,3);

-- 15. Teaching Activities with multiplication factors
INSERT INTO teaching_activity (teaching_activity_id, activity_name, factor) VALUES
(1,'Lecture',3.6),
(2,'Lab',2.4),
(3,'Tutorial',2.4),
(4,'Seminar',1.8),
(5,'Examination',1.2),
(6,'Administration',1.0),
(7,'Others',1.0);

-- 16. Planned Activities (hours before multiplication)
INSERT INTO planned_activity (teaching_activity_id, instance_id, planned_hours) VALUES
-- Course instance 1
(1,1,20),(2,1,10),(3,1,5),(4,1,8),(5,1,2),
-- Course instance 2
(1,2,25),(2,2,12),(3,2,6),(4,2,7),(5,2,2),
-- Course instance 3
(1,3,30),(2,3,15),(3,3,10),(4,3,8),(5,3,3),
-- Course instance 4
(1,4,20),(2,4,10),(3,4,5),(4,4,6),(5,4,2),
-- Course instance 5
(1,5,25),(2,5,12),(3,5,6),(4,5,7),(5,5,3),
-- Course instance 6
(1,6,20),(2,6,10),(3,6,5),(4,6,6),(5,6,2),
-- Course instance 7
(1,7,18),(2,7,8),(3,7,4),(4,7,5),(5,7,2),
-- Course instance 8
(1,8,22),(2,8,11),(3,8,6),(4,8,6),(5,8,2),
-- Course instance 9
(1,9,20),(2,9,10),(3,9,5),(4,9,5),(5,9,2),
-- Course instance 10
(1,10,25),(2,10,12),(3,10,6),(4,10,7),(5,10,3),
-- Course instance 11
(1,11,20),(2,11,10),(3,11,5),(4,11,6),(5,11,2),
-- Course instance 12
(1,12,18),(2,12,9),(3,12,5),(4,12,5),(5,12,2),
-- Course instance 13
(1,13,22),(2,13,11),(3,13,6),(4,13,6),(5,13,3),
-- Course instance 14
(1,14,20),(2,14,10),(3,14,5),(4,14,5),(5,14,2),
-- Course instance 15
(1,15,25),(2,15,12),(3,15,6),(4,15,7),(5,15,3);


-- 17. Employee allocations
INSERT INTO employee_allocation (employee_id, teaching_activity_id, instance_id) VALUES
-- Instance 1
(1,1,1),(2,2,1),(3,3,1),(4,4,1),(5,5,1),
-- Instance 2
(1,1,2),(2,2,2),(3,3,2),(4,4,2),(5,5,2),
-- Instance 3
(6,1,3),(7,2,3),(8,3,3),(9,4,3),(10,5,3),
-- Instance 4
(1,1,4),(2,2,4),(3,3,4),(4,4,4),(5,5,4),
-- Instance 5
(6,1,5),(7,2,5),(8,3,5),(9,4,5),(10,5,5),
-- Instance 6
(1,1,6),(2,2,6),(3,3,6),(4,4,6),(5,5,6),
-- Instance 7
(6,1,7),(7,2,7),(8,3,7),(9,4,7),(10,5,7),
-- Instance 8
(1,1,8),(2,2,8),(3,3,8),(4,4,8),(5,5,8),
-- Instance 9
(6,1,9),(7,2,9),(8,3,9),(9,4,9),(10,5,9),
-- Instance 10
(1,1,10),(2,2,10),(3,3,10),(4,4,10),(5,5,10),
-- Instance 11
(6,1,11),(7,2,11),(8,3,11),(9,4,11),(10,5,11),
-- Instance 12
(1,1,12),(2,2,12),(3,3,12),(4,4,12),(5,5,12),
-- Instance 13
(6,1,13),(7,2,13),(8,3,13),(9,4,13),(10,5,13),
-- Instance 14
(1,1,14),(2,2,14),(3,3,14),(4,4,14),(5,5,14),
-- Instance 15
(6,1,15),(7,2,15),(8,3,15),(9,4,15),(10,5,15);