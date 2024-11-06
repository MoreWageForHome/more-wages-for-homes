SELECT
    way.age,
    way.avg_wage,
    y.year
FROM
    raw_data.wage_age_year way
  JOIN
    raw_data.year y
ON way.year_id = y.year_id
ORDER BY substring(way.age, 1, 2)::numeric asc;
