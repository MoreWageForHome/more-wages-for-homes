SELECT 
    d.district_name,
    bt.building_type,
    ys.year,
    lt.lease_type,
    COUNT(ls.lease_sales_id) AS lease_transaction_count
FROM 
    raw_data.district d
LEFT JOIN 
    raw_data.lease_sales ls ON d.district_id = ls.district_id
LEFT JOIN 
    raw_data.building_type bt ON ls.building_type_id = bt.building_type_id
LEFT JOIN 
    raw_data.year ys ON ls.contract_year_id = ys.year_id
LEFT JOIN 
    raw_data.lease_type lt ON ls.lease_type_id = lt.lease_type_id
GROUP BY 
    d.district_name, bt.building_type, ys.year, lt.lease_type
ORDER BY 
    d.district_name, bt.building_type, ys.year, lt.lease_type;
