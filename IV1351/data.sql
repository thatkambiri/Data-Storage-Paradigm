-- ============================================================
-- PERSON
-- ============================================================
CREATE TABLE person (
    id                INT PRIMARY KEY,
    personal_number   VARCHAR(20) UNIQUE NOT NULL,
    first_name        VARCHAR(100) NOT NULL,
    last_name         VARCHAR(100) NOT NULL
);

-- ============================================================
-- PHONE NUMBER
-- ============================================================
CREATE TABLE phone_number (
    id            INT PRIMARY KEY,
    phone_number  CHAR(10) UNIQUE NOT NULL,
    person_id     INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id)
        ON DELETE CASCADE
);

-- ============================================================
-- ADDRESS
-- ============================================================
CREATE TABLE address (
    id          INT PRIMARY KEY,
    address     CHAR(100) NOT NULL,
    person_id   INT NOT NULL,
    FOREIGN KEY (person_id) REFERENCES person(id)
        ON DELETE CASCADE
);

-- ============================================================
-- JOB TITLE
-- ============================================================
CREATE TABLE job_title (
    id          INT PRIMARY KEY,
    job_title   VARCHAR(40) UNIQUE NOT NULL
);

-- ============================================================
-- DEPARTMENT
-- ============================================================
CREATE TABLE department (
    id                    INT PRIMARY KEY,
    department_name       VARCHAR(40) UNIQUE NOT NULL,
    manager               INT NULL      -- links to employee.id
);

-- ============================================================
-- EMPLOYEE
-- ============================================================
CREATE TABLE employee (
    id                  INT PRIMARY KEY,
    employment_id       VARCHAR(100) UNIQUE NOT NULL,
    salary              INT NOT NULL,
    person_id           INT NOT NULL,
    job_title_id        INT NOT NULL,
    department_id       INT NULL,
    supervisor_id       INT NULL,

    FOREIGN KEY (person_id) REFERENCES person(id)
        ON DELETE CASCADE,
    FOREIGN KEY (job_title_id) REFERENCES job_title(id)
        ON DELETE RESTRICT,
    FOREIGN KEY (department_id) REFERENCES department(id)
        ON DELETE SET NULL,
    FOREIGN KEY (supervisor_id) REFERENCES employee(id)
        ON DELETE SET NULL
);

-- ============================================================
-- SKILL
-- ============================================================
CREATE TABLE skill (
    id          INT PRIMARY KEY,
    skill_name  VARCHAR(40) UNIQUE NOT NULL
);

-- ============================================================
-- EMPLOYEE SKILL
-- ============================================================
CREATE TABLE employee_skill (
    employee_id INT NOT NULL,
    skill_id    INT NOT NULL,
    PRIMARY KEY (employee_id, skill_id),
    FOREIGN KEY (employee_id) REFERENCES employee(id)
        ON DELETE CASCADE,
    FOREIGN KEY (skill_id) REFERENCES skill(id)
        ON DELETE CASCADE
);

-- ============================================================
-- COURSE LAYOUT
-- ============================================================
CREATE TABLE course_layout (
    id            INT PRIMARY KEY,
    course_code   VARCHAR(10) UNIQUE NOT NULL,
    course_name   VARCHAR(60) NOT NULL,
    min_students  INT NOT NULL,
    max_students  INT NOT NULL,
    hp            INT NOT NULL
);

-- ============================================================
-- COURSE INSTANCE
-- ============================================================
CREATE TABLE course_instance (
    id               INT PRIMARY KEY,
    instance_id      VARCHAR(100) UNIQUE NOT NULL,
    num_students     INT NOT NULL,
    study_period     VARCHAR(10) NOT NULL,
    study_year       VARCHAR(10) NOT NULL,
    course_layout_id INT NOT NULL,
    FOREIGN KEY (course_layout_id) REFERENCES course_layout(id)
        ON DELETE CASCADE
);

-- ============================================================
-- TEACHING ACTIVITY
-- ============================================================
CREATE TABLE teaching_activity (
    id            INT PRIMARY KEY,
    activity_name VARCHAR(40) UNIQUE NOT NULL,
    factor        INT NOT NULL
);

-- ============================================================
-- PLANNED ACTIVITY
-- ============================================================
CREATE TABLE planned_activity (
    id                    INT PRIMARY KEY,
    teaching_activity_id  INT NOT NULL,
    course_layout_id      INT NOT NULL,
    planned_hours         INT NOT NULL,

    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(id)
        ON DELETE RESTRICT,

    FOREIGN KEY (course_layout_id) REFERENCES course_layout(id)
        ON DELETE CASCADE
);

-- ============================================================
-- EMPLOYEE ALLOCATION
-- ============================================================
CREATE TABLE employee_allocation (
    id                   INT PRIMARY KEY,
    employee_id          INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    course_instance_id   INT NOT NULL,

    FOREIGN KEY (employee_id) REFERENCES employee(id)
        ON DELETE CASCADE,

    FOREIGN KEY (teaching_activity_id) REFERENCES teaching_activity(id)
        ON DELETE RESTRICT,

    FOREIGN KEY (course_instance_id) REFERENCES course_instance(id)
        ON DELETE CASCADE
);



-- Business rule:
-- A teacher cannot be allocated to more than 4 course instances simultaneously.
-- Must be handled by application logic or a trigger.
