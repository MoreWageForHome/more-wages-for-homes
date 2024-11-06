SELECT 
    ys.year,
    COUNT(ps.property_sales_id) AS property_transaction_count,
    ROUND(AVG(ps.price / (ps.lease_area / 3.305))) AS avg_price_per_pyeong
FROM 
    raw_data.property_sales ps
LEFT JOIN 
    raw_data.year ys ON ps.contract_year_id = ys.year_id
GROUP BY 
    ys.year
ORDER BY 
    ys.year;
