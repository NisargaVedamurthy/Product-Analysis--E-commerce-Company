# Product-Analysis--E-commerce-Company

The Business Objective is to provide data-driven insights that help an e-commerce startup track key business metrics, optimize 
performance, and create a compelling investor pitch for securing funding. 

The dataset contains 6 Tables:
1)Orders Table:
- consists of customers orders with columns Order_id, time when the order is created, website session id, unique user id, product id, count of products purchased, price (revenue), and cost in USD
2) Order_items Table:
- Records show various items ordered by customer with order item id, when the order is created, whether it is primary or non primary item, product info, individual product price, and cost in USD.
3) Order_item_refunds:
- Refund information including when creation date and time and refund amount in USD
4) Website_sessions Table:
- Table is showing where the traffic is coming from and which source is helping to generate the orders. Records consist of unique website session id, UTM (Urchin Tracking Module) fields. UTMs tracking parameters used by Google Analytics to track paid marketing activity.
5) Website_pageviews Table:
- consists of website session_id and pageview URL.
6) Products Table:
- contains information of the product with columns like product_id, creation date of the product in the system and the product name.

The SQL file attached has queries for High Level Metrics, Performance of different products on the day of their launch and after their launch, product portfolio analysis, conversion funnel, product-level website pathing and yearly trend of the products after launch 
