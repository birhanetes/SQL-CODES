/* 
Topics: Inner join, Left outer join & Right outer join.

Plus

My sql doesn't have Full outer join, however, the same result can be
attained by utilazing this synthax: (a LEFT JOIN b) union (a RIGHT JOIN b)
*/
-- Q1. Select the names and job start dates of all employees who work for the department number 5

select e.F_NAME, e.L_NAME, j.START_DATE from employees e
inner join job_history j
on e.EMP_ID = j.EMPL_ID
where DEPT_ID=5;

-- Q2. Select the names, job start dates, and job titles of all employees who work for the department number 5.

select e.F_NAME, e.L_NAME, jh.START_DATE, j.JOB_TITLE from employees e
inner join job_history jh
on e.EMP_ID = jh.EMPL_ID
inner join jobs j
on jh.JOBS_ID = j. JOB_IDENT
where DEPT_ID=5;

-- Q3. Perform a Left Outer Join on the EMPLOYEES and DEPARTMENT tables and select employee id, last name, department id and department name for all employees

select e.EMP_ID, e.L_NAME, e.DEP_ID,  d.DEP_NAME
from employees e
left join departments d 
on e.DEP_ID = d.DEPT_ID_DEP;

-- Q4. limit the result set to include only the rows for employees born before 1980.

select e.EMP_ID, e.L_NAME, e.DEP_ID,  d.DEP_NAME
from employees e
left join departments d 
on e.DEP_ID = d.DEPT_ID_DEP
where year(e.B_DATE) < 1980;

-- Q5. Have the result set include all the employees but department names for only the employees who were born before 1980

select e.EMP_ID, e.L_NAME, e.DEP_ID,  d.DEP_NAME
from employees e
left join departments d 
on e.DEP_ID = d.DEPT_ID_DEP and year(e.B_DATE) < 1980;

-- Q6.  Perform a Full Join on the EMPLOYEES and DEPARTMENT tables and select the First name, Last name and Department name of all employees.

select e.F_NAME, e.L_NAME,  d.DEP_NAME
from employees e
left outer join departments d on e.DEP_ID = d.DEPT_ID_DEP
union
select e.F_NAME, e.L_NAME,  d.DEP_NAME
from employees e
right outer join departments d on e.DEP_ID = d.DEPT_ID_DEP;

-- Q7. Have the result set include all employee names but department id and department names only for male employees.

select e.F_NAME, e.L_NAME, e.DEP_ID, d.DEP_NAME
from employees e
left outer join departments d 
on e.DEP_ID = d.DEPT_ID_DEP and e.sex='M'
union
select e.F_NAME, e.L_NAME,  e.DEP_ID, d.DEP_NAME
from employees e
right outer join departments d on e.DEP_ID = d.DEPT_ID_DEP and e.sex='M';
