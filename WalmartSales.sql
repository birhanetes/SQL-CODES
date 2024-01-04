-- Walmart Sales Data Analysis
-- Dataset: https://github.com/Princekrampah/WalmartSalesAnalysis


-- Adding a new column to table
Alter table dbo.WalmartSalesData$ 
Add  Time_of_Day varchar(20);

-- Update the table with a new column values
update dbo.WalmartSalesData$
set Time_of_Day = (case	
			when CONVERT(VARCHAR, Time, 24) between '00:00:00' and '12:00:00' then 'Morning'
			when CONVERT(VARCHAR, Time, 24) between '12:01:00' and '16:00:00' then 'Afternoon'
			else 'Evening'
		end);
--------------------------------------------------
--------------------Generic-----------------------
--1. How many unique cities does the data have?
select distinct City  from dbo.WalmartSalesData$;

--2. How may branches in each city?
select  Branch, 
		City, 
		count(city) as Count 
from dbo.WalmartSalesData$
group by city, Branch;

--------------------------------------------------
--------------------Product-----------------------
--3. How many unique product lines does the data have?
select distinct [Product line]
from dbo.WalmartSalesData$;
-- count of unique products
select count(distinct [Product line]) as Products
from dbo.WalmartSalesData$;

--4.What is the most common payment method?
select 
		distinct payment, 
		count(Payment) As count
from dbo.WalmartSalesData$
group by Payment
order by count desc;

--5. What are the most selling product?
select 
		distinct [Product line],
		count([Product line]) As count
from dbo.WalmartSalesData$
group by [Product line]
order by count desc;

--6. What is the total revenue by month
select  datename(mm, Date) as Month,--Extracting month from  date
		round(sum(total),2)  as Revenue --rounding to a 2 decimal point
from dbo.WalmartSalesData$
group by  datename(mm, Date)
order by Revenue desc;

-- 7.  What is the month with the largest cogs
select  datename(mm, Date) as Month, --Extracting month from  date
		sum(cogs) as COGS
from dbo.WalmartSalesData$
group by  datename(mm, Date)
order by COGS desc;

--8. What product line had the largest revenue?
select [Product line],
		round(sum(total),2)  as Revenue
from dbo.WalmartSalesData$
group by  [product line]
order by Revenue desc;

--9. What is the city with the largest revenue?
select  City,
		round(sum(total),2)  as Revenue
from dbo.WalmartSalesData$
group by  City
order by Revenue desc;

-- 10. What product line had the largest VAT?
select [Product line],
		round(sum([Tax 5%]),2)  as Tax
from dbo.WalmartSalesData$
group by  [product line]
order by Tax desc;

--11. Which branch sold more products than average product sold?
select  Branch, 
		sum(Quantity) as Quantity
from dbo.WalmartSalesData$
group by branch
having sum(Quantity)  > (select AVG(quantity)from dbo.WalmartSalesData$)
order by Quantity desc;

-- 12. What is the most common product line by gender?
select  
		[Product line],
		Gender,
		count(Gender) as Count
from dbo.WalmartSalesData$
group by gender, [Product line]
order by count desc;

--13. What is the average rating of each product line?
select  
		[Product line],
		round (avg(rating),2) as Rating
from dbo.WalmartSalesData$
group by  [Product line]
order by Rating desc;


--------------------------------------------------
--------------------Sales-------------------------

--14. Number of sales made in each time of the day per weekday
select Time_of_Day, 
		count(*) as Sales
from dbo.WalmartSalesData$ 
where datename(weekday, date) = 'Sunday'
group by  Time_of_day
order by sales desc; 

-- 15. Which of the customer types brings the most revenue?
select [Customer type],
		round(sum(total),2) as Total_Revenue
from dbo.WalmartSalesData$ 
group by [Customer type]
order by Total_Revenue desc;

--16. Which city has the largest tax percent/ VAT (Value Added Tax)?
select 
		City
		,round(avg([Tax 5%]),2) as Avg_Tax
		--,round(sum([Tax 5%]),2) as Total_Tax
from dbo.WalmartSalesData$ 
group by City
order by Avg_Tax desc;

--17. Which customer type pays the most in VAT?
select 
		[Customer type]
		,round(avg([Tax 5%]),2) as Avg_Tax
		--,round(sum([Tax 5%]),2) as Total_Tax
from dbo.WalmartSalesData$ 
group by [Customer type]
order by Avg_Tax desc;


--------------------------------------------------
--------------------Customers---------------------
-- 18. How many unique customer types does the data have?
select
		distinct [Customer type]
from dbo.WalmartSalesData$;

--19. How many unique payment methods does the data have?
select
		distinct Payment,
		count(*) As Count
from dbo.WalmartSalesData$
group by Payment
order by count desc;

--20. What is the most common customer type?
select
		[Customer type],
		count(*) As Count
from dbo.WalmartSalesData$
group by [Customer type]
order by count desc;

--21. Which customer type buys the most?
select
		[Customer type],
		sum(Quantity) As Quantity
from dbo.WalmartSalesData$
group by [Customer type]
order by Quantity desc;

-- 22. What is the gender of most of the customers?
select
		--[Customer type],
		Gender,
		count(gender) As Count
from dbo.WalmartSalesData$
group by Gender
order by count desc;

--23. What is the gender distribution per branch?
select
		Branch,
		Gender,
		count(gender) As Count
from dbo.WalmartSalesData$
group by Gender, Branch
order by Branch;

--24. Which time of the day do customers give most ratings?
select
		Time_of_day,
		round(AVG(rating),2) As Rating
from dbo.WalmartSalesData$
group by Time_of_Day
order by Rating desc;

--25. Which time of the day do customers give most ratings per branch?
select
		Time_of_day,
		round(AVG(rating),2) As Rating
from dbo.WalmartSalesData$
where Branch = 'A'
group by  Time_of_day
order by Rating desc;

--26. Which day of the week has the best avg ratings?
select
		datename(weekday, date) as Day,----Extracting weekdays from  date
		round(AVG(rating),2) As Rating
from dbo.WalmartSalesData$
group by  datename(weekday, date)
order by Rating desc;

--27. Which day of the week has the best average ratings per branch?
select
		datename(weekday, date) as Day, --Extracting weekdays from  date
		round(AVG(rating),2) As Rating
from dbo.WalmartSalesData$
where Branch = 'A'--,'B', 'C'
group by  datename(weekday, date)
order by Rating desc;