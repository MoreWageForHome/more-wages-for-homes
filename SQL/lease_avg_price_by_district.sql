SELECT 
    d.district_name,
    ROUND(AVG(
        CASE 
            WHEN lt.lease_type = '전세' THEN ls.deposit / ls.lease_area / 3.305
            ELSE NULL
        END
    )) AS avg_price_per_pyeong
FROM 
    raw_data.district d
LEFT JOIN 
    raw_data.lease_sales ls ON d.district_id = ls.district_id
LEFT JOIN `
    raw_data.lease_type lt ON ls.lease_type_id = lt.lease_type_id
WHERE 
    lt.lease_type = '전세'
GROUP BY 
    d.district_name
ORDER BY 
    avg_price_per_pyeong DESC;
