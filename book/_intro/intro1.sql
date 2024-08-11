-- 1. How to download pgAdmin
-- 2. Setting up pgAdmin
-- 3. Query tool, run queries
    -- a. Create table
    CREATE TABLE pgTest(
        testVal varchar(10)
    );
    -- b. Insert data
    INSERT INTO pgTest (testVal)
    VALUES ('Hello')
    -- c. View data
    SELECT * FROM pgTest
-- 4. Save queries