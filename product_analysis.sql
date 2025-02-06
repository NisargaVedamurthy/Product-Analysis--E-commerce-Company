create database DigitalAnalytics;

 use DigitalAnalytics;

select * from order_item_refunds;
select * from order_items;

select distinct primary_product_id
from orders
;

---HLM
select sum(price_usd) as sales,
sum(cogs_usd) as cost_price,
sum(items_purchased) as total_items_sold,
count(distinct user_id) as no_of_users,
count(distinct order_id) as no_of_orders
from orders;

select * from website_pageviews;
select * from website_sessions;

select distinct utm_source
from website_sessions;


-- product-wise sales, number of people who have bought the product and no. of orders
select product_name,
round(sum(price_usd),2) as product_sales,
count(distinct user_id) as no_of_people_purchased,
count(order_id) as no_of_orders
from products p
inner join orders o
on p.product_id=o.primary_product_id
group by product_name;


--where items_purchased are more than one
 select product_name, 
count(items_purchased) as no_of_items_purchased
from products p
inner join orders o
on p.product_id=o.primary_product_id
where items_purchased>1
group by product_name
order by no_of_items_purchased desc
;

--analysing product refund rates
select product_name,
round(sum(refund_amount_usd),2) as refunded_amount,
count(distinct convert(date,o.created_at)) as no_of_days_refunded
from products p
inner join orders o
on p.product_id=o.primary_product_id
inner join order_item_refunds r
on o.order_id=r.order_id
group by product_name
;

--cost of selling of product 1
select distinct price_usd 
from orders
where primary_product_id=1


select * from products;

--sales generated by product 1 on the day of launch
select product_name, 
sum(price_usd) as sales_amount,
sum(items_purchased) as items_sold,
count(distinct user_id) as no_of_users
from orders o
inner join products p
on o.primary_product_id=p.product_id
where convert(date,o.created_at)='2012-03-19' 
and product_id=1
group by product_name
;


--sales generated by product 2 on the day of launch
--the below query outputs no rows, it means that there was no sales happened for prod 2 on the day of launch
select product_name, 
sum(price_usd) as sales_amount,
sum(items_purchased) as items_sold,
count(distinct user_id) as no_of_users
from orders o
inner join products p
on o.primary_product_id=p.product_id
where convert(date,o.created_at)='2013-01-06' 
and product_id=2
group by product_name
;

----sales generated by product 3 on the day of launch
select product_name, 
sum(price_usd) as sales_amount,
sum(items_purchased) as items_sold,
count(distinct user_id) as no_of_users
from orders o
inner join products p
on o.primary_product_id=p.product_id
where convert(date,o.created_at)='2013-12-12' 
and product_id=3
group by product_name
;


----sales generated by product 4 on the day of launch
--the below query outputs no rows, it means that there was no sales happened for prod 4 on the day of launch
select product_name, 
sum(price_usd) as sales_amount,
sum(items_purchased) as items_sold,
count(distinct user_id) as no_of_users
from orders o
inner join products p
on o.primary_product_id=p.product_id
where convert(date,o.created_at)='2014-02-05' 
and product_id=4
group by product_name
;


select * from products;

--sales generated by product 1 after the day of launch
select product_name, 
sum(price_usd) as sales_amount,
sum(items_purchased) as items_sold,
count(distinct user_id) as no_of_users
from orders o
inner join products p
on o.primary_product_id=p.product_id
where convert(date,o.created_at)>'2012-03-19' 
and product_id=1
group by product_name
;

--sales generated by product 2 after the day of launch
select product_name, 
sum(price_usd) as sales_amount,
sum(items_purchased) as items_sold,
count(distinct user_id) as no_of_users
from orders o
inner join products p
on o.primary_product_id=p.product_id
where convert(date,o.created_at)>'2013-01-06' 
and product_id=2
group by product_name
;

--sales generated by product 3 after the day of launch
select product_name, 
sum(price_usd) as sales_amount,
sum(items_purchased) as items_sold,
count(distinct user_id) as no_of_users
from orders o
inner join products p
on o.primary_product_id=p.product_id
where convert(date,o.created_at)>'2013-12-12' 
and product_id=3
group by product_name
;

--sales generated by product 4 after the day of launch
select product_name, 
sum(price_usd) as sales_amount,
sum(items_purchased) as items_sold,
count(distinct user_id) as no_of_users
from orders o
inner join products p
on o.primary_product_id=p.product_id
where convert(date,o.created_at)>'2014-02-05' 
and product_id=4
group by product_name
;

--yearly trend of prods after the launch
select DATEPART(yyyy, o.created_at) as year,
 DATEPART(mm, o.created_at) as month,
 product_name,
sum(price_usd) as sales_amount
from orders o
inner join products p
on o.primary_product_id=p.product_id
group by DATEPART(yyyy, o.created_at),
DATEPART(mm, o.created_at), product_name
;


--cross selling
select products_bought_together, count(*) as count_of_products
 from
 (
 select order_id, string_agg(primary_product_id,'-') within group (order by primary_product_id) as products_bought_together
 from
 (select order_id, primary_product_id
 from orders 
 group by order_id,primary_product_id
 ) a 
 group by order_id
 having count(distinct primary_product_id)>1
 ) b
 group by products_bought_together
 order by count_of_products desc
 ;

 --this shows that 1 order doesnt have two different products at all
 select order_id, count(distinct primary_product_id)
 from orders 
 group by order_id
 having count(distinct primary_product_id)>1

 -- this shows that there was no cross buying of products, i.e no two diffft products were bought together
 select *
 from orders 
 where items_purchased>1
 order by items_purchased desc


 -- product-level website pathing
select device_type, product_name,
round(sum(price_usd),2) as sales_amount, 
count(order_id) as no_of_orders,
sum(items_purchased) as qty_sold
from website_sessions ws
inner join orders o 
on o.user_id=ws.user_id
inner join products p
on o.primary_product_id=p.product_id
group by device_type, product_name
order by product_name, device_type
;


 --product portfolio analysis
 select datepart(yyyy, o.created_at) as year,
 datepart(month, o.created_at) as month,
 product_name,
 sum(price_usd) as sales_amount,
 sum(refund_amount_usd) as amount_refunded
 from order_item_refunds ir 
 inner join orders o 
 on ir.order_id=o.order_id
 inner join products p
 on o.primary_product_id=p.product_id
 group by product_name, datepart(yyyy, o.created_at),
 datepart(month, o.created_at)
 order by year, month
 ;

 --conversion funnel
select product_name,
pageview_url,
count(distinct o.website_session_id) as no_of_sessions
from products p
inner join orders o 
on p.product_id=o.primary_product_id
inner join website_pageviews pv
on pv.website_session_id=o.website_session_id
group by product_name, pageview_url
order by product_name
;

--cross selling ration
WITH FilteredSales AS (
    SELECT
        order_id,
        product_id,
        is_primary_item,
        created_at
    FROM
        order_items
    WHERE
        created_at >= '2014-12-05'
),
TotalSales AS (
    SELECT
        product_id,
        COUNT(order_id) AS TotalSales
    FROM
        FilteredSales
    WHERE
        is_primary_item = 1
    GROUP BY
        product_id
)
, CrossSellPerformance AS (
SELECT
        fs1.product_id AS PrimaryProduct,
        fs2.product_id AS CrossSellProduct,
        COUNT(DISTINCT fs1.order_id) AS CrossSellCount
    FROM
        FilteredSales fs1
    JOIN
        FilteredSales fs2
    ON
        fs1.order_id = fs2.order_id
        AND fs1.product_id <> fs2.product_id
        AND fs1.is_primary_item = 1
        AND fs2.is_primary_item = 0
    GROUP BY
        fs1.product_id,
        fs2.product_id
)
SELECT
    t.product_id AS PrimaryProduct,
    t.TotalSales,
    c.CrossSellProduct,
    c.CrossSellCount,
    round((c.CrossSellCount * 1.0 / t.TotalSales)*1000,2) AS CrossSellRatio
FROM
    TotalSales t
LEFT JOIN
    CrossSellPerformance c
ON
    t.product_id = c.PrimaryProduct
ORDER BY
    PrimaryProduct,
    CrossSellProduct;