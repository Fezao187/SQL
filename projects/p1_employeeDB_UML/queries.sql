-- Create all tables
CREATE TABLE IF NOT EXISTS public.employess
(
    emp_id integer,
    first_name character varying(50),
    surname character varying(50),
    address character varying(100),
    email character varying(50),
    depart_id integer,
    role_id integer,
    salary_id integer,
    overtime_id integer,
    PRIMARY KEY (emp_id)
);

CREATE TABLE IF NOT EXISTS public.department
(
    depart_id integer,
    depart_name character varying(70),
    depart_city character varying(50),
    PRIMARY KEY (depart_id)
);

CREATE TABLE IF NOT EXISTS public.roles
(
    roles_id integer,
    role character varying(100),
    PRIMARY KEY (roles_id)
);

CREATE TABLE IF NOT EXISTS public.salaries
(
    salary_id integer,
    salary_pa bigint,
    PRIMARY KEY (salary_id)
);

CREATE TABLE IF NOT EXISTS public.overtime_hours
(
    overtime_id integer,
    overtime_hours integer,
    PRIMARY KEY (overtime_id)
);

-- Add foreign keys
ALTER TABLE IF EXISTS public.employess
    ADD FOREIGN KEY (depart_id)
    REFERENCES public.department (depart_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.employess
    ADD FOREIGN KEY (role_id)
    REFERENCES public.roles (roles_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.employess
    ADD FOREIGN KEY (salary_id)
    REFERENCES public.salaries (salary_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.employess
    ADD FOREIGN KEY (overtime_id)
    REFERENCES public.overtime_hours (overtime_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

-- Insert data into each table
-- Departments
INSERT INTO department(depart_id, depart_name, depart_city)
VALUES  (1, 'IT','CapeTown'),
        (2, 'Finance','Johannesburg'),
        (3, 'Logistics','Sandton'),
        (4, 'Legal','Durban'),
        (5, 'Human Resource','CapeTown');

-- Roles
INSERT INTO roles(roles_id, role)
VALUES  (1, 'HOD'),
        (2, 'Web dev'),
        (3, 'Lawyer'),
        (4, 'Accountant');

-- Salaries
INSERT INTO salaries(salary_id, salary_pa)
VALUES  (1, 400000),
        (2, 300000),
        (3, 1200000),
        (4, 500000);

-- Over time hours
INSERT INTO overtime_hours(overtime_id, overtime_hours)
VALUES  (1, 3),
        (2, 4),
        (3, 6),
        (4, 0),
        (5, 1);

-- Employees
INSERT INTO employess(emp_id, first_name, surname, address, email, depart_id, role_id, salary_id, overtime_id)
VALUES  (1, 'Katlego','Maredi','346 Johannesburg','Katlego@gmail.com', 5, 1, 3, 4),
        (2, 'Kristine','Wildheart','555 Johannesburg','Kristine@gmail.com', 3, 1, 4, 5),
        (3, 'John','Doe','121 Sandton','John@gmail.com', 4, 3, 2, 2),
        (4, 'Eric','Fez','232 Mdirand','Eric@gmail.com', 1, 2, 1, 3),
        (5, 'Stevey','Nicks','123 Johannesburg','Nicks@gmail.com', 2, 4, 4, 1),
        (6, 'Belinda','Carlisle','400 Sandton','Bell@gmail.com', 4, 3, 2, 2),
        (7, 'Bonnie','Tyler','200 Mdirand','Tyler@gmail.com', 1, 2, 1, 3),
        (8, 'Johnny','Test','123 Johannesburg','Test@gmail.com', 2, 4, 4, 1),
        (9, 'Ben','Ten','121 Braam','Ben@gmail.com', 4, 3, 2, 2),
        (10, 'Cyndi','Loper','11 Biccard','Cyndi@gmail.com', 1, 2, 1, 3);

-- LEFT JOIN query that will display the department name, job title, salary figure and overtime hours worked.
SELECT department.depart_name , roles.role AS job_title, salaries.salary_pa AS salary_figure, overtime_hours.overtime_hours AS overtime_hours_worked
FROM employess
LEFT JOIN department
ON employess.depart_id = department.depart_id
LEFT JOIN roles
ON employess.role_id = roles.roles_id 
LEFT JOIN salaries
ON employess.salary_id = salaries.salary_id
LEFT JOIN overtime_hours
ON employess.overtime_id = overtime_hours.overtime_id;