------------------------------------------------------------
-- Reset (drop all tables if they exist)
------------------------------------------------------------
DROP TABLE IF EXISTS employee_allocation  CASCADE;
DROP TABLE IF EXISTS employee_skill       CASCADE;
DROP TABLE IF EXISTS skill_set            CASCADE;
DROP TABLE IF EXISTS planned_activity     CASCADE;
DROP TABLE IF EXISTS course_instance      CASCADE;
DROP TABLE IF EXISTS teaching_activity    CASCADE;
DROP TABLE IF EXISTS course_layout        CASCADE;
DROP TABLE IF EXISTS employee             CASCADE;
DROP TABLE IF EXISTS phone_number         CASCADE;
DROP TABLE IF EXISTS address              CASCADE;
DROP TABLE IF EXISTS job_title            CASCADE;
DROP TABLE IF EXISTS department           CASCADE;
DROP TABLE IF EXISTS person               CASCADE;

------------------------------------------------------------
-- person
------------------------------------------------------------
CREATE TABLE person (
    id              INT PRIMARY KEY,
    personal_number VARCHAR(12) UNIQUE,
    first_name      VARCHAR(500),
    last_name       VARCHAR(10)
);

------------------------------------------------------------
-- phone_number
------------------------------------------------------------
CREATE TABLE phone_number (
    phone_id     INT PRIMARY KEY,
    phone_number CHAR(10) NOT NULL UNIQUE,
    person_id    INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id)
);

------------------------------------------------------------
-- address
------------------------------------------------------------
CREATE TABLE address (
    address_id INT PRIMARY KEY,
    address    CHAR(10) NOT NULL,
    person_id  INT,
    FOREIGN KEY (person_id) REFERENCES person(id)
);

------------------------------------------------------------
-- department
------------------------------------------------------------
CREATE TABLE department (
    id              INT PRIMARY KEY,
    department_name VARCHAR(10) UNIQUE,
    manager         VARCHAR(10)
);

------------------------------------------------------------
-- job_title
------------------------------------------------------------
CREATE TABLE job_title (
    id        INT PRIMARY KEY,
    job_title VARCHAR(10) NOT NULL UNIQUE
);

------------------------------------------------------------
-- employee
------------------------------------------------------------
CREATE TABLE employee (
    id                 INT PRIMARY KEY,
    employment_id      VARCHAR(10) NOT NULL UNIQUE,
    salary             VARCHAR(10),
    supervisor_manager VARCHAR(10),
    person_id          INT NOT NULL,
    job_id             INT NOT NULL,
    department_id      INT NOT NULL,
    FOREIGN KEY (person_id)     REFERENCES person(id),
    FOREIGN KEY (job_id)        REFERENCES job_title(id),
    FOREIGN KEY (department_id) REFERENCES department(id)
);

------------------------------------------------------------
-- skill_set
------------------------------------------------------------
CREATE TABLE skill_set (
    skill_id INT PRIMARY KEY,
    skill    VARCHAR(10) NOT NULL UNIQUE
);

------------------------------------------------------------
-- employee_skill
------------------------------------------------------------
CREATE TABLE employee_skill (
    id          INT PRIMARY KEY,
    employee_id INT,
    skill_id    INT,
    FOREIGN KEY (employee_id) REFERENCES employee(id),
    FOREIGN KEY (skill_id)    REFERENCES skill_set(skill_id)
);

------------------------------------------------------------
-- course_layout
------------------------------------------------------------
CREATE TABLE course_layout (
    id           INT PRIMARY KEY,
    course_code  VARCHAR(10) NOT NULL UNIQUE,
    course_name  VARCHAR(500) NOT NULL,
    min_students VARCHAR(4),
    max_students VARCHAR(4),
    hp           VARCHAR(5) NOT NULL
);

------------------------------------------------------------
-- teaching_activity
------------------------------------------------------------
CREATE TABLE teaching_activity (
    teaching_activity_id INT PRIMARY KEY,
    activity_name        VARCHAR(10) UNIQUE,
    factor               INT
);

------------------------------------------------------------
-- course_instance
------------------------------------------------------------
CREATE TABLE course_instance (
    course_instance_id INT PRIMARY KEY,
    instance_id        VARCHAR(10) NOT NULL UNIQUE,
    num_students       VARCHAR(10),
    study_period       VARCHAR(10),
    study_year         VARCHAR(10),
    course_layout_id   INT NOT NULL,
    FOREIGN KEY (course_layout_id) REFERENCES course_layout(id)
);

------------------------------------------------------------
-- planned_activity
------------------------------------------------------------
CREATE TABLE planned_activity (
    id                   INT PRIMARY KEY,
    planned_hours        VARCHAR(10) NOT NULL,
    course_inst_id       INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    FOREIGN KEY (course_inst_id)       REFERENCES course_instance(course_instance_id),
    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(teaching_activity_id)
);

------------------------------------------------------------
-- employee_allocation
------------------------------------------------------------
CREATE TABLE employee_allocation (
    employee_allocation_id INT PRIMARY KEY,
    employee_id            INT,
    planned_activity_id    INT,
    FOREIGN KEY (employee_id)         REFERENCES employee(id),
    FOREIGN KEY (planned_activity_id) REFERENCES planned_activity(id)
);

------------------------------------------------------------
-- Simple indexes on common FK columns (optional but nice)
------------------------------------------------------------
CREATE INDEX idx_phone_person           ON phone_number(person_id);
CREATE INDEX idx_address_person         ON address(person_id);
CREATE INDEX idx_employee_person        ON employee(person_id);
CREATE INDEX idx_employee_department    ON employee(department_id);
CREATE INDEX idx_employee_job           ON employee(job_id);
CREATE INDEX idx_emp_skill_employee     ON employee_skill(employee_id);
CREATE INDEX idx_emp_skill_skill        ON employee_skill(skill_id);
CREATE INDEX idx_course_inst_layout     ON course_instance(course_layout_id);
CREATE INDEX idx_planned_course_inst    ON planned_activity(course_inst_id);
CREATE INDEX idx_planned_teaching_act   ON planned_activity(teaching_activity_id);
CREATE INDEX idx_alloc_employee         ON employee_allocation(employee_id);
CREATE INDEX idx_alloc_planned_activity ON employee_allocation(planned_activity_id);
