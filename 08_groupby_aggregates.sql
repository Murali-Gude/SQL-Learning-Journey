
-- =====================================================
-- DAY 8: AGGREGATE FUNCTIONS
-- SUBTOPIC 1: AGGREGATE FUNCTIONS BASICS
-- =====================================================

-- Reference table: employees
-- emp_id | emp_name | department | salary
-- 101    | Ravi     | IT         | 45000
-- 102    | Priya    | HR         | 35000
-- 103    | Arun     | IT         | 50000
-- 104    | Sneha    | Finance    | 40000
-- 105    | Kiran    | HR         | 30000
-- 106    | Anil     | IT         | 55000


-- 1. SUM()
-- Calculates the total of numeric values.

SELECT SUM(salary)
FROM employees;

-- Expected output: 255000


-- 2. AVG()
-- Calculates the average of numeric values.

SELECT AVG(salary)
FROM employees;

-- Expected output: 42500


-- 3. MAX()
-- Returns the highest value.

SELECT MAX(salary)
FROM employees;

-- Expected output: 55000


-- 4. MIN()
-- Returns the lowest value.

SELECT MIN(salary)
FROM employees;

-- Expected output: 30000


-- 5. COUNT(*)
-- Counts all rows, including rows containing NULL values.

SELECT COUNT(*)
FROM employees;

-- Expected output: 6


-- 6. COUNT(column_name)
-- Counts only non-NULL values in the specified column.

SELECT COUNT(department)
FROM employees;

-- If one department value is NULL among six rows,
-- Expected output: 5


-- 7. MULTIPLE AGGREGATE FUNCTIONS WITH ALIASES
-- Calculate several summary values in one query.

SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM employees;

-- Expected output:
-- total_employees | total_salary | average_salary
-- 6               | 255000       | 42500
--
-- highest_salary | lowest_salary
-- 55000          | 30000


-- IMPORTANT NOTES
-- COUNT(*) counts all rows.
-- COUNT(column) excludes NULL values.
-- SUM() calculates total.
-- AVG() calculates average.
-- MAX() finds the highest value.
-- MIN() finds the lowest value.
-- Without GROUP BY, aggregate functions summarize
-- the entire selected set into one result row.
