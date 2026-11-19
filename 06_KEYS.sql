-- ============================================================================
-- Day 6: Primary Keys, Foreign Keys, Relationships & Constraints
-- Roadmap: 30-Day SQL Learning Roadmap for Java Developers (Week 2)
-- Database: MySQL 8.0+ (InnoDB)
-- ============================================================================

-- 1. ONE-TO-MANY (1:N) RELATIONSHIP: departments (Parent) -> employees (Child)
-- Parent table MUST be created before the child table.
CREATE TABLE departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    salary INT NOT NULL,
    dept_id INT, -- Nullable to support ON DELETE SET NULL
    CONSTRAINT fk_emp_dept
        FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

-- 2. ONE-TO-MANY (1:N) WITH ON DELETE CASCADE: customers -> orders
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    order_amount DECIMAL(10, 2) NOT NULL,
    customer_id INT,
    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- 3. ONE-TO-ONE (1:1) RELATIONSHIP: employees -> employee_passports
-- Adding UNIQUE to the Foreign Key column enforces a strict 1:1 relationship.
CREATE TABLE employee_passports (
    passport_id INT PRIMARY KEY AUTO_INCREMENT,
    passport_number VARCHAR(20) NOT NULL UNIQUE,
    emp_id INT NOT NULL UNIQUE,
    CONSTRAINT fk_passport_emp
        FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
        ON DELETE CASCADE
);

-- 4. MANY-TO-MANY (M:N) RELATIONSHIP: students <-> courses via enrollments
-- Modeled using a 3rd junction table with a Composite Primary Key.
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    enrolled_on DATE NOT NULL,
    PRIMARY KEY (student_id, course_id)
);

-- ============================================================================
-- FREQUENTLY ASKED INTERVIEW QUESTIONS (DAY 6 SUMMARY):
-- 1. PRIMARY KEY vs. UNIQUE:
--    - PRIMARY KEY: Only 1 per table, NEVER allows NULL, creates Clustered Index.
--    - UNIQUE: Multiple allowed per table, ALLOWS NULL (multiple NULLs in InnoDB),
--      creates Secondary Index.
-- 2. Foreign Key & NULL vs. Invalid ID:
--    - Inserting NULL into a nullable Foreign Key is ALLOWED (unassigned row).
--    - Inserting a non-existent ID (e.g., 999) FAILS with Error 1452.
-- 3. Referential Integrity Actions:
--    - RESTRICT (Default): Blocks parent delete/update if child rows exist.
--    - CASCADE: Automatically deletes/updates matching child rows.
--    - SET NULL: Sets child FK column to NULL on parent delete.
-- 4. Designing 1:1 vs. M:N:
--    - 1:1 -> FOREIGN KEY + UNIQUE constraint on the child FK column.
--    - M:N -> Junction table with 2 Foreign Keys + Composite PRIMARY KEY.
-- ===========================================================================