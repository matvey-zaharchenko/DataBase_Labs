-- ЗАПРОС 1. 
-- Находит автомобили, у которых завершённых аренд больше, чем в среднем у автомобилей той же категории.
-- car_counts — количество аренд каждого автомобиля.
-- category_avg — среднее количество аренд по категории.
WITH car_counts AS (
    SELECT
        ca.car_id,
        ca.government_number,
        m.category,
        COUNT(r.rent_id) AS rentals_count
    FROM cars ca
    JOIN models m
      ON m.model_id = ca.model_id
    LEFT JOIN rentals r
      ON r.car_id = ca.car_id
     AND r.status = 'completed'
    GROUP BY ca.car_id, ca.government_number, m.category
),
category_avg AS (
    SELECT
        category,
        AVG(rentals_count) AS avg_rentals
    FROM car_counts
    GROUP BY category
)
SELECT
    c.car_id,
    c.government_number,
    c.category,
    c.rentals_count,
    ROUND(a.avg_rentals, 2) AS category_avg
FROM car_counts c
JOIN category_avg a
  ON a.category = c.category
WHERE c.rentals_count > a.avg_rentals
ORDER BY c.category, c.rentals_count DESC;

-- ЗАПРОС 2. EXISTS: есть хотя бы одна подходящая связанная запись.
-- Находит клиентов, у которых есть хотя бы одна завершённая аренда с рейтингом не ниже 4.5.
SELECT
    c.client_id,
    c.surname || ' ' || c.name AS client,
    c.phone_number
FROM clients c
WHERE EXISTS (
    SELECT 1
    FROM rentals r
    WHERE r.client_id = c.client_id
      AND r.status = 'completed'
      AND r.rating >= 4.5
)
ORDER BY c.client_id;

-- ЗАПРОС 3.
-- Найти клиентов, у которых нет ни одной завершённой аренды.
SELECT
    c.client_id,
    c.surname || ' ' || c.name AS client,
    c.phone_number
FROM clients c
WHERE NOT EXISTS (
    SELECT 1
    FROM rentals r
    WHERE r.client_id = c.client_id
      AND r.status = 'completed'
)
ORDER BY c.client_id;

-- ЗАПРОС 4. 
-- Для каждого автомобиля считает количество завершённых аренд и сумму выручки.
SELECT
    ca.car_id,
    ca.government_number,
    m.mark,
    m.model,
    m.category,
    (
        SELECT COUNT(*)
        FROM rentals r
        WHERE r.car_id = ca.car_id
          AND r.status = 'completed'
    ) AS completed_rentals,
    (
        SELECT COALESCE(SUM(r.total_cost), 0)
        FROM rentals r
        WHERE r.car_id = ca.car_id
          AND r.status = 'completed'
    ) AS revenue
FROM cars ca
JOIN models m
  ON m.model_id = ca.model_id
ORDER BY ca.car_id;
