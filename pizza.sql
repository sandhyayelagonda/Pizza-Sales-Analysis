select * from pizza_sales;


-- KPI's
--$$$$$$$$$$$$$$$$$$$$$$$$$$

-- Total Revenu
-- ====================================
Select sum(total_price) as Total_Revenu from pizza_sales

-- Average order value
-- ====================================

select round((sum(total_price)/count(Distinct order_id)),2) as Average_order_value from pizza_sales;

--Total pizzas sold
--======================================
Select sum(Quantity) as Total_pizza_sold from pizza_sales;

-- Total orders
--=====================================
select count(distinct order_id) as Total_orders from pizza_sales;

-- Average pizza per order
--===============
Select round((sum(Quantity)/(count(distinct order_id))),2) as Avg_pizza_per_order from pizza_sales;

--Chart Requirments

-- Daily Trend for total Orders
-- ======================================
select to_char(order_date,'Day') as Week_day, count(distinct order_id) as total_orders
from pizza_sales
group by to_char(order_date,'Day');

-- Monthly trend for total orders
--============================
select to_char(order_date,'Month') as Month_name, count(distinct order_id) as total_orders
from pizza_sales
group by to_char(order_date,'Month');

--Percentage of sales by pizza category
--=========================================

--select sum(total_price) from pizza_sales

select pizza_category, sum(total_price) as total_revenue, round(sum(total_price)*100/(Select sum(total_price) from pizza_sales),2) as percent_pizza_category from pizza_sales
group by pizza_category

-- percentage of sales by pizza siza
--======================================
select pizza_size, sum(total_price) as total_revenue, round(sum(total_price)*100/(Select sum(total_price) from pizza_sales),2) as percent_pizza_category from pizza_sales
group by pizza_size

-- Total pizzas sold by pizza category
--=============================================
select pizza_category, sum(Quantity) as total_Quantity from pizza_sales
group by pizza_category
order by 2

--Top 5 best sellers by revenue
--===============================================

SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
fetch first 5 rows only

-- usin CTE

with row_num as
(
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue DESC
)

select pizza_name, total_revenue from row_num
where rownum <= 5

-- Bottom 5 pizzas
--====================================
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue
fetch first 5 rows only

with row_num as
(
SELECT pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue 
)

select pizza_name, total_revenue from row_num
where rownum <= 5

--Top 5 pizzas by quantity
--=================================
SELECT pizza_name, SUM(Quantity) AS pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_sold desc
fetch first 5 rows only

--bottom 5 pizzas by quantity
--=================================
SELECT pizza_name, SUM(Quantity) AS pizza_sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY pizza_sold 
fetch first 5 rows only

--bottom 5 pizzas by total orders
--====================================
SELECT pizza_name, count(distinct order_id) AS total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY total_orders 
fetch first 5 rows only



