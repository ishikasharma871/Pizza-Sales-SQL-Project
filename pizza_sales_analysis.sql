use pizza_hut;
-- Retrieve the total number of orders placed

 select count(order_id) from orders;
 
--  calculate the total revenue geneated from pizza_sales.

select sum(order_details.quantity*pizzas.price) as total_sales
from order_details join pizzas 
on pizzas.pizza_id=order_details.pizza_id;

-- identify the highest -priced pizza.

select pizza_types.name,pizzas.price
from pizza_types join pizzas 
on pizzas.pizza_type_id =pizza_types.pizza_type_id
order by pizzas.price desc limit 1;

   
-- Identify the most common pizza size ordered

SELECT pizzas.size,
       COUNT(order_details.order_details_id) AS order_count
FROM pizzas
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC;
 select order_details_id from order_details;

-- list the top 5  most ordered pizza 
-- type along with their qunantities

SELECT pizza_types.name,
       SUM(order_details.quantity) AS quantity
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name  
ORDER BY quantity DESC
LIMIT 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.Category  ,sum(order_details.quantity)as quantity 
 from pizza_types join pizzas 
 on pizza_types.pizza_type_id=pizzas.pizza_type_id
 join order_details
 on order_details.pizza_id=pizzas.pizza_id
 group by pizza_types.Category  
 order by quantity  desc;

-- Determine the distribution of orders by hour of the day.

select hour(time) as hour ,count( order_id)  as no_of_orders from orders
group by hour(time)  ;


-- Join relevant tables to find the category-wise distribution of pizzas.

select   category,count(Category) as count  from pizza_types 
group by Category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
select  avg(quantity)  avg_order_perday from 
(select orders.date ,sum(order_details.quantity) as quantity
from orders  join order_details
 on orders.order_id=order_details.order_id
 group by orders.date ) as order_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name ,sum(order_details.quantity * pizzas.price) as revenue 
from pizza_types join pizzas 
on pizza_types.pizza_type_id=pizzas.pizza_type_id
join order_details 
on order_details.pizza_id=pizzas.pizza_id
 group by pizza_types.name 
 order by revenue  DESC limit 3;

-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT pizza_types.Category,
       ROUND((SUM(order_details.quantity * pizzas.price) / (
           SELECT SUM(order_details.quantity * pizzas.price)
           FROM order_details
           JOIN pizzas ON pizzas.pizza_id = order_details.pizza_id
       )) * 100, 2) AS revenue_percentage
FROM pizza_types
JOIN pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.Category
ORDER BY revenue_percentage DESC;



