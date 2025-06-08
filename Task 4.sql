WITH product_sales_stats AS (
    SELECT 
        `Product line`, 
        AVG(Total) AS avg_sales, 
        STDDEV(Total) AS std_dev_sales
    FROM walmartsales
    GROUP BY `Product line`
),
sales_anomalies AS (
    SELECT 
        w.`Invoice ID`,
        w.`Product line`,
        w.`Total`,
        p.avg_sales,
        p.std_dev_sales,
        (w.`Total` - p.avg_sales) / p.std_dev_sales AS z_score
    FROM walmartsales w
    JOIN product_sales_stats p 
    ON w.`Product line` = p.`Product line`
)
SELECT 
    `Invoice ID`,
    `Product line`,
    `Total`,
    z_score,
    CASE 
        WHEN ABS(z_score) > 3 THEN 'High Anomaly'
        WHEN ABS(z_score) BETWEEN 2 AND 3 THEN 'Moderate Anomaly'
        ELSE 'Normal'
    END AS anomaly_status
FROM sales_anomalies
WHERE ABS(z_score) > 2
ORDER BY ABS(z_score) DESC;
