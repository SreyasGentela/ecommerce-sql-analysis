-- Analysis #1: Monthly sales trend
SELECT 
    strftime('%Y-%m', InvoiceDate) as YearMonth,
    COUNT(DISTINCT InvoiceNo) as num_orders,
    COUNT(DISTINCT CustomerID) as num_customers,
    SUM(TotalPrice) as total_revenue,
    ROUND(SUM(TotalPrice) / COUNT(DISTINCT InvoiceNo), 2) as avg_order_value
FROM online_retail_clean
GROUP BY strftime('%Y-%m', InvoiceDate)
ORDER BY YearMonth;
