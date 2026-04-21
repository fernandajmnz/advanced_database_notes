-- ============================================================
-- Exercise 1 — Find the slow query
-- Run this query. Look at the execution plan.
-- Is Oracle using an index? Should it? 
-- No, Oracle is not using an index. In this case, that’s actually the right decision because the condition is not very selective

-- Questions:
-- a) What scan type do you see? Why?
-- I see a TABLE ACCESS FULL
-- this happens because Oracle chooses to scan the whole table instead of using an index, 
-- since a large number of rows match site_id = 3. I think using an index wouldn’t be efficient here.


-- b) site_id has values 1–5. Is this high or low cardinality?
-- it is low cardinality because there are only a few possible values

-- c) Would adding an index on site_id help? Why or why not?
-- since there are only a few distinct values, each one corresponds to many rows, 
-- that means the index wouldn’t filter enough data to make it faster than a full table scan 
-- ============================================================


-- ============================================================
-- Exercise 2 — Create an index and see if it helps
-- 
-- Create an index on visit_date.
-- Then run the range query below and check the plan.
-- ============================================================

-- Step 1: Create it
-- (write the CREATE INDEX statement here)
CREATE INDEX idx_pv_visit_date ON patient_visits(visit_date);

-- Questions:
-- a) Does Oracle use the index for this range?
-- no, the plan does not change,
-- Oracle still performs a TABLE ACCESS FULL, meaning it continues to scan the entire table instead of using the index

-- b) Change the range to the last 7 days. Does the plan change?
-- No, the plan does not change.
-- Oracle still uses a full table scan instead of the index.

-- c) Change to the last 700 days. What happens?
-- It also results in a TABLE ACCESS FULL, since the query returns most of the table and using the index would not be efficient.

-- d) Why does the range size affect whether Oracle uses the index?
-- Because the usefulness of an index depends on how many rows are returned.
-- if only a small number of rows match, the index helps.
-- but if many rows match, it is faster to scan the whole table.

-- ============================================================
-- Exercise 3 — Composite index
--
-- You often query by both patient_id AND visit_date together:
--   WHERE patient_id = 1234 AND visit_date > SYSDATE - 90
--
-- Two options:
--   Option A: Two separate indexes (one per column)
--   Option B: One composite index (patient_id, visit_date)
--
-- Create the composite index and test the query.
-- ============================================================


-- Questions:
-- a) Does the plan use the composite index?
--No, the plan does not use the composite index.
--Oracle is still doing a TABLE ACCESS FULL instead of using the index

-- b) Now try querying ONLY on visit_date (no patient_id).
-- No, the composite index would usually not be used when querying only by visit_date.
-- That is because visit_date is the second column in the index, and Oracle generally cannot use a 
-- composite index efficiently if the first column (patient_id) is missing from the condition.
-- c) What's the rule about column order in composite indexes?
--The order of the columns matters.
-- Oracle uses a composite index most effectively starting from the leading column. If the index is (patient_id, visit_date), it works best for queries that filter by patient_id,
 -- or by both patient_id and visit_date. It is usually not helpful for queries that only filter by visit_date.


-- ============================================================
-- Exercise 4 — Function that breaks an index
--
-- There IS an index on patient_id (from lesson 03).
-- Predict what happens when you wrap the column in a function.
-- ============================================================

-- Questions:
-- a) What scan type did the second query use?
-- The second query used a TABLE ACCESS FULL.
-- Once patient_id was wrapped inside TO_CHAR(), we could no longer use the normal index on that column.

-- b) Why does wrapping a column in a function break index use?
-- Because the index is built on the original value of patient_id, not on the result of TO_CHAR(patient_id).
-- In the db sees a function applied to the column, it cannot use the regular index directly, so it falls back to scanning the table.

-- c) How would you rewrite the second query to allow index use?
SELECT * FROM patient_visits
WHERE patient_id = 5432;






-- ============================================================
-- Exercise 5 — Discussion: real-world scenarios
--
-- For each scenario below, decide:
--   a) Would you add an index?
--   b) On which column(s)?
--   c) Any concerns?
-- ============================================================

-- Scenario A:
-- A reporting table gets loaded once per night (batch ETL).
-- During the day, analysts run SELECT queries by date range.
-- The table has 50 million rows.
-- → Index on date? Yes/No, why?
-- Yes, I would add an index on the date column.
-- Since queries are by date range and the table is large, it can help performance.
-- Concern: for very large ranges, Oracle might still do a full scan.

-- Scenario B:
-- An OLTP orders table gets 10,000 inserts per minute.
-- Support staff look up orders by customer_id or order_status.
-- order_status has 4 values: pending, processing, shipped, cancelled.
-- → What indexes would you add?
-- I would add an index on customer_id.
-- I would avoid indexing order_status alone because it has very few values.
-- Concern: high insert rate, so too many indexes will slow down writes.


-- Scenario C:
-- A patient table has an email column (unique per patient).
-- There are 5 million patients.
-- The app frequently does: WHERE email = 'user@example.com'
-- → What kind of index would be best here?
-- I would create a unique index on email.
-- It’s perfect because email is unique and used in equality searches.

-- ============================================================
-- Cleanup — remove indexes created in these exercises
-- ============================================================

DROP INDEX idx_pv_patient_date;
DROP INDEX idx_pv_visit_date;