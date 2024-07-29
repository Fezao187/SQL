-- Listing 1.1
 
CREATE DATABASE analysis;

-- Listing 1.2
-- Creating a table
CREATE TABLE teachers(
    id bigserial,
    first_name varchar(25),
    last_name varchar(50),
    hire_date date,
    salary numeric
);