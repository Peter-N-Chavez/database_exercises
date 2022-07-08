-- Create a file named subqueries_exercises.sql and craft queries to return the results for the following criteria:

USE employees;

-- Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT CONCAT(employees.first_name, " ", employees.last_name) AS full_name, hire_date
FROM employees
JOIN salaries
USING(emp_no)
WHERE hire_date = (SELECT hire_date
					FROM  employees
					WHERE emp_no = 101010
					)
AND salaries.to_date > CURDATE()
;
-- Find all the titles ever held by all current employees with the first name Aamod.

SELECT title
FROM (SELECT title, emp_no
	FROM employees
    JOIN titles
    USING(emp_no)
    WHERE first_name = "Aamod"
    ) AS titles_all_time
JOIN salaries
USING (emp_no)
WHERE salaries.to_date > CURDATE()
GROUP BY title
;

-- How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.

SELECT (COUNT(*) - (SELECT COUNT(emp_no) 
	 FROM salaries
     JOIN dept_emp
     USING(emp_no)
     WHERE salaries.to_date > CURDATE()
     AND dept_emp.to_date > CURDATE()
     )) AS prev_emp 
FROM employees
;
-- 59900 people in the employees table are no longer with the company.

-- Find all the current department managers that are female. List their names in a comment in your code.

SELECT CONCAT(employees.first_name, " ", employees.last_name) AS full_name
FROM employees
JOIN dept_manager AS dm
USING(emp_no)
WHERE dm.to_date > CURDATE()
AND gender = "F";
-- 'Isamu Legleitner'
-- 'Karsten Sigstam'
-- 'Leon DasSarma'
-- 'Hilary Kambil'

-- Find all the employees who currently have a higher salary than the company's overall, historical average salary.

SELECT emp_no, CONCAT(employees.first_name, " ", employees.last_name)
FROM employees
JOIN salaries
USING(emp_no)
WHERE salaries.to_date > CURDATE()
AND salary > (SELECT AVG(salary)
			 FROM salaries)
;

-- How many current salaries are within 1 standard deviation of the current highest salary? 
-- (Hint: you can use a built in function to calculate the standard deviation.) 

SELECT CONCAT(employees.first_name, " ", employees.last_name) AS full_name, salary
FROM employees
JOIN salaries
USING(emp_no)
WHERE salaries.to_date > CURDATE()
AND salary >= (SELECT MAX(salary) FROM salaries WHERE salaries.to_date > CURDATE()) 
- (SELECT STDDEV(salary) FROM salaries WHERE salaries.to_date > CURDATE());
-- 83 employees have a salary within 1 STDDEV of the MAX salary. (returns 83 rows)

/*SELECT STDDEV(salary)
FROM salaries
WHERE salaries.to_date > CURDATE(); -- 17309.96

SELECT MAX(salary)
FROM salaries
WHERE salaries.to_date > CURDATE(); -- 158220*/


-- What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can.

SELECT COUNT(salary)
FROM salaries
WHERE salaries.to_date > CURDATE(); -- 240124 current salaries

SELECT (83/240124)*100; -- This represents .0346% of all current salaries.

-- Add a comment above the query showing the number of rows returned.
-- You will use this number (or the query that produced it) in other, larger queries.

-- BONUS QUESTIONS:

-- Find all the department names that currently have female managers.

SELECT dept_name, CONCAT(employees.first_name, " ", employees.last_name) AS full_name, gender
FROM departments
JOIN dept_emp
USING(dept_no)
JOIN employees
USING(emp_no)
JOIN dept_manager
USING(emp_no)
WHERE gender = "F"
AND dept_emp.to_date > CURDATE()
AND dept_manager.to_date > CURDATE()
AND employees.emp_no = dept_manager.emp_no
GROUP BY dept_name, full_name, gender;

-- Find the first and last name of the employee with the highest salary.

SELECT CONCAT(employees.first_name, " ", employees.last_name) AS full_name
FROM employees
JOIN salaries
USING(emp_no)
WHERE salaries.to_date > CURDATE()
AND salary = (SELECT MAX(salary)
			 FROM salaries
             WHERE salaries.to_date > CURDATE()
             );

-- Find the department name that the employee with the highest salary works in.
SELECT dept_name
FROM departments
JOIN dept_emp
USING(dept_no)
WHERE emp_no = (SELECT emp_no
	FROM employees
	JOIN salaries
	USING(emp_no)
	WHERE salaries.to_date > CURDATE()
	AND salary = (SELECT MAX(salary)
				FROM salaries
				WHERE salaries.to_date > CURDATE()
				)
			);

