SELECT 
    ys.year,
    COUNT(ls.lease_sales_id) AS transaction_count,
    ROUND(AVG(ls.deposit / ls.lease_area / 3.305)) AS avg_price_per_pyeong,
    bt.building_type 
FROM 
    raw_data.lease_sales ls
LEFT JOIN 
    raw_data.year ys ON ls.contract_year_id = ys.year_id
LEFT JOIN 
    raw_data.lease_type lt ON ls.lease_type_id = lt.lease_type_id
LEFT JOIN 
	raw_data.building_type bt on bt.building_type_id = ls.building_type_id 
WHERE 
    lt.lease_type = '전세'
GROUP BY 
    ys.year, lt.lease_type, bt.building_type 
ORDER BY 
    ys.year;
