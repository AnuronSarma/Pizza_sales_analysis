Create database pizza_db;
use pizza_db;

Select * from pizza_sales;

-- KPI requirements
-- 1) Total revenue

select sum(total_price) as Total_Revenue from pizza_sales;


-- 2) Average order values

Select (sum(total_price)/count(distinct order_id)) as average_order_value from pizza_sales;


-- 3) Sum of quantities of all pizzas sold

Select sum(quantity) as total_quantity_pizza_sold from pizza_sales;


-- 4) Total numbers of orders placed

select count(distinct order_id) as total_no_orders from pizza_sales;


-- 5) Average pizzas per order

Select (count(pizza_id)/ count(distinct order_id)) as average_pizzas_per_order from pizza_sales;


-- Chart requirements/graphical trend requirements
-- 1) Hourly trend for total pizzas sold

select hour(order_time) as hourly_orders, sum(quantity) as total_pizzas_sold 
from pizza_sales
group by 1
order by 1 asc;

-- There is an exponential incraese in pizza orders just after opening and peaks at noon time. After that there is a downtrend 
-- but not for long as there comes another peak time in pizza orders at 18 hours. Since 18 hours the pizza orders decline till the closing of the shop.


-- 2) Weekly trend for total orders

Select week(str_to_date(order_date, '%d-%m-%y')) as weekly_orders,
sum(quantity) as total_pizzas_sold
from pizza_sales
group by 1
order by 1;


-- 3) %age of sales by pizza category

Select pizza_category, month(str_to_date(order_date, '%d-%m-%y')) as months_of_orders,
round(sum(total_price),2) as total_sales, 
round((sum(total_price) * 100/ (select sum(total_price) from pizza_sales)),2) as PCT
from pizza_sales
group by 1,2
order by 2 asc;


-- 4) %age of sales by pizza size

Select pizza_size, month(str_to_date(order_date, '%d-%m-%y')) as months_of_orders,
round(sum(total_price),2) as total_sales, 
round((sum(total_price) * 100/ (select sum(total_price) from pizza_sales)),2) as PCT
from pizza_sales
group by 1,2
order by 2 asc;


-- 5) total pizzas sold by pizza category

Select pizza_category, count(pizza_id) as total_pizzas_sold
from pizza_sales
group by 1
order by 2;

-- 6) Top 5 best sellers by total pizzas sold

Select pizza_name as top_5_best_sellers,
count(pizza_id) as total_pizzas_sold
from pizza_sales
group by 1
order by 2 desc limit 5;


-- 7) Bottom 5 worst sellers by total pizzas sold 

Select pizza_name as bottom_5_worst_sellers,
count(pizza_id) as total_pizzas_sold
from pizza_sales
group by 1
order by 2 asc limit 5;