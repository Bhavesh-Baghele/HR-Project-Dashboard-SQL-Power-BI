CREATE DATABASE projects;

Use projects;

Select * from hr;

ALTER TABLE hr
Change column ﻿id emp_id VARCHAR(20) NULL;

Describe hr;
Select birthdate from hr;

SET SQL_SAFE_UPDATES = 0;

UPDATE hr
SET birthdate = CASE
 WHEN birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
 WHEN birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
 ELSE null
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

UPDATE hr
SET hire_date = CASE
 WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
 WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
 ELSE null
END;

SELECT hire_date FROM hr;

UPDATE hr
SET termdate = IF(termdate IS NOT NULL AND termdate != '', date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC')), '0000-00-00')
WHERE true;

SELECT termdate from hr;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;


SELECT termdate from hr;

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

DESCRIBE hr;

Select * from hr;

ALTER TABLE hr
ADD COLUMN age INT;

SELECT * from hr;

UPDATE HR
SET age = timestampdiff(YEAR,birthdate,CURDATE());

SELECT birthdate,age from hr;

SELECT 
 MIN(age) AS youngest,
 MAX(age) AS oldest
FROM hr;

SELECT COUNT(*) from hr where age<18;

select * from hr;