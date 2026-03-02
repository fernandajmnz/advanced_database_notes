-- Lesson 10

SELECT MAX(Years_employed)
FROM employees

SELECT role, AVG(Years_employed)as average_years
FROM employees
GROUP BY Role;

SELECT Building, 
SUM(Years_employed) as employed_years
FROM Employees
GROUP BY Building;

--Lesson 11

SELECT Count(*)
FROM employees
WHERE Role = 'Artist'

SELECT 
Role, 
Count(*) as total_employees
FROM employees
GROUP BY Role;

SELECT 
   SUM(Years_employed) as total_years
FROM employees
where Role = 'Engineer';

-- Oracle Freesql

create table bricks ( 
    brick_id   integer primary key,
    brick_name varchar2(100) );

create table bricks_iot (
  bricks_id integer primary key
) /*TODO*/;



create table bricks_hash (
  brick_id integer
) partition by by hash (brick_id) partitions 8;

select table_name, partitioned
from   user_tables
where  table_name = 'BRICKS_HASH';

drop table bricks_hash;

select table_name
from   user_tables
where  table_name = 'TOYS';

select table_name
from   user_tables
where  table_name = 'TOYS';

