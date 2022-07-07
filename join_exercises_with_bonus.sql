-- Create a file named join_exercises.sql to do your work in.
-- Join Example Database

-- Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;

-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. 
-- Before you run each query, guess the expected number of results.

SELECT *
FROM users
JOIN roles
ON users.id = roles.id;

SELECT *
FROM users
LEFT JOIN roles
ON users.id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles
ON users.id = roles.id;

-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. 
-- Use count and the appropriate join type to get a list of roles along with the number of users that has the role. 
-- Hint: You will also need to use group by in the query.

SELECT role_id, COUNT(*)
FROM users
JOIN roles
USING(id)
GROUP BY role_id;

-- Employees Database

-- Use the employees database.

USE employees;

-- Using the example in the Associative Table Joins section as a guide, write a query 
-- that shows each department along with the name of the current manager for that department.

--  Department Name    | Department Manager
--  -------------------+--------------------
--  Customer Service   | Yuchang Weedman
--  Development        | Leon DasSarma
--  Finance            | Isamu Legleitner
--  Human Resources    | Karsten Sigstam
--  Marketing          | Vishwani Minakawa
--  Production         | Oscar Ghazalie
--  Quality Management | Dung Pesch
--  Research           | Hilary Kambil
--  Sales              | Hauke Zhang

SELECT *
FROM dept_emp
LIMIT 500;

SELECT dept_name, CONCAT(first_name, " ", last_name) AS full_name
FROM departments
JOIN dept_manager
USING(dept_no)
JOIN employees
USING(emp_no)
WHERE to_date > CURDATE()
GROUP BY dept_name, full_name;

-- Find the name of all departments currently managed by women.

-- Department Name | Manager Name
-- ----------------+-----------------
-- Development     | Leon DasSarma
-- Finance         | Isamu Legleitner
-- Human Resources | Karsetn Sigstam
-- Research        | Hilary Kambil

SELECT dept_name, CONCAT(first_name, " ", last_name) AS full_name, gender
FROM departments
JOIN dept_manager
USING(dept_no)
JOIN employees
USING(emp_no)
WHERE gender = "F"
AND to_date > CURDATE()
GROUP BY dept_name, full_name, gender;

-- Find the current titles of employees currently working in the Customer Service department.

-- Title              | Count
-- -------------------+------
-- Assistant Engineer |    68
-- Engineer           |   627
-- Manager            |     1
-- Senior Engineer    |  1790
-- Senior Staff       | 11268
-- Staff              |  3574
-- Technique Leader   |   241

SELECT title, COUNT(*) AS num_emp_with_title
FROM titles
JOIN dept_emp
USING(to_date, emp_no)
JOIN departments
USING (dept_no)
WHERE to_date > CURDATE()
AND dept_name = "Customer Service"
GROUP BY title;

-- Find the current salary of all current managers.

-- Department Name    | Name              | Salary
-- -------------------+-------------------+-------
-- Customer Service   | Yuchang Weedman   |  58745
-- Development        | Leon DasSarma     |  74510
-- Finance            | Isamu Legleitner  |  83457
-- Human Resources    | Karsten Sigstam   |  65400
-- Marketing          | Vishwani Minakawa | 106491
-- Production         | Oscar Ghazalie    |  56654
-- Quality Management | Dung Pesch        |  72876
-- Research           | Hilary Kambil     |  79393
-- Sales              | Hauke Zhang       | 101987

SELECT dept_name, CONCAT(first_name, " ", last_name) AS full_name, salary
FROM salaries
JOIN dept_manager
USING(emp_no, to_date)
JOIN departments
USING(dept_no)
JOIN employees
USING (emp_no)
WHERE to_date > CURDATE()
GROUP BY dept_name, full_name, salary;

-- Find the number of current employees in each department.

-- +---------+--------------------+---------------+
-- | dept_no | dept_name          | num_employees |
-- +---------+--------------------+---------------+
-- | d001    | Marketing          | 14842         |
-- | d002    | Finance            | 12437         |
-- | d003    | Human Resources    | 12898         |
-- | d004    | Production         | 53304         |
-- | d005    | Development        | 61386         |
-- | d006    | Quality Management | 14546         |
-- | d007    | Sales              | 37701         |
-- | d008    | Research           | 15441         |
-- | d009    | Customer Service   | 17569         |
-- +---------+--------------------+---------------+

SELECT dept_name, COUNT(*) AS num_dept_emp
FROM departments
JOIN dept_emp
USING(dept_no)
WHERE to_date > CURDATE()
GROUP BY dept_name;

-- Which department has the highest average salary? 
-- Hint: Use current not historic information.

-- +-----------+----------------+
-- | dept_name | average_salary |
-- +-----------+----------------+
-- | Sales     | 88852.9695     |
-- +-----------+----------------+

SELECT dept_name, ROUND(AVG(salary), 2) AS avg_dept_salary
FROM departments
LEFT JOIN dept_emp
USING(dept_no)
LEFT JOIN employees
USING(emp_no)
LEFT JOIN salaries
USING(emp_no, to_date)
WHERE to_date > CURDATE()
GROUP BY dept_name
ORDER BY avg_dept_salary DESC
LIMIT 1;

SELECT *
FROM dept_emp
LIMIT 100;

-- Who is the highest paid employee in the Marketing department?

-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | Akemi      | Warwick   |
-- +------------+-----------+

SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees
JOIN dept_emp
USING(emp_no)
JOIN departments
USING(dept_no)
JOIN salaries
USING(emp_no, to_date)
WHERE dept_name = "Marketing"
AND to_date > CURDATE()
GROUP BY full_name, salary
ORDER BY salary DESC
LIMIT 1;


-- Which current department manager has the highest salary?



-- +------------+-----------+--------+-----------+
-- | first_name | last_name | salary | dept_name |
-- +------------+-----------+--------+-----------+
-- | Vishwani   | Minakawa  | 106491 | Marketing |
-- +------------+-----------+--------+-----------+

SELECT dept_name, CONCAT(first_name, " ", last_name) AS full_name, salary
FROM salaries
JOIN dept_manager
USING(emp_no, to_date)
JOIN departments
USING(dept_no)
JOIN employees
USING (emp_no)
WHERE to_date > CURDATE()
GROUP BY dept_name, full_name, salary
ORDER BY salary DESC
LIMIT 1;

-- Determine the average salary for each department. 
-- HINT: Use all historic salary information and round your results.

-- +--------------------+----------------+
-- | dept_name          | average_salary | 
-- +--------------------+----------------+
-- | Sales              | 80668          | 
-- +--------------------+----------------+
-- | Marketing          | 71913          |
-- +--------------------+----------------+
-- | Finance            | 70489          |
-- +--------------------+----------------+
-- | Research           | 59665          |
-- +--------------------+----------------+
-- | Production         | 59605          |
-- +--------------------+----------------+
-- | Development        | 59479          |
-- +--------------------+----------------+
-- | Customer Service   | 58770          |
-- +--------------------+----------------+
-- | Quality Management | 57251          |
-- +--------------------+----------------+
-- | Human Resources    | 55575          |
-- +--------------------+----------------+

SELECT dept_name, ROUND(AVG(salary), 2) AS avg_dept_salary
FROM departments
JOIN dept_emp
USING(dept_no)
JOIN employees
USING(emp_no)
JOIN salaries
USING(emp_no)
GROUP BY dept_name
ORDER BY avg_dept_salary DESC;

-- Bonus Questions:
-- Find the names of all current employees, their department name, and their current manager's name.

-- 240,124 Rows

-- Employee Name | Department Name  |  Manager Name
-- --------------|------------------|-----------------
-- Huan Lortz    | Customer Service | Yuchang Weedman
-- ...., etc.

SELECT CONCAT(e2.first_name, " ", e2.last_name) AS fullname_emp, dept_name, CONCAT(e1.first_name, " ", e1.last_name) AS fullname_mngr
FROM employees AS e1
JOIN dept_emp
ON e1.emp_no = dept_emp.emp_no
JOIN departments AS d1
ON d1.dept_no = dept_emp.dept_no
JOIN dept_manager
ON dept_manager.emp_no = e1.emp_no
JOIN dept_emp AS d2
ON d2.dept_no = dept_manager.dept_no
JOIN employees AS e2
ON e2.emp_no = d2.emp_no
WHERE dept_emp.to_date > CURDATE()
LIMIT 1000;


-- Bonus Who is the highest paid employee within each department.

SELECT *
	FROM
		(
		SELECT departments.dept_name, departments.dept_no, max(salaries.salary) as MaxSal
		FROM employees
		JOIN dept_emp
			USING (emp_no)
		JOIN departments
			ON departments.dept_no = dept_emp.dept_no
		JOIN salaries
			USING (emp_no)
		WHERE salaries.to_date > CURDATE()
		GROUP BY departments.dept_name
		) AS query2
	
    join
		(
		SELECT concat(employees.first_name,” “, employees.last_name) as Names, dept_emp.dept_no as currentDepartment, salaries.salary as CurrentSalary
		FROM employees
		JOIN salaries
			using (emp_no)
		JOIN dept_emp
			USING (emp_no)
		WHERE
				dept_emp.to_date > CURDATE()
			and
				salaries.to_date > CURDATE()
		) AS query3
    on query3.currentDepartment = query2.dept_no
	
    where MaxSal = CurrentSalary
