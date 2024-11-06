SELECT 
    ys.year,
    lt.lease_type AS transaction_type,
    COUNT(ls.lease_sales_id) AS transaction_count,
    ROUND(AVG(
        CASE 
            WHEN lt.lease_type = '전세' THEN ls.deposit / ls.lease_area / 3.305
            WHEN lt.lease_type = '월세' THEN ls.rent / ls.lease_area / 3.305
        END
    )) AS avg_price_per_pyeong
FROM 
    raw_data.lease_sales ls
LEFT JOIN 
    raw_data.year ys ON ls.contract_year_id = ys.year_id
LEFT JOIN 
    raw_data.lease_type lt ON ls.lease_type_id = lt.lease_type_id
GROUP BY 
    ys.year, lt.lease_type
ORDER BY 
    ys.year, lt.lease_type;
