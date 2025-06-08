SELECT 
    `Customer ID`, 
    SUM(Total) AS total_sales
FROM walmartsales
GROUP BY `Customer ID`
ORDER BY total_sales DESC
LIMIT 5;
