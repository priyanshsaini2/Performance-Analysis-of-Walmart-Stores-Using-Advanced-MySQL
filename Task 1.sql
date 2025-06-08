WITH MonthlySales AS (
    SELECT 
        Branch, 
        DATE_FORMAT(Date, '%Y-%m') AS Month, 
        SUM(Total) AS TotalSales
    FROM walmartsales
    GROUP BY Branch, Month
),
GrowthRate AS (
    SELECT 
        Branch, 
        Month, 
        TotalSales, 
        LAG(TotalSales) OVER (PARTITION BY Branch ORDER BY Month) AS PrevMonthSales,
        ((TotalSales - LAG(TotalSales) OVER (PARTITION BY Branch ORDER BY Month)) / 
            LAG(TotalSales) OVER (PARTITION BY Branch ORDER BY Month)) * 100 AS GrowthRate
    FROM MonthlySales
)
SELECT Branch, TotalSales
FROM GrowthRate
ORDER BY GrowthRate desc
limit 1;