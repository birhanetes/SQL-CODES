/*

Topic: Sub queries (in the Select, From, and Where Statement)

*/

-- sub query in the where clause

select * 
from EMPLOYEES 
where salary < (select  AVG(salary) from employees);

select EMP_ID, F_NAME, L_NAME, SALARY 
from EMPLOYEES
where SALARY < (select AVG(SALARY) 
                from EMPLOYEES);

-- Sub query in line with column (in select statement)    

select EMP_ID, SALARY, ( select MAX(SALARY) from EMPLOYEES ) AS MAX_SALARY 
from EMPLOYEES;

-- Sub query in the from clause and Table Expression for the EMPLOYEES table

select * from ( select EMP_ID, F_NAME, L_NAME, DEP_ID from EMPLOYEES) AS EMP4ALL;

