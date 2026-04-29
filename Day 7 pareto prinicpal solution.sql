/*The Pareto Principle (80/20 rule) states that 80% of outcomes often come from 20% of causes.

In retail analytics, this commonly translates to:
80% of total sales come from 20% of the products
You are given an orders table containing sales transactions for multiple products across several years.

🎯 Objective
Write a SQL query to identify the top 20% of products that cumulatively contribute to at least 80% of total sales.

📋 Table Structure

CREATE TABLE orders (
    order_id   VARCHAR(14),
    order_date DATE,
    product_id VARCHAR(15),
    sales      NUMERIC(9,4)
);
*/
/*
--Find out 80% of Total Sale
select sum(sales) * 0.8 from orders
Answer: 1837760.77711996
*/

--Find out highest saling products and keep it in desc order and Create CTE
WITH product_wise_sales as(
select product_id,sum(sales) as product_sales
from orders 
group by product_id
)
select product_id,product_sales
,sum(product_sales) over (order by product_sales desc rows between unbounded preceding and 0 preceding) as running_sales
,0.8*sum(product_sales) over () as total_sales
from product_wise_sales


