SELECT 
    d.district_name,
    ROUND(AVG(ps.price / ps.lease_area / 3.305,)) AS avg_price_per_pyeong
FROM 
    raw_data.district d
LEFT JOIN 
    raw_data.property_sales ps ON d.district_id = ps.district_id
GROUP BY 
    d.district_name
ORDER BY 
    avg_price_per_pyeong DESC;
