SELECT 
    d.district_name,
    bt.building_type,
    ys.year,
    COUNT(ps.property_sales_id) AS property_transaction_count
FROM 
    raw_data.property_sales ps
LEFT JOIN 
    raw_data.district d ON d.district_id = ps.district_id
LEFT JOIN 
    raw_data.building_type bt ON ps.building_type_id = bt.building_type_id
LEFT JOIN 
    raw_data.year ys ON ps.contract_year_id = ys.year_id
GROUP BY 
    d.district_name, bt.building_type, ys.year
ORDER BY 
    d.district_name, bt.building_type, ys.year;
