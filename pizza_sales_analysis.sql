create database pizza_sales;

use pizza_sales;

create table sales(
pizza_id int primary key,
order_id int,
pizza_name_id varchar(100),	
quantity int, 	
order_date date,
order_time time,
unit_price decimal(5,2),
total_price	decimal(5,2),
pizza_size	varchar(20),
pizza_category varchar(30),
pizza_ingredients varchar(100),
pizza_name varchar(50)
);

select * from sales;

#Total Revenue
select sum(total_price) as total_revenue
from sales;

#average order value
select round(sum(total_price)/count(distinct order_id),2) as avg_order_value
from sales;

#total pizzas sold
select sum(quantity) as total_pizza_sold
from sales;

#total orders
select count(distinct order_id) as total_orders
from sales;

#average pizza per order
select round(sum(quantity)/count(distinct order_id),2) as average_pizza_per_order
from sales;

#Daily trend for total orders
select dayname(order_date) day_of_week,
count(distinct order_id) total_orders
from sales
group by day_of_week
order by 
  field(day_of_week, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
  
#Monthly trend for total orders
select monthname(order_date) month_name,
count(distinct order_id) total_orders
from sales
group by month_name
order by 
  field(month_name, 'January', 'February', 'March', 'April', 'May', 'June', 'July','August','September','October','November','December');
  
#Hourly trend for total orders
select hour(order_time) as hour_of_day,
count(distinct order_id) as total_orders
from sales
group by hour_of_day
order by hour_of_day;
  
#%of sales by pizza category
select pizza_category,
sum(total_price) as total_sales,
round((sum(total_price)/(select sum(total_price) from sales))*100,2) as perc_sales
from sales
group by pizza_category;

#%of sales by pizza size
select pizza_size,
sum(total_price) as total_sales,
round((sum(total_price)/(select sum(total_price) from sales))*100,2) as perc_sales
from sales
group by pizza_size;

select pizza_size,
sum(total_price) as total_sales,
round((sum(total_price)/(select sum(total_price) from sales where quarter(order_date)=1))*100,2) as perc_sales
from sales
where quarter(order_date)=1
group by pizza_size;

#top 5 best selling by revenue, total orders, total quantity
#by revenue
select pizza_name,
sum(total_price) as revenue
from sales
group by pizza_name
order by sum(total_price) desc
limit 5;

#by total orders
select 
pizza_name,
count(distinct order_id) as total_orders
from sales
group by pizza_name
order by total_orders desc
limit 5;

#by total quantity
select 
pizza_name,
sum(quantity) as revenue
from sales
group by pizza_name
order by sum(quantity) desc
limit 5;


#Bottom 5 best selling by revenue, total orders, total quantity
#by revenue
select pizza_name,
sum(total_price) as revenue
from sales
group by pizza_name
order by sum(total_price)
limit 5;

#by total orders
select 
pizza_name,
count(distinct order_id) as total_orders
from sales
group by pizza_name
order by total_orders
limit 5;

#by total quantity
select 
pizza_name,
sum(quantity) as revenue
from sales
group by pizza_name
order by sum(quantity) desc
limit 5;



  



