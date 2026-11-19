-- ============================================================================
-- Day 8: GROUP BY, Aggregate Functions (COUNT, SUM, AVG, MIN, MAX) & HAVING
-- Roadmap: 30-Day SQL Learning Roadmap for Java Developers (Week 2)
-- Database: MySQL 8.0+
-- ============================================================================

-- 1. Basic Aggregates across the entire employees table
SELECT COUNT(*) AS total_rows,
       COUNT(dept_id) AS assigned_employees,
       SUM(salary) AS total_payroll,
       AVG(salary) AS average_salary,
       MIN(salary) AS lowest_salary,
       MAX(salary) AS highest_salary
FROM employees;

-- 2. Department-wise summary (LEFT JOIN + COUNT(e.emp_id) safely counts 0)
SELECT d.dept_name,
       COUNT(e.emp_id) AS emp_count,
       COALESCE(AVG(e.salary), 0) AS avg_salary
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 3. Combining WHERE (pre-group row filter) and HAVING (post-group filter)
SELECT d.dept_name,
       COUNT(e.emp_id) AS high_earner_count,
       AVG(e.salary) AS avg_high_salary
FROM departments d
INNER JOIN employees e ON d.dept_id = e.dept_id
WHERE e.salary >= 60000
GROUP BY d.dept_name
HAVING COUNT(e.emp_id) >= 2;