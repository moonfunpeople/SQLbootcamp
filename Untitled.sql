create database BOOTCAMP_EXERCISE1;
use BOOTCAMP_EXERCISE1;

CREATE TABLE regions (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(25)
);

CREATE TABLE countries (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40),
    region_id INT,
    FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

CREATE TABLE locations (
    location_id INT PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(25),
    country_id CHAR(2),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(30),
    manager_id INT,
    location_id INT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)

);

CREATE TABLE jobs (
    job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35),
    min_salary INT,
    max_salary INT
);

CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25),
    phone_number VARCHAR(20),
    hire_date DATE,
    job_id VARCHAR(10),
    salary DECIMAL(10, 2),
    commission_pct DECIMAL(2, 2),
    manager_id INT,
    department_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE job_history (
    employee_id INT,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR(10),
    department_id INT,
    PRIMARY KEY (employee_id, start_date),
     FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO regions (region_id)  VALUES 
(1),
(2),
(3);
 
INSERT INTO COUNTRIES (country_id, country_name, region_id) VALUES
('DE', 'Germany', 1),
('IT', 'Italy', 1),
('JP', 'Japan', 3),
('US', 'United State', 2);

INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, state_province, country_id) VALUES
(1000, '1297 Via Cola di Rie', '989', 'Roma', NULL, 'IT'),
(1100, '93091 Calle della Te', '10934', 'Venice', NULL, 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo', 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');

INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) VALUES
(10, 'Administration', 200, 1100),
(20, 'Marketing', 201, 1200),
(30, 'Purchasing', 202, 1400);

ALTER TABLE jobs 
MODIFY job_title VARCHAR(35) DEFAULT NULL,
MODIFY min_salary INT DEFAULT NULL,
MODIFY max_salary INT DEFAULT NULL;

INSERT INTO jobs (job_id) VALUES
('IT_PROG'),
('MK_REP'),
('ST_CLERK');


INSERT INTO employees (employee_id, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID) VALUES
(100,'Steven', 'King', 'SKING', '515-1234567', '1987-06-17', 'ST_CLERK', 24000.00, 0.00, 109, 10),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515-1234568', '1987-06-18', 'MK_REP', 17000.00, 0.00, 103, 20),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515-1234569', '1987-06-19', 'IT_PROG', 17000.00, 0.00, 108, 30),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590-4234567', '1987-06-20', 'MK_REP', 9000.00, 0.00, 105, 20);

INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id) VALUES
(102, '1993-01-13', '1998-07-24', 'IT_PROG', 20),
(101, '1989-09-21', '1993-10-27', 'MK_REP', 20),
(101, '1993-10-28', '1997-03-15', 'MK_REP', 30),
(100, '1996-02-17', '1999-12-19', 'ST_CLERK', 30),
(103, '1998-03-24', '1999-12-31', 'MK_REP', 20);

select a.location_id, a.street_address, a.city, a.state_province, b.country_name
from locations a left join countries b on a.country_id = b.country_id;

select first_name, last_name, department_id from employees;

select e.first_name, e.last_name, e.job_id, e.department_id 
from employees e 
left join departments d on e.department_id = d.department_id
left join locations l on d.location_id = l.location_id
left join countries c on l.country_id = c.country_id
where country_name='Japan';

SELECT e.employee_id, e.last_name AS employee_last_name, e.manager_id, m.last_name AS manager_last_name
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date > (
    SELECT hire_date
    FROM employees
    WHERE first_name = 'Lex' AND last_name = 'De Haan'
);

SELECT d.department_name, COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

SELECT 
    jh.employee_id,
    jh.job_id,
    j.job_title,
    DATEDIFF(jh.end_date, jh.start_date) AS days
FROM job_history jh
JOIN jobs j ON jh.job_id = j.job_id
WHERE jh.department_id = 30;

SELECT 
    d.department_name,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name,
    l.city,
    c.country_name
FROM departments d
LEFT JOIN employees m ON d.manager_id = m.employee_id
LEFT JOIN locations l ON d.location_id = l.location_id
LEFT JOIN countries c ON l.country_id = c.country_id;

SELECT 
    d.department_name,
    AVG(e.salary) AS average_salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

create table jobs(
jobs_ID varchar(2) primary key,
job_title varchar(35),
grade_level varchar(2)
);

create table job_grades(
grade_level varchar(2) primary key,
lowest_salary numeric (10,2),
highest_salary numeric (10,2),
FOREIGN KEY (grade_level) REFERENCES jobs(grade_level)
);