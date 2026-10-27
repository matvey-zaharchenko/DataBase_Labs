-- 1 Задание
BEGIN;
-- для повторного запуска скрипта для демонстрации работы дмл удаляем конкретного клиента
DELETE FROM clients WHERE phone_number = '+79261234567';


INSERT INTO clients
    (client_id, name, surname, phone_number, driving_expirience,
     passport_series, passport_number)
VALUES
    (21, 'Иван', 'Новиков', '+79261234567', 9, '4600', '112233');

INSERT INTO rentals
    (rent_id, client_id, car_id, rating, start_date, end_date,
     total_cost, status)
VALUES
    (41, 21, 1, NULL, '2026-11-01', '2026-11-05', 22000, 'created'),
    (42, 21, 5, NULL, '2026-12-01', '2026-12-03',  4200, 'created');

COMMIT;

-- Сдвигаем последовательности после вставки явных id.
SELECT setval('clients_client_id_seq', (SELECT MAX(client_id) FROM clients));
SELECT setval('rentals_rent_id_seq', (SELECT MAX(rent_id) FROM rentals));

-- 2 Задание
UPDATE rentals
SET status = 'active'
WHERE rent_id = 41;

-- 3 Задание
UPDATE rentals
SET status = 'active'
WHERE rent_id IN (35, 36);

-- 4 Задание
DELETE FROM cars
WHERE car_id = 19;

-- 5 Задание
BEGIN;

DELETE FROM rentals
WHERE status = 'created';

ROLLBACK;
