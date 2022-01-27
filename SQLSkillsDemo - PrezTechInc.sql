--===============================================================================================--
--SQL Skills Demo - Jordan Hasty
--SQL Flavor: SQL Server
--Skills included: Simple queries, Joins, Aggregate Functions, Group By/Having, CTE, Subqueries, Stored Procedures
--Data Set: PrezTech, Inc - An entirely fictitious software company staffed by former US Presidents
--===============================================================================================--

-- 1: Which employees have a salary over $100K?
SELECT concat(first_name,' ',last_name) as [full name], title, salary 
FROM employees 
WHERE salary > 100000
ORDER BY salary desc

-- 2: What is the average engineer salary by level?
SELECT title, AVG(salary) as avg_salary
FROM employees
WHERE title like 'Engineer%'
GROUP BY title

-- 3: Which salesman had the most sales and volume? 
SELECT concat(e.first_name,' ',e.last_name) as [full name], e.title, e.salary, 
	SUM(ps.sale_price) as [Total Sales], 
	SUM(ps.license_ct) as [Total Volume]
FROM employees e
INNER JOIN product_sales ps on ps.employee_id = e.employee_id
GROUP BY concat(e.first_name,' ',e.last_name), e.title, e.salary
ORDER BY [Total Sales] desc

--4: What were the Support KPIs (Customer Satisfaction, Tickets Closed, Time to Close) by Support Tech? 
SELECT CONCAT(e.first_name,' ',e.last_name) as [full name], e.title, 
	ROUND(AVG(CAST(st.client_sat_score as float)),2) as [Avg Client Sat], 
	COUNT(st.ticket_id) as [Tickets Closed], 
	AVG(DATEDIFF(d,st.open_date,st.close_date)) as [Avg Time to Close]
FROM employees e
INNER JOIN support_tickets st on st.ticket_owner = e.employee_id
GROUP BY CONCAT(e.first_name,' ',e.last_name), e.title
ORDER BY [Avg Client Sat] desc

--5: Which Support Technicians had the most perfect Customer Satisfaction Scores? 
SELECT CONCAT(e.first_name,' ',e.last_name) as [full name], e.title, 
	COUNT(st.ticket_id) as [Tickets]
FROM employees e
INNER JOIN support_tickets st on st.ticket_owner = e.employee_id
WHERE st.client_sat_score = 10
GROUP BY CONCAT(e.first_name,' ',e.last_name), e.title
ORDER BY [Tickets] desc