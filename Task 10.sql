SELECT 
    DAYNAME(STR_TO_DATE(Date, '%d-%m-%Y')) AS day_of_week,
    SUM(Total) AS total_sales
FROM walmartsales
GROUP BY day_of_week
ORDER BY total_sales DESC;



