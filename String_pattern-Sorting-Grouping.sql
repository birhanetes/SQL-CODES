/*

Topics: String pattern (like, between, and), Sorting (order by (ASC, DESC)), and Grouping

*/

-- STRING PATTERN

-- Q1. Retrieve all employees whose address is in Elgin,IL.

SELECT F_NAME, L_NAME FROM employees
WHERE ADDRESS  LIKE '%Elgin,IL%';

-- Q2. Retrieve all employees who were born during the 1970's.

SELECT F_NAME, L_NAME FROM employees
WHERE B_DATE  LIKE '197%';

-- Q3. Retrieve all employees in department 5 whose salary is between 60000 and 70000.

SELECT * FROM employees
WHERE DEP_ID=5 AND (SALARY BETWEEN 60000 and 70000);


-- SORTING

-- Q4. Retrieve a list of employees ordered by department ID.

SELECT F_NAME, L_NAME, DEP_ID FROM employees
ORDER BY DEP_ID asc;

-- Q5. Retrieve a list of employees ordered in descending order by department ID and within each department ordered alphabetically in descending order by last name

SELECT F_NAME, L_NAME, DEP_ID FROM employees
ORDER BY DEP_ID DESC, L_NAME DESC;

-- Q6. use department name instead of department ID and  order alphabetically in descending order by last name

SELECT D.DEP_NAME , E.F_NAME, E.L_NAME
FROM EMPLOYEES as E, DEPARTMENTS as D
WHERE E.DEP_ID = D.DEPT_ID_DEP
ORDER BY D.DEP_NAME, E.L_NAME DESC;


-- GROUPING

-- Q7. For each department ID retrieve the number of employees in the department.

SELECT E. DEP_ID, D.DEP_NAME, COUNT(E.DEP_ID) FROM employees E, departments D 
WHERE E.DEP_ID = D.DEPT_ID_DEP
GROUP BY DEP_ID;
-- OR
SELECT DEP_ID, COUNT(*)
FROM EMPLOYEES
GROUP BY DEP_ID;  

-- Q8. For each department retrieve the number of employees in the department, and the average employee salary in the department..

SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEE, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
ORDER BY AVG(SALARY);  

-- Q9.  limit the ABOVE result to departments with fewer than 4 employees.

SELECT DEP_ID, COUNT(*) AS NUM_EMPLOYEE, AVG(SALARY) AS AVG_SALARY
FROM EMPLOYEES
GROUP BY DEP_ID
HAVING COUNT(*) < 4
ORDER BY AVG(SALARY);  

