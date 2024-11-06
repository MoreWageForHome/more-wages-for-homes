SELECT
    y.year,
    d.district_code,
    d.district_name,
    COUNT(CASE WHEN lt.lease_type = '전세' THEN ls.lease_sales_id END) AS jeonse_transaction_count,
    ROUND(AVG(CASE WHEN lt.lease_type = '전세' THEN ls.deposit END)) AS average_jeonse_deposit,
    COUNT(CASE WHEN lt.lease_type = '월세' THEN ls.lease_sales_id END) AS month_transaction_count,
    ROUND(AVG(CASE WHEN lt.lease_type = '월세' THEN ls.deposit END)) AS average_month_deposit,
    ROUND(AVG(CASE WHEN lt.lease_type = '월세' THEN ls.rent END)) AS average_month_rent,
    b.building_type
FROM 
    raw_data.lease_sales ls
JOIN 
    raw_data.district d ON ls.district_id = d.district_id
JOIN 
    raw_data.lease_type lt ON ls.lease_type_id = lt.lease_type_id
JOIN
    raw_data.year y ON ls.contract_year_id = y.year_id
JOIN
    raw_data.building_type b ON ps.building_type_id = b.building_type_id
GROUP BY 
    y.year, d.district_name, d.district_code, b.building_type
ORDER BY 
    y.year,d.district_name;
