-- ЗАПРОС 1. Количество и суммы по группам.
-- Для каждой категории автомобилей и каждого состояния аренды считает число аренд, сумму выручки и средний чек.
SELECT
    m.category,
    r.status,
    COUNT(*) AS rentals_count,
    SUM(r.total_cost) AS revenue,
    ROUND(AVG(r.total_cost), 0) AS avg_check
FROM rentals r
JOIN cars ca
  ON ca.car_id = r.car_id
JOIN models m
  ON m.model_id = ca.model_id
GROUP BY m.category, r.status
ORDER BY m.category, r.status;

-- ЗАПРОС 2. Группы с фильтрацией через HAVING.
-- Оставляет только категории, у которых завершённые аренды дали выручку не менее 100000 и средний рейтинг не ниже 4.0.
SELECT
    m.category,
    COUNT(*) AS completed_rentals,
    SUM(r.total_cost) AS revenue,
    ROUND(AVG(r.total_cost), 0) AS avg_check,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    MIN(r.rating) AS min_rating,
    MAX(r.rating) AS max_rating
FROM rentals r
JOIN cars ca
  ON ca.car_id = r.car_id
JOIN models m
  ON m.model_id = ca.model_id
WHERE r.status = 'completed'
GROUP BY m.category
HAVING SUM(r.total_cost) >= 100000
   AND AVG(r.rating) >= 4.0
ORDER BY revenue DESC;

-- ЗАПРОС 3. Сравнение категорий между собой.
-- Считает выручку каждой категории и показывает, какую долю в процентах она занимает в общей выручке по завершённым арендам
SELECT
    m.category,
    COUNT(*) AS completed_rentals,
    SUM(r.total_cost) AS revenue,
    ROUND(AVG(r.total_cost), 0) AS avg_check,
    ROUND(
        100.0 * SUM(r.total_cost)
        / (SELECT SUM(total_cost)
           FROM rentals
           WHERE status = 'completed'),
        1
    ) AS revenue_share_percent
FROM rentals r
JOIN cars ca
  ON ca.car_id = r.car_id
JOIN models m
  ON m.model_id = ca.model_id
WHERE r.status = 'completed'
GROUP BY m.category
ORDER BY revenue DESC;
