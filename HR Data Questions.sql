
-- QUESTIONS

-- 1. what is the gender breakdown of employees in the company?
Select * from hr;
Select gender,count(*) AS count
from hr
Where age>=18 AND termdate = '0000-00-00'
Group by gender;

-- 2. what is the race/ethnicity breakdown of employees in the company?
select * from hr; 
select race,count(*) AS count
from hr
Where age>=18 AND termdate = '0000-00-00'
Group by race
Order by count(*) DESC;

-- 3. what is the age distribution of employees in the company?
select * from hr;
Select 
min(age) as youngest,
max(age) as oldest
from hr
Where age>=18 AND termdate = '0000-00-00';

Select 
 CASE
  when age>=18 AND age<=24 THEN '18-24'
  when age>=25 AND age<=34 THEN '25-34'
  when age>=35 AND age<=44 THEN '35-44'
  when age>=45 AND age<=54 THEN '45-54'
  when age>=55 AND age<=64 THEN '55-64'
  ELSE'65+'
 END AS age_group,
 count(*) AS Count
FROM hr
Where age>=18 AND termdate = '0000-00-00'
GROUP BY age_group
ORDER BY age_group;


Select 
 CASE
  when age>=18 AND age<=24 THEN '18-24'
  when age>=25 AND age<=34 THEN '25-34'
  when age>=35 AND age<=44 THEN '35-44'
  when age>=45 AND age<=54 THEN '45-54'
  when age>=55 AND age<=64 THEN '55-64'
  ELSE'65+'
 END AS age_group,gender,
 count(*) AS Count
FROM hr
Where age>=18 AND termdate = '0000-00-00'
GROUP BY age_group,gender
ORDER BY age_group,gender;

-- 4. How many employees work at headquarters versus remote locations?
select * from hr;
select location,count(*) as count
from hr
Where age>=18 AND termdate = '0000-00-00'
Group by location;

-- 5. What is the average length of employment for employees who have been terminated?
select * from hr;

select 
round(AVG(datediff(termdate,hire_date))/365,0) AS avg_length_employment
from hr
where termdate <= curdate() AND termdate <> '0000-00-00' AND age>=18;

-- 6. How does gender distribution vary across departments and job titles?
Select department,gender,count(*) as count
from hr
Where age>=18 AND termdate = '0000-00-00'
group by department,gender
order by department;

-- 7. What is the distribution of job titles across the company?
Select jobtitle,count(*) as count
from hr
where age>=18 and termdate = '0000-00-00'
group by jobtitle
order by jobtitle DESC;

-- 8. Which department has highest turnover rate?
Select department,
total_count,
terminated_count,
terminated_count/total_count as termination_rate
From(Select department,
count(*) as total_count,
SUM(CASE WHEN termdate<>'0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminated_count
From hr
where age>=18
group by department) as subquery
order by termination_rate DESC;

-- 9. What is the distribution of employees across location by city and state?
Select location_state,count(*) as count
from hr
where age>=18 AND termdate = '0000-00-00'
group by location_state
order by count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
 Select 
 year,
 hires,
 terminations,
 hires - terminations AS net_change,
 round((hires-terminations)/hires*100,2)AS net_change_percent
 from(
 select year(hire_date) as year,
        count(*) as hires,
        SUM(CASE WHEN termdate<>'0000-00-00' AND termdate <= curdate() THEN 1 ELSE 0 END) AS terminations
        from hr
        where age>=18
        group by year(hire_date)) as subquery
	order by year  ASC;
    
-- 11. What is the tenure distribution for each department?
Select department, round(avg(datediff(termdate,hire_date)/365),0) as avg_tenure
from hr
where termdate<= curdate() AND termdate<>'0000-00-00' and age>=18
group by department;
