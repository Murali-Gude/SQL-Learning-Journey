-- ============================================================================
-- Day 5 (Part 1): INSERT INTO — Complete Concepts, Patterns & Interview Notes
-- Database: MySQL 8.0+ | Reference Table: employees(emp_id, emp_name, department, salary)
-- ============================================================================

-- 1. SINGLE-ROW INSERT (Explicit Column List - Recommended Best Practice)
INSERT INTO employees (emp_id, emp_name, department, salary)
VALUES (107, 'Meera', 'Marketing', 42000);

-- 2. MULTI-ROW / BULK INSERT (Reduces Java/JDBC network round-trips)
-- Note: Atomic in standard INSERT — if ANY row fails, the entire statement rolls back.
INSERT INTO employees (emp_id, emp_name, department, salary)
VALUES
    (108, 'Vikram', 'Finance', 48000),
    (109, 'Divya', NULL, 32000);

-- 3. PARTIAL-COLUMN INSERT
-- Omitted columns automatically receive NULL (or their defined DEFAULT value).
INSERT INTO employees (emp_id, emp_name)
VALUES (110, 'Suresh');

-- 4. SHORTHAND INSERT (Without Column Names)
-- Requires values for ALL columns in exact table-creation order. Avoid in production.
INSERT INTO employees
VALUES (111, 'Kavya', 'IT', 47000);

-- 5. HANDLING DUPLICATE PRIMARY KEYS
-- Option A: Skip duplicate rows with a warning instead of throwing Error 1062
INSERT IGNORE INTO employees (emp_id, emp_name, department, salary)
VALUES (101, 'Ravi', 'IT', 47000);

-- Option B: Upsert (Update existing row in place without deleting or losing columns)
INSERT INTO employees (emp_id, emp_name, department, salary)
VALUES
    (111, 'Nisha', 'HR', 39000),
    (101, 'Ravi', 'IT', 52000),
    (112, 'Tarun', 'Finance', 46000)
ON DUPLICATE KEY UPDATE salary = VALUES(salary);

-- 6. COPYING ROWS FROM ANOTHER TABLE (INSERT INTO ... SELECT)
INSERT INTO it_employees_backup (emp_id, emp_name, department, salary)
SELECT emp_id, emp_name, department, salary
FROM employees
WHERE department = 'IT';

-- ============================================================================
-- KEY INTERVIEW TAKEAWAYS (INSERT):
-- 1. Atomicity: A multi-row INSERT rolls back completely if one row hits Error 1062.
-- 2. REPLACE INTO vs ON DUPLICATE KEY UPDATE:
--    - REPLACE INTO runs DELETE + INSERT (wipes omitted columns to NULL & breaks FKs).
--    - ON DUPLICATE KEY UPDATE modifies the row in place (preserves columns & FKs).
-- 3. AUTO_INCREMENT Gaps: Failed INSERTs in InnoDB still increment the ID counter.
-- 4. Performance: Multi-row INSERT / JDBC executeBatch() avoids N+1 network trips.
-- ============================================================================
-- ============================================================================
-- Day 5 (Part 2): UPDATE — Complete Concepts, Patterns & Interview Notes
-- Database: MySQL 8.0+ | Reference Table: employees(emp_id, emp_name, department, salary)
-- ============================================================================

-- 1. SINGLE-ROW & MULTI-COLUMN UPDATE
UPDATE employees
SET department = 'Marketing', salary = 36000
WHERE emp_id = 109;

-- 2. EXPRESSION-BASED UPDATE (Relative Calculations)
-- Add a flat 5000 bonus to everyone in Finance
UPDATE employees
SET salary = salary + 5000
WHERE department = 'Finance';

-- 3. FILTERING NULL VALUES IN UPDATE
-- Always use IS NULL (never = NULL)
UPDATE employees
SET salary = 30000, department = 'Support'
WHERE salary IS NULL;

-- 4. CONDITIONAL UPDATE USING CASE WHEN
-- Apply tiered raises in a single atomic query
UPDATE employees
SET salary = CASE
    WHEN salary < 37000 THEN salary + 4000
    ELSE salary + 2000
END
WHERE department = 'HR';

-- 5. SAFE UPDATE MODE & PRODUCTION TRANSACTION WORKFLOW
-- Step A: Preview exact target rows before modifying anything
SELECT * FROM employees WHERE department = 'IT';

-- Step B: Temporarily disable Safe Update Mode if filtering on a non-KEY column
SET SQL_SAFE_UPDATES = 0;

-- Step C: Wrap risky updates in an explicit transaction
START TRANSACTION;

UPDATE employees
SET salary = 52000
WHERE department = 'IT';

-- Verify changes before making them permanent
SELECT * FROM employees WHERE department = 'IT';

COMMIT;    -- Make permanent if verified
-- ROLLBACK; -- Undo immediately if anything looks wrong

-- Step D: Always re-enable Safe Update Mode
SET SQL_SAFE_UPDATES = 1;

-- ============================================================================
-- KEY INTERVIEW TAKEAWAYS (UPDATE):
-- 1. Rows matched vs Changed:
--    - "Rows matched" = rows satisfying the WHERE condition.
--    - "Changed" = rows whose column value actually changed on disk.
-- 2. Safe Update Mode (Error 1175):
--    - Blocks UPDATE/DELETE unless WHERE uses an indexed KEY column or LIMIT.
-- 3. Production Safety:
--    - Always run SELECT with the same WHERE clause first, and wrap bulk
--      updates inside START TRANSACTION ... COMMIT / ROLLBACK.
-- ============================================================================
-- ============================================================================
-- Day 6: DELETE vs. TRUNCATE vs. DROP — Complete Concepts & Interview Notes
-- Database: MySQL 8.0+ | Reference Table: employees(emp_id, emp_name, department, salary)
-- ============================================================================

-- 1. DELETE (DML — Row-by-Row Removal)
-- Remove a single employee by Primary Key
DELETE FROM employees
WHERE emp_id = 110;

-- Remove multiple rows matching a condition
DELETE FROM employees
WHERE department = 'Marketing' AND salary < 40000;

-- Transactional DELETE (can be rolled back before COMMIT)
START TRANSACTION;
DELETE FROM employees WHERE department = 'Support';
ROLLBACK; -- Restores the deleted rows immediately

-- 2. TRUNCATE TABLE (DDL — Fast Full-Table Wipe)
-- Removes all rows, preserves table structure, resets AUTO_INCREMENT to 1
-- Cannot use WHERE, cannot ROLLBACK, does NOT fire DELETE triggers
TRUNCATE TABLE temp_imports;

-- 3. DROP TABLE (DDL — Destroys Data + Table Structure)
-- Removes rows, columns, indexes, triggers, and constraints permanently
DROP TABLE IF EXISTS temp_imports;

-- 4. PRODUCTION BEST PRACTICE: SOFT DELETE (Using UPDATE Instead of DELETE)
-- Preserves audit history, foreign keys, and allows instant recovery
-- ALTER TABLE employees ADD COLUMN is_deleted TINYINT DEFAULT 0, ADD COLUMN deleted_at DATETIME NULL;

UPDATE employees
SET is_deleted = 1, deleted_at = NOW()
WHERE emp_id = 101;

-- Active application queries simply filter out soft-deleted rows:
SELECT * FROM employees WHERE is_deleted = 0;

-- ============================================================================
-- KEY INTERVIEW TAKEAWAYS (DELETE vs. TRUNCATE vs. DROP):
-- 1. DML vs. DDL & Rollback:
--    - DELETE is DML (logged in InnoDB undo log -> supports ROLLBACK).
--    - TRUNCATE and DROP are DDL (implicit commit -> CANNOT be rolled back).
-- 2. AUTO_INCREMENT & Triggers:
--    - DELETE keeps the current AUTO_INCREMENT counter and fires DELETE triggers.
--    - TRUNCATE resets AUTO_INCREMENT to 1 and skips triggers completely.
-- 3. Foreign Key Constraint (Error 1701):
--    - MySQL blocks TRUNCATE on any parent table referenced by a FOREIGN KEY,
--      even if the child table has 0 rows; DELETE succeeds if 0 child rows match.
-- 4. Soft Delete vs. Hard Delete:
--    - Production systems prefer UPDATE (is_deleted / deleted_at) over DELETE
--      to preserve historical records and recover accidental deletions easily.
-- ============================================================================