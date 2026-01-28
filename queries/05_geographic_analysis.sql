-- Analysis #5: Sales by country
SELECT 
    Country,
    COUNT(DISTINCT CustomerID) as num_customers,
    COUNT(DISTINCT InvoiceNo) as num_orders,
    ROUND(SUM(TotalPrice), 2) as total_revenue,
    ROUND(SUM(TotalPrice) / COUNT(DISTINCT CustomerID), 2) as revenue_per_customer
FROM online_retail_clean
GROUP BY Country
HAVING num_customers > 5  -- Filter out countries with few customers
ORDER BY total_revenue DESC;
