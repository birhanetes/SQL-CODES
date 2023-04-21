/*
Topic(s): Self Join
*/

-- Count all employees under each manager
select 
sup.EMP_ID, 
sup.f_name, 
sup.l_name,
count(sub.emp_id) as number_of_employees
from employees sub
join employees sup
on sub.MANAGER_ID = sup.MANAGER_ID
group by sup.EMP_ID, sup.f_name, sup.l_name;


-- Find all direct subordinates under each manager
select 
sub.EMP_ID as subordinate_id, 
sub.f_name as subordinate_f_name , 
sub.l_name subordinate_l_name,
sup.EMP_ID as superior_id, 
sup.f_name as superior_f_name, 
sup.l_name as superior_l_name
from employees sub
join employees sup
on sub.MANAGER_ID = sup.MANAGER_ID
order by  sup.EMP_ID;

