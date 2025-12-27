
-- =====================================================

-- Core entities
-- =====================================================

CREATE TABLE person (
    id              INT PRIMARY KEY,
    personal_number VARCHAR(12) UNIQUE NOT NULL,
    first_name      VARCHAR(50) NOT NULL,
    last_name       VARCHAR(50) NOT NULL
);

-- =====================================================
-- Job & skills
-- =====================================================

CREATE TABLE job_title (
    id        INT PRIMARY KEY,
    job_title VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE skill_set (
    skill_id INT PRIMARY KEY,
    skill    VARCHAR(100) UNIQUE NOT NULL
);

-- =====================================================
-- Department (manager FK added later)
-- =====================================================

CREATE TABLE department (
    id              INT PRIMARY KEY,
    department_name VARCHAR(100) UNIQUE NOT NULL,
    manager_id      INT
);

-- =====================================================
-- Employee
-- =====================================================

CREATE TABLE employee (
    id                    INT PRIMARY KEY,
    employment_id         VARCHAR(10) UNIQUE NOT NULL,
    salary                INT NOT NULL,
    supervisor_manager_id INT,
    job_id                INT NOT NULL,
    department_id         INT NOT NULL,

    FOREIGN KEY (id) REFERENCES person(id),
    FOREIGN KEY (supervisor_manager_id) REFERENCES employee(id),
    FOREIGN KEY (job_id) REFERENCES job_title(id),
    FOREIGN KEY (department_id) REFERENCES department(id)
);

-- Add manager FK after employee exists
ALTER TABLE department
ADD CONSTRAINT fk_department_manager
FOREIGN KEY (manager_id) REFERENCES employee(id);

-- =====================================================
-- Contact information
-- =====================================================

CREATE TABLE phone_number (
    phone_id     INT PRIMARY KEY,
    phone_number VARCHAR(20) UNIQUE NOT NULL,
    person_id    INT NOT NULL,
    FOREIGN KEY (person_id)
        REFERENCES person(id)
        ON DELETE CASCADE
);

CREATE TABLE address (
    address_id INT PRIMARY KEY,
    address    VARCHAR(100) NOT NULL,
    person_id  INT NOT NULL,
    FOREIGN KEY (person_id)
        REFERENCES person(id)
        ON DELETE CASCADE
);

-- =====================================================
-- Employee skills (M:N)
-- =====================================================

CREATE TABLE employee_skill (
    employee_id INT NOT NULL,
    skill_id    INT NOT NULL,
    PRIMARY KEY (employee_id, skill_id),
    FOREIGN KEY (employee_id)
        REFERENCES employee(id)
        ON DELETE CASCADE,
    FOREIGN KEY (skill_id)
        REFERENCES skill_set(skill_id)
);

-- =====================================================
-- Course structure
-- =====================================================

CREATE TABLE course_layout (
    id          INT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(500) NOT NULL
);

CREATE TABLE course_version (
    id               INT PRIMARY KEY,
    hp               VARCHAR(10) NOT NULL,
    min_students     CHAR(10),
    max_students     CHAR(10),
    start_date       DATE,
    end_date         DATE,
    course_layout_id INT NOT NULL,
    FOREIGN KEY (course_layout_id)
        REFERENCES course_layout(id)
        ON DELETE CASCADE
);

CREATE TABLE course_instance (
    instance_id       INT PRIMARY KEY,
    num_students      VARCHAR(10),
    study_year        VARCHAR(10),
    course_version_id INT NOT NULL,
    FOREIGN KEY (course_version_id)
        REFERENCES course_version(id)
        ON DELETE CASCADE,
    UNIQUE (course_version_id, study_year)
);

-- =====================================================
-- Periods
-- =====================================================

CREATE TABLE period (
    id     INT PRIMARY KEY,
    period VARCHAR(10) NOT NULL
);

CREATE TABLE course_instance_period (
    instance_id INT NOT NULL,
    period_id   INT NOT NULL,
    PRIMARY KEY (instance_id, period_id),
    FOREIGN KEY (instance_id)
        REFERENCES course_instance(instance_id)
        ON DELETE CASCADE,
    FOREIGN KEY (period_id)
        REFERENCES period(id)
);

-- =====================================================
-- Teaching activities & planning
-- =====================================================

CREATE TABLE teaching_activity (
    teaching_activity_id INT PRIMARY KEY,
    activity_name        VARCHAR(50) UNIQUE NOT NULL,
    factor               NUMERIC(5,2) NOT NULL CHECK (factor > 0)
);

CREATE TABLE planned_activity (
    teaching_activity_id INT NOT NULL,
    instance_id          INT NOT NULL,
    planned_hours        NUMERIC(5,2) NOT NULL CHECK (planned_hours >= 0),
    PRIMARY KEY (teaching_activity_id, instance_id),
    FOREIGN KEY (teaching_activity_id)
        REFERENCES teaching_activity(teaching_activity_id),
    FOREIGN KEY (instance_id)
        REFERENCES course_instance(instance_id)
        ON DELETE CASCADE
);

-- =====================================================
-- Employee allocation
-- =====================================================

CREATE TABLE employee_allocation (
    employee_id          INT NOT NULL,
    teaching_activity_id INT NOT NULL,
    instance_id          INT NOT NULL,
    PRIMARY KEY (employee_id, teaching_activity_id, instance_id),
    FOREIGN KEY (employee_id)
        REFERENCES employee(id)
        ON DELETE CASCADE,
    FOREIGN KEY (teaching_activity_id)
        REFERENCES teaching_activity(teaching_activity_id),
    FOREIGN KEY (instance_id)
        REFERENCES course_instance(instance_id)
        ON DELETE CASCADE
);
