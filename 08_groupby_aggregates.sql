
-- =====================================================
-- DAY 8: AGGREGATE FUNCTIONS AND GROUP BY
-- =====================================================

-- Reference Table: employees
--
-- emp_id | emp_name | department | salary
-- 101    | Ravi     | IT         | 45000
-- 102    | Priya    | HR         | 35000
-- 103    | Arun     | IT         | 50000
-- 104    | Sneha    | Finance    | 40000
-- 105    | Kiran    | HR         | 30000
-- 106    | Anil     | IT         | 55000


-- =====================================================
-- SUBTOPIC 1: AGGREGATE FUNCTIONS
-- =====================================================

-- 1. SUM() - Calculates total salary
SELECT SUM(salary) AS total_salary
FROM employees;
-- Expected Output: 255000


-- 2. AVG() - Calculates average salary
SELECT AVG(salary) AS average_salary
FROM employees;
-- Expected Output: 42500


-- 3. MAX() - Finds highest salary
SELECT MAX(salary) AS highest_salary
FROM employees;
-- Expected Output: 55000


-- 4. MIN() - Finds lowest salary
SELECT MIN(salary) AS lowest_salary
FROM employees;
-- Expected Output: 30000


-- 5. COUNT(*) - Counts all rows
SELECT COUNT(*) AS total_employees
FROM employees;
-- Expected Output: 6


-- 6. COUNT(department) - Counts non-NULL department values
SELECT COUNT(department) AS department_count
FROM employees;
-- Expected Output: 6 for the reference table above.
-- If one department value is NULL, output will be 5.


-- 7. Multiple aggregate functions in one query
SELECT
    COUNT(*) AS total_employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM employees;

-- Expected Output:
-- total_employees: 6
-- total_salary:    255000
-- average_salary:  42500
-- highest_salary:  55000
-- lowest_salary:   30000


-- =====================================================
-- SUBTOPIC 2: GROUP BY
-- =====================================================

-- 1. Count employees in each department
SELECT
    department,
    COUNT(emp_id) AS employees
FROM employees
GROUP BY department;

-- Expected Output:
-- IT       3
-- HR       2
-- Finance  1


-- 2. Average salary in each department
SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

-- Expected Output:
-- IT       50000
-- HR       32500
-- Finance  40000


-- 3. Highest salary in each department
SELECT
    department,
    MAX(salary) AS highest_salary
FROM employees
GROUP BY department;

-- Expected Output:
-- IT       55000
-- HR       35000
-- Finance  40000


-- 4. Lowest salary in each department
SELECT
    department,
    MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;

-- Expected Output:
-- IT       45000
-- HR       30000
-- Finance  40000


-- 5. Count employees and calculate total salary
--    in each department
SELECT
    department,
    COUNT(*) AS no_of_employees,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department;

-- Expected Output:
-- IT       3       150000
-- HR       2        65000
-- Finance  1        40000


-- 6. Multiple aggregate functions with GROUP BY
SELECT
    department,
    COUNT(*) AS employees,
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary
FROM employees
GROUP BY department;


-- =====================================================
-- IMPORTANT CONCEPTS
-- =====================================================

-- Without GROUP BY:
-- Aggregate functions calculate across all rows
-- and return one result row.

SELECT COUNT(*) AS total_employees
FROM employees;
-- Output: 6


-- With GROUP BY:
-- Aggregate functions calculate separately
-- for each group.

SELECT department, COUNT(*) AS employees
FROM employees
GROUP BY department;


-- Interview concept:
-- With ONLY_FULL_GROUP_BY enabled, selecting a
-- non-aggregated column alongside an aggregate
-- requires that column to be grouped or otherwise
-- functionally dependent on the GROUP BY columns.

-- =====================================================
-- END OF DAY 8 - COMPLETED SUBTOPICS 1 AND 2
-- =====================================================
-- =====================================================
-- SUBTOPIC 3: GROUP BY MULTIPLE COLUMNS
-- =====================================================

-- 1. Total salary for each department-and-salary combination
SELECT
    department,
    salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department, salary;

-- Expected output:
-- IT       45000   45000
-- IT       50000   50000
-- IT       55000   55000
-- HR       30000   30000
-- HR       35000   35000
-- Finance  40000   40000


-- 2. Count employees for each department-and-salary combination
SELECT
    department,
    salary,
    COUNT(*) AS employees
FROM employees
GROUP BY department, salary;

-- Expected output:
-- IT       45000   1
-- IT       50000   1
-- IT       55000   1
-- HR       30000   1
-- HR       35000   1
-- Finance  40000   1

-- Key concept:
-- GROUP BY department, salary creates one group
-- for each distinct combination of both values.
-- Rows matching both values belong to the same group.


-- =====================================================
-- SUBTOPIC 4: HAVING
-- =====================================================

-- 1. Departments with average salary greater than 35000
SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 35000;

-- Expected Output:
-- IT       50000
-- Finance  40000


-- 2. Departments with more than 1 employee
SELECT
    department,
    COUNT(*) AS employees
FROM employees
GROUP BY department
HAVING COUNT(*) > 1;

-- Expected Output:
-- IT  3
-- HR  2


-- 3. Departments with total salary greater than 50000
SELECT
    department,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING SUM(salary) > 50000;

-- Expected Output:
-- IT  150000
-- HR   65000


-- 4. WHERE and HAVING together
SELECT
    department,
    AVG(salary) AS avg_salary
FROM employees
WHERE salary > 30000
GROUP BY department
HAVING AVG(salary) > 40000;

-- WHERE filters individual rows before grouping.
-- HAVING filters groups after aggregation.


-- =====================================================
-- IMPORTANT: WHERE vs HAVING
-- =====================================================

-- WHERE: filters individual rows.
-- GROUP BY: creates groups.
-- HAVING: filters grouped results.

-- Logical execution order:
-- FROM -> WHERE -> GROUP BY -> HAVING
-- -> SELECT -> ORDER BY -> LIMIT

-- ====================================================
-- END OF SUBTOPIC 4: HAVING
-- ====================================================
