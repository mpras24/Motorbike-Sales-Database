USE bike;

CREATE VIEW PRO_BRAND_CAT AS
SELECT p.product_id, p.product_name, c.category_name, p.model_year, p.list_price, p.brand_id, b.brand_name
FROM products p
JOIN brands b
JOIN categories c
ON b.brand_id = p.brand_id
AND p.category_id = c.category_id;


CREATE VIEW CUS_OR_ORIT AS
SELECT cs.customer_id, cs.first_name, cs.city, cs.state,
o.order_id, o.order_date, o.required_date, o.shipped_date, o.store_id, o.staff_id,
os.product_id, os.quantity, os.list_price, os.discount
FROM customers cs
JOIN orders o
JOIN order_items os
ON cs.customer_id = o.customer_id
AND os.order_id = o.order_id;


CREATE VIEW STORE_STAFF_SS AS
SELECT st.product_id, st.quantity, ss.store_name, ss.city as store_city, ss.state as store_state
FROM stocks st
JOIN stores ss
ON ss.store_id = st.store_id;


# FROM VIEW
CREATE VIEW COMPLETE_DATA AS
SELECT coo.customer_id, coo.first_name, coo.city, coo.state, coo.order_date, coo.required_date, coo.shipped_date, coo.quantity AS ordered_quantity,
coo.list_price AS order_item_listPrice, coo.discount,
pbc.product_name, pbc.category_name, pbc.model_year, pbc.list_price AS product_listPrice, pbc.brand_name,
sss.quantity AS stocks_quantity, sss.store_name, sss.store_city, sss.store_state
FROM cus_or_orit coo
JOIN pro_brand_cat pbc
JOIN store_staff_ss sss
ON coo.product_id = pbc.product_id
AND coo.product_id = sss.product_id;



CREATE VIEW CD AS
SELECT customer_id, first_name, city, state, ordered_quantity, order_item_listPrice, discount, product_name, category_name, model_year,
product_listPrice, brand_name, stocks_quantity, store_name, store_city, store_state,order_date, required_date,shipped_date, count(customer_id) as ci
FROM bike.complete_data 
group by customer_id, first_name, city, state, ordered_quantity, order_item_listPrice, discount, product_name, category_name, model_year,
product_listPrice, brand_name, stocks_quantity, store_name, store_city, store_state,order_date, required_date,shipped_date;

# DATEDIFF(order_date, required_date) AS order_reqDay_Diff, DATEDIFF(required_date, shipped_date) AS req_shipDay_Difference

DROP VIEW CD