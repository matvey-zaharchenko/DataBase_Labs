
-- ЗАПРОС 1
-- Показывает, кто арендовал какой автомобиль, к какой категории он относится, на какие даты и в каком состоянии находится аренда.
SELECT
    r.rent_id,
    c.surname || ' ' || c.name AS client,
    c.phone_number,
    ca.government_number,
    m.mark,
    m.model,
    m.category,
    r.start_date,
    r.end_date,
    r.total_cost,
    r.rating,
    r.status
FROM rentals r
JOIN clients c  ON c.client_id = r.client_id
JOIN cars ca    ON ca.car_id = r.car_id
JOIN models m   ON m.model_id = ca.model_id
ORDER BY r.rent_id;

-- ЗАПРОС 2. Автомобили без аренд (LEFT JOIN).
-- Найходит автомобили, которые ни разу не сдавались в аренду.
SELECT
    ca.car_id,
    ca.government_number,
    m.mark,
    m.model,
    m.category
FROM cars ca
JOIN models m
  ON m.model_id = ca.model_id
LEFT JOIN rentals r
  ON r.car_id = ca.car_id
WHERE r.rent_id IS NULL
ORDER BY ca.car_id;

-- ЗАПРОС 3.
-- Условие (кратко):
-- Находит клиентов со стажем не менее 5 лет, которые завершили аренду бизнес- или премиум-автомобиля с рейтингом не ниже 4.5 и стоимостью не менее 50 000.

SELECT DISTINCT
    c.client_id,
    c.surname || ' ' || c.name AS client,
    c.driving_expirience AS experience_years
FROM clients c
JOIN rentals r  ON r.client_id = c.client_id
JOIN cars ca    ON ca.car_id = r.car_id
JOIN models m   ON m.model_id = ca.model_id
WHERE c.driving_expirience >= 5
  AND m.category IN ('Бизнес', 'Премиум')
  AND r.status = 'completed'
  AND r.rating >= 4.5
  AND r.total_cost >= 50000
ORDER BY c.client_id;
