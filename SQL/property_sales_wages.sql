WITH sales_data AS (
    SELECT 
        y.year,
        d.district_code,
        d.district_name,
        b.building_type,
        ROUND(AVG(ps.price / (ps.lease_area / 3.305))) AS avg_price_per_pyeong
    FROM 
        raw_data.property_sales ps
    JOIN 
        raw_data.district d ON ps.district_id = d.district_id
    JOIN 
        raw_data.year y ON ps.contract_year_id = y.year_id
    JOIN 
        raw_data.building_type b ON ps.building_type_id = b.building_type_id
    GROUP BY 
        y.year, d.district_code, d.district_name, b.building_type
),
jeonse_data AS (
    SELECT 
        y.year,
        d.district_code,
        d.district_name,
        b.building_type,
        ROUND(AVG(ls.deposit / (ls.lease_area / 3.305))) AS avg_jeonse_price_per_pyeong
    FROM 
        raw_data.lease_sales ls
    JOIN 
        raw_data.district d ON ls.district_id = d.district_id
    JOIN 
        raw_data.year y ON ls.contract_year_id = y.year_id
    JOIN 
        raw_data.building_type b ON ls.building_type_id = b.building_type_id
    JOIN 
        raw_data.lease_type lt ON ls.lease_type_id = lt.lease_type_id
    WHERE 
        lt.lease_type = '전세'
    GROUP BY 
        y.year, d.district_code, d.district_name, b.building_type
),
wage_data AS (
    SELECT 
        y.year,
        CASE 
            WHEN w.age = '19세이하' THEN '19세 이하'
            WHEN w.age IN ('20~24세', '25~29세') THEN '20대'
            WHEN w.age IN ('30~34세', '35~39세') THEN '30대'
            WHEN w.age IN ('40~44세', '45~49세') THEN '40대'
            WHEN w.age IN ('50~54세', '55~59세') THEN '50대'
            ELSE '60세 이상'
        END AS age_group,
        ROUND(AVG(w.avg_wage)) AS average_wage
    FROM 
        raw_data.wage_age_year w
    JOIN 
        raw_data.year y ON w.year_id = y.year_id
    GROUP BY 
        y.year, age_group
)
SELECT
    s.year,
    s.district_name,
    s.building_type,
    s.avg_price_per_pyeong,
    j.avg_jeonse_price_per_pyeong,
    w.age_group,
    w.average_wage
FROM 
    sales_data s
LEFT JOIN 
    jeonse_data j ON s.year = j.year AND s.district_code = j.district_code AND s.building_type = j.building_type
LEFT JOIN 
    wage_data w ON s.year = w.year
where 
	s.year < 2024
ORDER BY 
    s.year, w.age_group;
