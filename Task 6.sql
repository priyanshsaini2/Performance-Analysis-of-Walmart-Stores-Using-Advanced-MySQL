SELECT 
    MONTHNAME(STR_TO_DATE(Date, '%d-%m-%Y')) AS month_name,
    Gender,
    SUM(Total) AS total_sales
FROM walmartsales
GROUP BY month_name, Gender
ORDER BY STR_TO_DATE(CONCAT('01-', month_name, '-2019'), '%d-%M-%Y');


