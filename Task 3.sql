WITH customer_spending AS (
    SELECT `customer ID`, SUM(total) AS total_spent
    FROM walmartsales
    GROUP BY `customer id`
),
ranked_customers AS (
    SELECT `customer ID`, total_spent,
           NTILE(4) OVER (ORDER BY total_spent) AS spending_quartile
    FROM customer_spending
)
SELECT `customer ID`, total_spent,
       CASE 
           WHEN spending_quartile = 4 THEN 'High Spender'
           WHEN spending_quartile IN (2, 3) THEN 'Medium Spender'
           ELSE 'Low Spender'
       END AS spending_category
FROM ranked_customers
ORDER BY total_spent DESC;

