

    -- Create a new file named group_by_exercises.sql

    -- While accessing the employees database, use DISTINCT to find the unique titles in the titles table.
	-- How many unique titles have there ever been? Answer that in a comment in your SQL file.
    USE employees;
    DESCRIBE employees;
    DESCRIBE titles;
    
    SELECT DISTINCT title
    FROM titles;
    -- 7 rows returned.

    -- Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
    
    SELECT last_name
    FROM employees
    WHERE last_name LIKE "E%e"
    GROUP BY last_name;

    -- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
    
    SELECT first_name, last_name
    FROM employees
    WHERE last_name LIKE "E%e"
    GROUP BY first_name, last_name;

    -- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
    
    SELECT last_name
    FROM employees
    WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
    GROUP BY last_name;
/*'Chleq'
'Lindqvist'
'Qiwen'*/


    -- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
    
    SELECT last_name, COUNT(last_name)
    FROM employees
    WHERE last_name LIKE "%q%" AND last_name NOT LIKE "%qu%"
    GROUP BY last_name;
    
/*'Chleq','189'
'Lindqvist','190'
'Qiwen','168'*/

    -- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. 
    -- Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
    
    SELECT first_name, gender, COUNT(first_name)
    FROM employees
    WHERE first_name IN ("Irena", "Vidya", "Maya")
    GROUP BY first_name, gender
    ORDER BY first_name, gender;

    -- Using your query that generates a username for all of the employees, generate a count employees for each unique username. 
    
SELECT LOWER(CONCAT(
SUBSTR(first_name, 1, 1), 
SUBSTR(last_name, 1, 4), 
"_",
SUBSTR(birth_date, 6, 2),
SUBSTR(birth_date, 3, 2)
))  AS username,
 
COUNT(*) AS duplicates
FROM employees
GROUP BY username
HAVING duplicates > 1;

    -- Are there any duplicate usernames? YES
    -- BONUS: How many duplicate usernames are there? 13251

    -- Bonus Exercises: More practice with aggregate functions:
    
	-- Determine the historic average salary for each employee. 
    -- When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
    
    SELECT emp_no, ROUND(AVG(salary), 2)
    FROM salaries
    WHERE to_date < CURDATE()
    GROUP BY emp_no;
    
	-- Using the dept_emp table, count how many current employees work in each department. 
    -- The query result should show 9 rows, one for each department and the employee count.
    
    SELECT COUNT(emp_no) AS num_emp, to_date
    FROM dept_emp
    WHERE to_date = "9999-01-01"
    GROUP BY dept_no, to_date;
    
	-- Determine how many different salaries each employee has had. This includes both historic and current.
    
    SELECT emp_no, COUNT(salary) AS num_salary_change
    FROM salaries
    GROUP BY emp_no
    LIMIT 50;
    
	-- Find the maximum salary for each employee.
    
    SELECT emp_no, MAX(salary)
    FROM salaries
    GROUP BY emp_no
    LIMIT 50;
    
	-- Find the minimum salary for each employee.
    
    SELECT emp_no, MIN(salary)
    FROM salaries
    GROUP BY emp_no
    LIMIT 50;
    
	-- Find the standard deviation of salaries for each employee.
    
    SELECT emp_no, ROUND(STDDEV(salary), 2) AS sd_salary
    FROM salaries
    GROUP BY emp_no
    LIMIT 50;
    
	-- Now find the max salary for each employee where that max salary is greater than $150,000.
    
	SELECT emp_no, MAX(salary)
    FROM salaries
    WHERE salary > 150000
    GROUP BY emp_no
    LIMIT 50;
    
	-- Find the average salary for each employee where that average salary is between $80k and $90k.
    
    SELECT emp_no, ROUND(AVG(salary), 2)
    FROM salaries
    WHERE salary BETWEEN 80000 AND 90000
    GROUP BY emp_no
    LIMIT 100;
    
