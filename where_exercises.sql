

    -- Create a file named where_exercises.sql. Make sure to use the employees database.
    USE employees;
    DESCRIBE employees;

    -- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. 
    -- Enter a comment with the number of records returned.
    
    SELECT *
    FROM employees
    WHERE first_name IN ("Irena", "Vidya", "Maya");
    -- 709 rows returned

    -- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. 
    -- Enter a comment with the number of records returned. Does it match number of rows from Q2?
    
    SELECT *
    FROM employees
    WHERE first_name = "Irena" OR "Vidya" OR "Maya";
    -- It does not return the same number as Q1. It returned 241 rows instead.

    -- Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. 
    -- Enter a comment with the number of records returned.
    
	SELECT *
    FROM employees
    WHERE gender = "M"
    AND first_name = "Irena" OR "Vidya" OR "Maya";
    -- 144 rows returned

    -- Find all current or previous employees whose last name starts with 'E'. 
    -- Enter a comment with the number of employees whose last name starts with E.
    
    SELECT *
    FROM employees
    WHERE last_name LIKE "E%";
    -- 7330 rows returned

    -- Find all current or previous employees whose last name starts or ends with 'E'. 
    -- Enter a comment with the number of employees whose last name starts or ends with E. 
    -- How many employees have a last name that ends with E, but does not start with E?
    
    SELECT *
    FROM employees
    WHERE last_name LIKE "E%" 
    OR last_name LIKE "%e";
    -- 30723 rows returned
    
    SELECT *
    FROM employees
    WHERE last_name NOT LIKE "E%" 
    AND last_name LIKE "%e";
    -- 23393 rows returned

    -- Find all current or previous employees employees whose last name starts and ends with 'E'. 
    -- Enter a comment with the number of employees whose last name starts and ends with E. 
    -- How many employees' last names end with E, regardless of whether they start with E?
    
	SELECT *
    FROM employees
    WHERE last_name LIKE "E%" 
    AND last_name LIKE "%e";
    -- 899 rows returned
    
	SELECT *
    FROM employees
    WHERE last_name LIKE "%e";
    -- 24292 rows returned

    -- Find all current or previous employees hired in the 90s. 
    -- Enter a comment with the number of employees returned.
    
    SELECT *
    FROM employees
    WHERE hire_date LIKE "199%";
    -- 135214 rows returned

    -- Find all current or previous employees born on Christmas. 
    -- Enter a comment with the number of employees returned.
    SELECT birth_date
    FROM employees;
    
    SELECT *
    FROM employees
    WHERE birth_date LIKE "%-12-25";

    -- Find all current or previous employees hired in the 90s and born on Christmas. 
    -- Enter a comment with the number of employees returned.
    
    SELECT *
    FROM employees
    WHERE hire_date LIKE "199%"
    AND birth_date LIKE "%-12-25";
    -- 362 rows returned

    -- Find all current or previous employees with a 'q' in their last name. 
    -- Enter a comment with the number of records returned.
    
    SELECT *
    FROM employees
    WHERE last_name LIKE "%q%";
    -- 1873 rows returned
    
    -- Find all current or previous employees with a 'q' in their last name but not 'qu'. 
    -- How many employees are found?
    
    SELECT *
    FROM employees
    WHERE last_name LIKE "%q%"
    AND last_name NOT LIKE "%qu%";
    -- 547 rows returned
