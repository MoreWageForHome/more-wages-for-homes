WITH
transaction_counts AS (
    SELECT 
        yr.year AS year,
        CASE 
            WHEN y.year BETWEEN 2020 AND 2024 THEN '2020-2024'
            WHEN y.year BETWEEN 2010 AND 2019 THEN '2010-2019'
            WHEN y.year BETWEEN 2000 AND 2009 THEN '2000-2009'
            WHEN y.year < 2000 THEN '2000년도 이전'
        END AS year_range,
        bt.building_type,
        COUNT(ps.property_sales_id) AS property_transaction_count
    FROM 
        raw_data.property_sales ps
    JOIN 
        raw_data.year y ON ps.construct_year_id = y.year_id
    JOIN 
        raw_data.year yr ON ps.contract_year_id = yr.year_id
    JOIN
    	raw_data.building_type bt on bt.building_type_id = ps.building_type_id
    GROUP BY 
        year_range, yr.year, bt.building_type
)
SELECT 
    tc.year AS year,
    tc.year_range,
    tc.property_transaction_count,
    tc.building_type
FROM 
    transaction_counts tc
ORDER BY 
    tc.year_range, tc.year;
