WITH CustomerPurchases AS (
    SELECT 
        `customer id`,
        STR_TO_DATE(Date, '%d-%m-%Y') AS purchase_date
    FROM walmartsales
    GROUP BY `customer id`, STR_TO_DATE(Date, '%d-%m-%Y')
),
PurchaseSequence AS (
    SELECT 
        `customer id`,
        purchase_date,
        LEAD(purchase_date) OVER (
            PARTITION BY `customer id` ORDER BY purchase_date
        ) AS next_purchase_date
    FROM CustomerPurchases
)
SELECT 
    `customer id`,
    purchase_date,
    next_purchase_date,
    DATEDIFF(next_purchase_date, purchase_date) AS days_between_purchases
FROM PurchaseSequence
WHERE 
    next_purchase_date IS NOT NULL 
    AND DATEDIFF(next_purchase_date, purchase_date) <= 30;