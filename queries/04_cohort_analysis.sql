-- Analysis #4: Monthly cohort retention
WITH first_purchase AS (
    SELECT 
        CustomerID,
        DATE(MIN(InvoiceDate), 'start of month') as cohort_month
    FROM online_retail_clean
    GROUP BY CustomerID
),
customer_activity AS (
    SELECT 
        r.CustomerID,
        f.cohort_month,
        DATE(r.InvoiceDate, 'start of month') as activity_month
    FROM online_retail_clean r
    JOIN first_purchase f ON r.CustomerID = f.CustomerID
)
SELECT 
    cohort_month,
    COUNT(DISTINCT CASE WHEN activity_month = cohort_month THEN CustomerID END) as month_0,
    COUNT(DISTINCT CASE WHEN activity_month = DATE(cohort_month, '+1 month') THEN CustomerID END) as month_1,
    COUNT(DISTINCT CASE WHEN activity_month = DATE(cohort_month, '+2 month') THEN CustomerID END) as month_2,
    COUNT(DISTINCT CASE WHEN activity_month = DATE(cohort_month, '+3 month') THEN CustomerID END) as month_3
FROM customer_activity
GROUP BY cohort_month
ORDER BY cohort_month;
