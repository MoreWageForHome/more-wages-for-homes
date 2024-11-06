WITH area_stats AS (
    SELECT
        MIN(lease_area) / 3.305 AS min_area,
        MAX(lease_area) / 3.305 AS max_area
    FROM
        raw_data.lease_sales
),
range_def AS
    SELECT
        generate_series(1, 10) AS range_id,
        min_area,
        max_area
    FROM
        area_stats
),
ranges AS (
    SELECT
        range_id,
        min_area + (range_id - 1) * ((max_area - min_area) / 10.0) AS range_start,
        min_area + range_id * ((max_area - min_area) / 10.0) AS range_end
    FROM
        range_def
),
lease_counts AS (
    SELECT
        ls.lease_type_id,
        r.range_id,
                y.year,
        COUNT(*) AS lease_count
    FROM
        raw_data.lease_sales ls
    JOIN
        ranges r ON (ls.lease_area / 3.305) >= r.range_start AND (ls.lease_area / 3.3) < r.range_end
        JOIN 
            raw_data.year y ON ls.contract_year_id = y.year_id 
    GROUP BY
        ls.lease_type_id, r.range_id,y.year
)
SELECT
    CONCAT(ROUND(r.range_start, 2), '~', ROUND(r.range_end, 2), '평') AS 평수구간,
    lt.lease_type,
    COALESCE(lc.lease_count, 0) AS lease_count,
    year
FROM
    ranges r
LEFT JOIN
    lease_counts lc ON r.range_id = lc.range_id
LEFT JOIN
    raw_data.lease_type lt ON lc.lease_type_id = lt.lease_type_id
ORDER BY 
    year, r.range_start;
