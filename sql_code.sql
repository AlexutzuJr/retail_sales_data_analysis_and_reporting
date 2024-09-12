-- cautam primele 10 produse care genereaza cele mai mari venituri
SELECT TOP 10 product_id, SUM(sale_price) AS sales
FROM df_orders
GROUP BY product_id
ORDER BY sales DESC;


-- cautam top 5 cele mai vandute produse din fiecare regiune
WITH CTE AS (
SELECT region, product_id, SUM(sale_price) AS sales
FROM df_orders
GROUP BY region, product_id
)
SELECT * FROM (
SELECT *, ROW_NUMBER() OVER (PARTITION BY region ORDER BY sales DESC) AS rn
FROM CTE
) AS A
WHERE rn <= 5;


-- cautam o comparatie de crestere luna de luna pentru vanzarile din 2022 si 2023, de exemplu: ianuarie 2022 vs ianuarie 2023
WITH CTE AS (
SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month, SUM(sale_price) AS sales
FROM df_orders
GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT order_month, SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022, SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
FROM CTE
GROUP BY order_month
ORDER BY order_month;


-- cautam care luna a avut cele mai mari vanzari pentru fiecare categorie
WITH CTE AS (
SELECT category, FORMAT(order_date, 'yyyyMM') AS order_year_month, SUM(sale_price) AS sales 
FROM df_orders
GROUP BY category, FORMAT(order_date, 'yyyyMM')
)
SELECT * FROM (
SELECT *, ROW_NUMBER() OVER(PARTITION BY category ORDER BY sales DESC) AS rn
FROM cte
) AS A
WHERE rn = 1;


-- cautam care subcategorie a avut cea mai mare crestere a profitului in 2023 comparativ cu 2022
WITH CTE AS (
SELECT sub_category, YEAR(order_date) AS order_year, SUM(sale_price) AS sales
FROM df_orders
GROUP BY sub_category, YEAR(order_date)
), 
CTE2 AS (
SELECT sub_category, 
SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022, 
sum(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023
FROM CTE
GROUP BY sub_category
)
SELECT TOP 1 *, (sales_2023 - sales_2022) AS growth
FROM  CTE2
ORDER BY growth DESC;
