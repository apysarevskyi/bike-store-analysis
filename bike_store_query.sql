CREATE DATABASE bike_store;
USE bike_store;
SELECT o.order_id, o.customer_id, o.order_status, o.order_date, 
       c.first_name, c.last_name, c.city, c.state
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;
SELECT city, COUNT(*) AS customer_count
FROM customers
GROUP BY city
ORDER BY customer_count DESC;
SELECT c.customer_id, c.city, c.state, 
       COUNT(o.order_id) AS order_frequency,
       SUM(oi.list_price * oi.quantity - oi.discount) AS total_spending
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.city, c.state
ORDER BY total_spending DESC;
SELECT DATE_FORMAT(o.order_date, '%Y-%m') AS month, 
       SUM(oi.list_price * oi.quantity - oi.discount) AS monthly_sales
FROM orders o
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY month
ORDER BY month;
SELECT p.product_id, p.product_name, p.category_id, 
       SUM(oi.quantity) AS total_quantity, 
       SUM(oi.list_price * oi.quantity - oi.discount) AS total_revenue
FROM products p
JOIN order_items oi ON p.product_id = oi.product_id
GROUP BY p.product_id, p.product_name, p.category_id
ORDER BY total_revenue DESC;
SELECT s.store_id, st.store_name, p.product_id, p.product_name, 
       SUM(s.quantity) AS total_stock
FROM stocks s
JOIN products p ON s.product_id = p.product_id
JOIN stores st ON s.store_id = st.store_id
GROUP BY s.store_id, st.store_name, p.product_id, p.product_name
ORDER BY total_stock DESC;
SELECT sf.staff_id, sf.first_name, sf.last_name, 
       SUM(oi.list_price * oi.quantity - oi.discount) AS total_sales
FROM staffs sf
JOIN orders o ON sf.staff_id = o.staff_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY sf.staff_id, sf.first_name, sf.last_name
ORDER BY total_sales DESC;
SELECT c.customer_id, SUM(oi.list_price * oi.quantity - oi.discount) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id
ORDER BY lifetime_value DESC;
SELECT AVG(total_order_value) AS average_order_value
FROM (
    SELECT o.order_id, SUM(oi.list_price * oi.quantity - oi.discount) AS total_order_value
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    GROUP BY o.order_id
) AS order_totals;
SELECT c.category_name, SUM(oi.list_price * oi.quantity - oi.discount) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN categories c ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY total_revenue DESC;
SELECT AVG(oi.discount) AS average_discount
FROM order_items oi;
SELECT (COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) / COUNT(DISTINCT customer_id)) * 100 AS repeat_customer_rate
FROM (
    SELECT c.customer_id, COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id
) AS customer_orders;
SELECT st.store_id, st.store_name, 
       SUM(oi.list_price * oi.quantity - oi.discount) AS total_sales
FROM stores st
JOIN orders o ON st.store_id = o.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY st.store_id, st.store_name
ORDER BY total_sales DESC;



