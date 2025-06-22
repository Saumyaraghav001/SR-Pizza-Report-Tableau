use pizza_sales;
SELECT * FROM pizza_sales.`sales of pizza`;
############=========================TOTAL REVENUE========================================================================================
select round(sum(total_price),1) as total_revenue from `sales of pizza`;
####===========================================================TOTAL PIZZA SALES================================================================================
select sum(quantity) from `sales of pizza`;

####================================================================DISTINCT_ORDER_ID====================================================================

select count(distinct order_id) as total_pizza from `sales of pizza`;

#####AVERAGE ORDER VALUE================================================================================
select round(sum(total_price)/count(distinct order_id),2) as Avg_order_value from `sales of pizza`;

################################ AVERAGE PIZZA PER ORDER=====================================================

select round(sum(quantity)/count(distinct order_id),2) as Avg_pizza_per_order from `sales of pizza`;

##############HOURLY TREND FOR TOTAL PIZZA=======================================================================

select hour(order_time) as order_hours,sum(quantity) as total_pizza_sold from `sales of pizza` group by order_hours order by total_pizza_sold;

##########Data Types of Columns=============================================================================================================
describe `sales of pizza`;

##########COUNT NULL VALUES===================================
SELECT COUNT(*) AS Null_Date_Count
FROM `sales of pizza`
WHERE order_date IS NULL;

##################=============================WEEKLY TREND FOR ORDER=========================================================================================================

SELECT 
    WEEK(STR_TO_DATE(order_date, '%Y-%m-%d'), 1) AS week_number,
    YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')) AS year,
    SUM(quantity) AS total_pizza_sold
FROM `sales of pizza`
WHERE order_date IS NOT NULL
GROUP BY year , week_number 
ORDER BY year ASC, week_number ASC;


SELECT 
    CONCAT(YEAR(STR_TO_DATE(order_date, '%Y-%m-%d')), '-W', LPAD(WEEK(STR_TO_DATE(order_date, '%Y-%m-%d'), 1), 2, '0')) AS YearWeek,
    COUNT(DISTINCT order_id) AS Total_orders
FROM 
    `sales of pizza`
WHERE 
    order_date IS NOT NULL
GROUP BY 
    YearWeek
ORDER BY 
    YearWeek ASC;
    
    
    select * from `sales of pizza`;
####=====================% of pizza sales by pizza size=====================================
select pizza_size,round(sum(total_price),2) as total_revenue,
round(sum(total_price)*100/(select sum(total_price) from `sales of pizza`),2) as PCT 
from `sales of pizza` group by pizza_size;

#################################% od pizza sales by pizza category===================================

select pizza_category, round(sum(total_price),2) ,
round(sum(total_price)*100/(select sum(total_price) from `sales of pizza`),2) as PCT from `sales of pizza`
group by pizza_category;


select * from `sales of pizza`;

select pizza_category ,sum(quantity) as total_quantity_sold from `sales of pizza` group by pizza_category order by total_quantity_sold desc;

select pizza_size, round(sum(total_price)) as total_revenue from `sales of pizza` group by pizza_size order by total_revenue;

#############Bottom 5 by Revenue===========================================================================================================

select pizza_name,round(sum(total_price)) as total_revenue from `sales of pizza`
group by pizza_name order by total_revenue asc limit 5;

############Top 5 by Revenue================================================================================

select pizza_name,round(sum(total_price)) as total_revenue from `sales of pizza`
group by pizza_name order by total_revenue desc limit 5;


########Top- 10 By QTY============================================================================

select pizza_name, sum(quantity) as total_pizza_sold from `sales of pizza`
group by pizza_name order by total_pizza_sold desc limit 10;

#######Bottom-10 BY Qunatity====================================================================

select pizza_name,sum(quantity) as total_pizza_sold from `sales of pizza`
group by pizza_name order by total_pizza_sold asc limit 10;


#######################TOP-10 Pizza By Order===========================================================================

select pizza_name ,count(distinct order_id) as total_order from `sales of pizza`
group by pizza_name order by total_order desc limit 10;

########################BOTTOM -10 By Order=======================================================================

select pizza_name,count(distinct order_id) as total_order from `sales of pizza`
group by pizza_name order by total_order asc limit 10;


#########################TOP-5 Pizza by Name===================================================================

select distinct pizza_category from `sales of pizza`;
select pizza_name,count(distinct order_id) as total_sold_pizza from `sales of pizza`
where pizza_category='classic'
group by pizza_name
order by total_sold_pizza desc limit 5;


select pizza_name,count(distinct order_id)as total_order from `sales of pizza`
where pizza_category='veggie'
group by pizza_name
order by total_order asc limit 5;
