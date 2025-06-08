WITH payment_counts AS (
    SELECT 
        City,
        Payment,
        COUNT(*) AS payment_count,
        RANK() OVER (PARTITION BY City ORDER BY COUNT(*) DESC) AS payment_rank
    FROM walmartsales
    GROUP BY City, Payment
)
SELECT 
    City,
    Payment ,
    payment_count
FROM payment_counts
WHERE payment_rank = 1;
