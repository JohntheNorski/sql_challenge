/*DROP TABLE IF EXISTS dept_emp
	, dept_manager
	, departments
	, salaries
	, employees
	, titles
;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE titles (
    title_id VARCHAR NOT NULL
  , title VARCHAR NOT NULL
  , CONSTRAINT pk_titles PRIMARY KEY(title_id)
)
;

COPY titles(title_id, title)
FROM 'C:\Users\stodd\ku-ove-data-pt-10-2020-u-c\09-SQL\Homework\Instructions\data\titles.csv'
DELIMITER ','
CSV HEADER
;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE employees (
    emp_no INT NOT NULL
  , emp_title_id VARCHAR NOT NULL
  , birth_date DATE NOT NULL
  , first_name VARCHAR NOT NULL
  , last_name VARCHAR NOT NULL
  , sex VARCHAR NOT NULL
  , hire_date DATE NOT NULL
  , CONSTRAINT pk_employees PRIMARY KEY(emp_no)
  ,	CONSTRAINT fk_emp_title_id 
		FOREIGN KEY(emp_title_id)
		REFERENCES titles(title_id)
)
;

COPY employees(emp_no,emp_title_id,birth_date,first_name,last_name,sex,hire_date)
FROM 'C:\Users\stodd\ku-ove-data-pt-10-2020-u-c\09-SQL\Homework\Instructions\data\employees.csv'
DELIMITER ','
CSV HEADER
;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE salaries (
    emp_no INT NOT NULL
  , salary INT NOT NULL
  ,	CONSTRAINT fk_emp_no 
		FOREIGN KEY(emp_no)
		REFERENCES employees(emp_no)
)
;

COPY salaries(emp_no,salary)
FROM 'C:\Users\stodd\ku-ove-data-pt-10-2020-u-c\09-SQL\Homework\Instructions\data\salaries.csv'
DELIMITER ','
CSV HEADER
;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE departments (
    dept_no VARCHAR NOT NULL
  , dept_name VARCHAR NOT NULL
  , CONSTRAINT pk_departments PRIMARY KEY(dept_no)
)
;

COPY departments(dept_no,dept_name)
FROM 'C:\Users\stodd\ku-ove-data-pt-10-2020-u-c\09-SQL\Homework\Instructions\data\departments.csv'
DELIMITER ','
CSV HEADER
;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE dept_manager (
    dept_no VARCHAR NOT NULL
  , emp_no INT NOT NULL
  ,	CONSTRAINT fk_dept_no 
		FOREIGN KEY(dept_no)
		REFERENCES departments(dept_no)
  ,	CONSTRAINT fk_emp_no 
		FOREIGN KEY(emp_no)
		REFERENCES employees(emp_no)
)
;

COPY dept_manager(dept_no,emp_no)
FROM 'C:\Users\stodd\ku-ove-data-pt-10-2020-u-c\09-SQL\Homework\Instructions\data\dept_manager.csv'
DELIMITER ','
CSV HEADER
;
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE dept_emp (
    emp_no INT NOT NULL
  , dept_no VARCHAR NOT NULL
  ,	CONSTRAINT fk_dept_no_emp_table
		FOREIGN KEY(dept_no)
		REFERENCES departments(dept_no)
  ,	CONSTRAINT fk_emp_no_emp_table
		FOREIGN KEY(dept_no)
		REFERENCES departments(dept_no)
)
;

COPY dept_emp(emp_no,dept_no)
FROM 'C:\Users\stodd\ku-ove-data-pt-10-2020-u-c\09-SQL\Homework\Instructions\data\dept_emp.csv'
DELIMITER ','
CSV HEADER
;
*/

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Part 1, gathering salary

SELECT emp.emp_no
	, emp.first_name
	, emp.last_name
	, emp.sex
	, sal.salary
FROM employees emp

LEFT JOIN salaries sal ON sal.emp_no = emp.emp_no
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Part 2, hire date for 1986 hires

SELECT emp.first_name
	, emp.last_name
	, emp.hire_date
FROM employees emp

WHERE DATE_PART('year',emp.hire_date) = '1986'
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Part 3, manager information

SELECT dm.dept_no
	, dep.dept_name
	, dm.emp_no
	, emp.last_name
	, emp.first_name
FROM dept_manager dm

LEFT JOIN departments dep ON dep.dept_no = dm.dept_no
LEFT JOIN employees emp ON emp.emp_no = dm.emp_no
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Part 4, department information for employees

SELECT emp.emp_no
	, emp.last_name
	, emp.first_name
	, dep.dept_name
FROM employees emp

LEFT JOIN dept_emp de ON de.emp_no = emp.emp_no
LEFT JOIN departments dep ON dep.dept_no = de.dept_no
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Part 5, Hercules?

SELECT emp.first_name
	, emp.last_name
	, emp.sex
FROM employees emp

WHERE emp.first_name = 'Hercules' 
	AND emp.last_name LIKE 'B%'
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Part 6, Sales employees

SELECT emp.emp_no
	, emp.last_name
	, emp.first_name
	, dep.dept_name
FROM employees emp

LEFT JOIN dept_emp de ON de.emp_no = emp.emp_no
LEFT JOIN departments dep ON dep.dept_no = de.dept_no

WHERE dep.dept_name = 'Sales'
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Part 7, Sales...AND development employees

SELECT emp.emp_no
	, emp.last_name
	, emp.first_name
	, dep.dept_name
FROM employees emp

LEFT JOIN dept_emp de ON de.emp_no = emp.emp_no
LEFT JOIN departments dep ON dep.dept_no = de.dept_no

WHERE (dep.dept_name = 'Sales')
	OR (dep.dept_name = 'Development')
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Part 8, Frequency count of shared last names

SELECT emp.last_name
	, COUNT(emp.last_name) frequency
FROM employees emp

GROUP BY emp.last_name
ORDER BY emp.last_name DESC
;

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Epilogue, My ID?

SELECT *
FROM employees emp

WHERE emp.emp_no = 499942



