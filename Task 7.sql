WITH product_sales AS (
    SELECT 
        `Customer type`,
        `Product line`,
        SUM(Total) AS total_sales,
        RANK() OVER (PARTITION BY `Customer type` ORDER BY SUM(Total) DESC) AS rank_order
    FROM walmartsales
    GROUP BY `Customer type`, `Product line`
)
SELECT 
    `Customer type`,
    `Product line`,
    total_sales
FROM product_sales
WHERE rank_order = 1;
