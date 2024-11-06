SELECT
    y.year,
    bt.building_type,
    ROUND(AVG(ls.deposit)) AS deposit_avg,
    ROUND(AVG(ls.rent) * 12) AS rent_avg,
    ROUND(AVG(way.avg_wage) * 12 / 10000) AS wage_avg
FROM
    raw_data.lease_sales ls
JOIN
    raw_data.year y ON ls.contract_year_id = y.year_id
JOIN
    raw_data.wage_age_year way ON y.year_id = way.year_id
join
    raw_data.building_type bt on ls.building_type_id = bt.building_type_id
WHERE
    ls.lease_type_id = 2
GROUP BY
    y.year, bt.building_type
ORDER BY
    y.year;
