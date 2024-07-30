-- Listing 3.1
-- Character data types
CREATE TABLE char_data_types (
    varchar_column varchar(10),
    char_column char(10),
    text_column text 
);

-- Listing 3.2
-- NUmber data types
CREATE TABLE number_data_types (
    numeric_column numeric(20,5),
    real_column real,
    double_column double precision 
);

 SELECT * FROM number_data_types;

--  Listing 3.3
-- Rounding issues with float
SELECT numeric_column * 10000000 AS "Fixed",
real_column  * 10000000 AS "Float"
FROM number_data_types
WHERE numeric_column = .7;

-- Listing 3.4
-- Timestamp and interbal types
 CREATE TABLE date_time_types (
    timestamp_column timestamp with time zone,
    interval_column interval
 );

INSERT INTO date_time_types 
VALUES 
    ('2018-12-31 01:00 EST','2 days'),
    ('2018-12-31 01:00 -8','1 month'),
    ('2018-12-31 01:00 Australia/Melbourne','1 century'),
    (now(),'1 week');

SELECT * FROM date_time_types;

-- LIsting 3.5
-- Using the interval data type
SELECT 
    timestamp_column, 
    interval_column, 
    timestamp_column - interval_column AS new_date
    FROM date_time_types;

-- Listing 3.6
-- Three CAST() examples
SELECT timestamp_column, CAST(timestamp_column AS varchar(10))
FROM date_time_types;

SELECT numeric_column, 
       CAST(numeric_column AS integer), 
       CAST(numeric_column AS varchar(6)) 
FROM number_data_types; 

 SELECT CAST(char_column AS integer) FROM char_data_types;

-- CAST shortcut notation
SELECT timestamp_column, CAST(timestamp_column AS varchar(10))
FROM date_time_types;

SELECT timestamp_column::varchar(10) 
FROM date_time_types;