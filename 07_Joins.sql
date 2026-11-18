-- ============================================================================
-- Day 7: SQL Joins (INNER, LEFT, RIGHT, FULL OUTER Emulation, Self JOIN)
-- Roadmap: 30-Day SQL Learning Roadmap for Java Developers (Week 2)
-- Database: MySQL 8.0+
-- ============================================================================

-- 1. INNER JOIN: Only employees assigned to an existing department
SELECT e.emp_name, e.salary, d.dept_name
FROM employees e
INNER JOIN departments d ON e.dept_id = d.dept_id;

-- 2. LEFT JOIN: All employees, including unassigned ones (dept_name = NULL)
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id;

-- 3. LEFT ANTI-JOIN: Only employees NOT assigned to any department
SELECT e.emp_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- 4. RIGHT JOIN & RIGHT ANTI-JOIN: Departments with 0 employees
SELECT d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- 5. FULL OUTER JOIN (MySQL Emulation using LEFT JOIN + UNION + RIGHT JOIN)
SELECT e.emp_name, d.dept_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.dept_id
UNION
SELECT e.emp_name, d.dept_name
FROM employees e
RIGHT JOIN departments d ON e.dept_id = d.dept_id;

-- 6. Self JOIN: Employee and their Manager from the same table
SELECT e.emp_name AS employee, m.emp_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;