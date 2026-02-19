create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);

insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000);


select * from customer_orders;

--New and repeat customers
--First find out min (order _date) that mean first order date for customer then compare it with table to find out if it is repated 
-- or new customer
with first_order as 
(select customer_id,min(order_date) as first_order_date from customer_orders
group by customer_id)

select co.order_date,
sum(case when co.order_date = fo.first_order_date then 1 else 0 end) as first_visit_customer,
sum(case when co.order_date != fo.first_order_date then 1 else 0 end ) as repeat_visit_customer
from customer_orders co inner join first_order fo
on co.customer_id = fo.customer_id
group by co.order_date