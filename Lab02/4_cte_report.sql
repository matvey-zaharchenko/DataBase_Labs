--   С помощью CTE построить аналитический отчёт по категориям автомобилей:
--   сколько машин, сколько аренд, какая выручка, загрузка и рейтинг.
--
-- Содержательный вопрос:
-- Какая категория автомобилей приносит больше всего выручки и насколько эффективно используется её автопарк?»
--
-- Схема вычислений:
--   Исходные данные (models + cars + rentals) =>
--   => base  — все категории, автомобили и их аренды =>
--   => stats — агрегаты по каждой категории =>
--   => Итоговый отчёт: доли, загрузка, выручка на автомобиль, место категории


WITH base AS (
    SELECT
        m.category,
        ca.car_id,
        r.rent_id,
        r.status,
        r.total_cost,
        r.rating
    FROM models m
    LEFT JOIN cars ca
      ON ca.model_id = m.model_id
    LEFT JOIN rentals r
      ON r.car_id = ca.car_id
),
stats AS (
    SELECT
        category,
        COUNT(DISTINCT car_id) AS cars_total,
        COUNT(DISTINCT car_id) FILTER (WHERE status = 'completed')
            AS cars_with_rentals,
        COUNT(*) FILTER (WHERE status = 'completed') AS completed_rentals,
        COUNT(*) FILTER (WHERE status = 'cancelled') AS cancelled_rentals,
        COALESCE(SUM(total_cost) FILTER (WHERE status = 'completed'), 0)
            AS revenue,
        ROUND(AVG(total_cost) FILTER (WHERE status = 'completed'), 0)
            AS avg_check,
        ROUND(AVG(rating) FILTER (WHERE status = 'completed' AND rating IS NOT NULL), 2)
            AS avg_rating
    FROM base
    GROUP BY category
)

SELECT
    category,
    cars_total,
    cars_with_rentals,
    ROUND(100.0 * cars_with_rentals / NULLIF(cars_total, 0), 1)
        AS utilization_percent,
    completed_rentals,
    cancelled_rentals,
    revenue,
    ROUND(100.0 * revenue / (SELECT SUM(revenue) FROM stats), 1)
        AS revenue_share_percent,
    ROUND(revenue::numeric / NULLIF(cars_total, 0), 0)
        AS revenue_per_car,
    avg_check,
    avg_rating,
    ROUND(
        100.0 * cancelled_rentals
        / NULLIF(completed_rentals + cancelled_rentals, 0),
        1
    ) AS cancellation_percent,
    RANK() OVER (ORDER BY revenue DESC) AS revenue_rank
FROM stats
ORDER BY revenue DESC;
