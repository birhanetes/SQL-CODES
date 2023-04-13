/* 

Topics: 
Scalar & String Functions such as round, length, ucase, lcase....
Date & Time Functions such as  day, month, date_add, datediff, current_timestamp, interval ....

*/

-- Table name 
select * from petrescue;

-- Scalar and String Functions

-- Q1: Enter a function that displays the rounded cost of each rescue.
select round(cost) as Cost from petrescue;

-- Q2: Enter a function that displays the length of each animal name.
select length(animal) as length from petrescue;

-- Q3: Enter a function that displays the animal name in each rescue in uppercase.
select ucase(animal) as animal_name from petrescue;

-- Q4: Enter a function that displays the animal name in each rescue in uppercase without duplications.
select  distinct (ucase( animal)) as Animal from petrescue;

-- Q5: Enter a query that displays all the columns from the PETRESCUE table, where the animal(s) rescued are cats. Use cat in lower case in the query.
select * from petrescue
where lcase(animal) = 'cat';


-- Date and Time Functions

-- Q6: Enter a function that displays the day of the month when cats have been rescued.
select day(rescuedate) from petrescue
where animal='cat';

-- Q7: Enter a function that displays the number of rescues on the 5th month.
select sum(QUANTITY)  from petrescue
where month( RESCUEDATE) = 05;

-- Q8: Enter a function that displays the number of rescues on the 14th day of the month.
select sum(QUANTITY) from petrescue
where day(RESCUEDATE) = 14;

-- Q9: Animals rescued should see the vet within three days of arrivals. Enter a function that displays the third day from each rescue.
select *, date_add(rescuedate, interval 3 day) as SEE_VET from petrescue;
 
-- Q10: Enter a function that displays the length of time the animals have been rescued; the difference between today's date and the rescue date.
select datediff(current_timestamp, rescuedate) from petrescue;
