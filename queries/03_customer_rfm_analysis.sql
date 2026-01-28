-- Analysis #3: RFM Analysis
WITH customer_rfm AS (
    SELECT 
        CustomerID,
        -- Recency: Days since last purchase (lower is better)
        julianday('2011-12-09') - julianday(MAX(InvoiceDate)) as recency,
        -- Frequency: Number of purchases
        COUNT(DISTINCT InvoiceNo) as frequency,
        -- Monetary: Total amount spent
        ROUND(SUM(TotalPrice), 2) as monetary
    FROM online_retail_clean
    GROUP BY CustomerID
),
rfm_scores AS (
    SELECT 
        CustomerID,
        recency,
        frequency,
        monetary,
        -- Create RFM scores (1-5, where 5 is best)
        CASE 
            WHEN recency <= 30 THEN 5
            WHEN recency <= 60 THEN 4
            WHEN recency <= 90 THEN 3
            WHEN recency <= 180 THEN 2
            ELSE 1
        END as R_score,
        CASE 
            WHEN frequency >= 50 THEN 5
            WHEN frequency >= 20 THEN 4
            WHEN frequency >= 10 THEN 3
            WHEN frequency >= 5 THEN 2
            ELSE 1
        END as F_score,
        CASE 
            WHEN monetary >= 5000 THEN 5
            WHEN monetary >= 2000 THEN 4
            WHEN monetary >= 1000 THEN 3
            WHEN monetary >= 500 THEN 2
            ELSE 1
        END as M_score
    FROM customer_rfm
)
SELECT 
    CASE 
        WHEN R_score >= 4 AND F_score >= 4 THEN 'Champions'
        WHEN R_score >= 3 AND F_score >= 3 THEN 'Loyal Customers'
        WHEN R_score >= 4 AND F_score <= 2 THEN 'Promising'
        WHEN R_score <= 2 AND F_score >= 3 THEN 'At Risk'
        WHEN R_score <= 2 AND F_score <= 2 THEN 'Lost'
        ELSE 'Others'
    END as customer_segment,
    COUNT(*) as num_customers,
    ROUND(AVG(monetary), 2) as avg_spending,
    ROUND(SUM(monetary), 2) as total_value
FROM rfm_scores
GROUP BY customer_segment
ORDER BY total_value DESC;
