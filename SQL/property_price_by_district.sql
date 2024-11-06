SELECT 
    y.year,
    d.district_code,
    d.district_name,
    COUNT(ps.property_sales_id) AS transaction_count,
    ROUND(AVG(ps.price)) AS average_price,
    b.building_type
FROM 
    raw_data.property_sales ps
JOIN 
    raw_data.district d ON ps.district_id = d.district_id
JOIN
    raw_data.year y ON ps.contract_year_id = y.year_id
JOIN
    raw_data.building_type b ON ps.building_type_id = b.building_type_id
GROUP BY 
    y.year, d.district_name, d.district_code, b.building_type
ORDER BY 
    y.year, d.district_name;
