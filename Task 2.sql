SELECT branch, `product line`, total_profit
FROM (
    SELECT branch, `product line`, 
           SUM(`gross income` + cogs) AS total_profit,
           RANK() OVER (PARTITION BY branch ORDER BY SUM(`gross income` - cogs) desc) AS rankvalue
    FROM walmartsales
    GROUP BY branch, `product line`
) ranked_data
WHERE rankvalue = 1
;



