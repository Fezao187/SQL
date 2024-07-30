-- Listing 2.1
-- Select all data from the table
SELECT * FROM teachers;

-- Listing 2.2
-- Select a subset of columns
SELECT last_name, first_name, salary FROM teachers;

-- Listing 2.3
-- Use distinct to find unique values
SELECT DISTINCT school 
FROM teachers;

-- Listing 2.4
-- Querying distinct pairs of values in the school and salary columns
SELECT DISTINCT school, salary 
FROM teachers;

-- LIsting 2.5
-- Sorting data by order by
SELECT first_name, last_name, salary 
FROM teachers
ORDER BY salary DESC;

--  Listing 2.6
-- Sorting multiple columns
SELECT last_name, school, hire_date 
FROM teachers
ORDER BY school ASC, hire_date DESC;

-- Listing 2.7
-- Filter rows with where
SELECT last_name, school, hire_date
FROM teachers
WHERE school = 'Myers Middle School';

--  The following examples show comparison operators in action. First, we 
-- use the equals operator to find teachers whose first name is Janet:
 SELECT first_name, last_name, school
 FROM teachers
 WHERE first_name = 'Janet';

-- Next, we list all school names in the table but exclude F.D. Roosevelt HS 
-- using the not equal operator:
SELECT school
FROM teachers
WHERE school != 'F.D. Roosevelt HS';

--  Here we use the less than operator to list teachers hired before 
-- January 1, 2000 (using the date format YYYY-MM-DD):
SELECT first_name, last_name, hire_date
FROM teachers
WHERE hire_date < '2000-01-01';
 
-- Then we find teachers who earn $43,500 or more using the >= operator:
SELECT first_name, last_name, salary
FROM teachers
WHERE salary >= 43500;

--  The next query uses the BETWEEN operator to find teachers who earn 
-- between $40,000 and $65,000. Note that BETWEEN is inclusive, meaning the 
-- result will include values matching the start and end ranges specified.
SELECT first_name, last_name, school, salary
FROM teachers
WHERE salary BETWEEN 40000 AND 65000;

-- Listing 2.8
-- Filtering with like and Ilike
SELECT first_name
FROM teachers
WHERE first_name LIKE 'sam%';

SELECT first_name
FROM teachers
WHERE first_name ILIKE 'sam%';

-- Listing 2.9
-- Combining operators using AND and OR
SELECT *
FROM teachers
WHERE school = 'Myers Middle School'
AND salary < 40000;

SELECT *
FROM teachers
WHERE last_name = 'Cole'
OR last_name = 'Bush';

SELECT *
FROM teachers
WHERE school = 'F.D. Roosevelt HS'
AND (salary < 38000 OR salary > 40000);

-- Listing 2.10
SELECT first_name, last_name, school, hire_date, salary
FROM teachers
WHERE school LIKE '%Roos%'
ORDER BY hire_date DESC;