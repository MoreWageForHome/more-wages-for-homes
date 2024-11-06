SELECT 
    d.district_name,
    y.year,
    bt.building_type,
    CASE 
        WHEN lt.lease_type = '전세' THEN '전세 계약 수'
        WHEN lt.lease_type = '월세' THEN '월세 계약 수'
    END AS "Category",
    COUNT(ls.lease_sales_id) AS transaction_count
FROM 
    raw_data.lease_sales ls
JOIN 
    raw_data.district d ON ls.district_id = d.district_id
JOIN 
    raw_data.lease_type lt ON ls.lease_type_id = lt.lease_type_id
JOIN 
    raw_data.year y ON ls.contract_year_id = y.year_id
join
	raw_data.building_type bt on bt.building_type_id = ls.building_type_id 
GROUP BY 
    d.district_name, y.year, lt.lease_type, bt.building_type
ORDER BY 
    d.district_name, y.year, "Category";
