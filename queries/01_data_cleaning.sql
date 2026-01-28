-- Create a cleaned version of the data
CREATE TABLE online_retail_clean AS
SELECT 
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    (Quantity * UnitPrice) as TotalPrice
FROM online_retail
WHERE 
    CustomerID IS NOT NULL  -- Remove records without customer info
    AND Quantity > 0  -- Remove returns/cancellations for initial analysis
    AND UnitPrice > 0  -- Remove zero-price items
    AND InvoiceNo NOT LIKE 'C%';  -- Remove cancelled orders

-- Verify your cleaned data
SELECT COUNT(*) FROM online_retail_clean;
