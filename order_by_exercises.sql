

    -- Create a new file named order_by_exercises.sql and copy in the contents of your exercise from the previous lesson.

    -- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. 
    -- In your comments, answer: What was the first and last name in the first row of the results? 
    -- What was the first and last name of the last person in the table?
    
    USE employees;
    DESCRIBE employees;
    
    SELECT *
    FROM employees
    WHERE first_name IN ("Irena", "Vidya", "Maya")
    ORDER BY first_name;
    
    -- First row was Irena Reutenauer.
    -- Last row was Vidya Simmen.

    -- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. 
    -- In your comments, answer: What was the first and last name in the first row of the results? 
    -- What was the first and last name of the last person in the table?
    
    SELECT *
    FROM employees
    WHERE first_name IN ("Irena", "Vidya", "Maya")
    ORDER BY first_name, last_name;
    
    -- First row is Irena Acton.
    -- Last row is Vidya Zweizig .

    -- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. 
    -- In your comments, answer: What was the first and last name in the first row of the results? 
    -- What was the first and last name of the last person in the table?
    
    SELECT *
    FROM employees
    WHERE first_name IN ("Irena", "Vidya", "Maya")
    ORDER BY last_name, first_name;
    
    -- First row is Irena Acton.
    -- Last row is Maya Zyda.

    -- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. 
    -- Enter a comment with the number of employees returned, the first employee number and their first and last name, 
    -- and the last employee number with their first and last name.
    
    SELECT *
    FROM employees
    WHERE last_name LIKE "E%" AND last_name LIKE "%e"
    ORDER BY emp_no;
    -- 899 rows returned.
    -- First row is emp#10021 Ramzi Erde.
    -- Last row is emp#499648 Tadahiro Erde. 

    -- Write a query to to find all employees whose last name starts and ends with 'E'. 
    -- Sort the results by their hire date, so that the newest employees are listed first. 
    -- Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.
    
    SELECT *
    FROM employees
    WHERE last_name LIKE "E%" AND last_name LIKE "%e"
    ORDER BY hire_date;
    -- 899 rows returned.
    -- Newest employee in query is Teiji Eldridge.
    -- Oldest employee in query is Sergi Erde.


    -- Find all employees hired in the 90s and born on Christmas. 
    -- Sort the results so that the oldest employee who was hired last is the first result. 
    -- Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, 
    -- and the name of the youngest employee who was hired first.
    
    SELECT *
    FROM employees
    WHERE hire_date LIKE "199%" AND birth_date LIKE "%-12-25"
    ORDER BY birth_date DESC, hire_date
    LIMIT 1;
    -- 362 rows returned
    -- Khun Bernini is the oldest employee hired last.
    -- Douadi Pettis is the youngest employee that was hired first.
