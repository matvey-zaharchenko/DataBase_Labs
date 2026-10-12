
-- ТЕСТ 1: Нарушение CHECK chk_driving_expirience (отрицательный стаж)
INSERT INTO clients (name, surname, phone_number, driving_expirience, passport_series, passport_number)
VALUES ('Иван', 'Тестовый', '+79990001122', -2, '4500', '111222');

-- ТЕСТ 2: Нарушение составного UNIQUE uq_client_passport (дубликат серии и номера)
INSERT INTO clients (name, surname, phone_number, driving_expirience, passport_series, passport_number)
VALUES ('Петр', 'Дубликатов', '+79998887766', 3, '4510', '123456');

-- ТЕСТ 3: Нарушение CHECK chk_passports_data (неверный формат серии и номера паспорта)
INSERT INTO clients (name, surname, phone_number, driving_expirience, passport_series, passport_number)
VALUES ('Дамир', 'Симонов', '+79990001122', 2, '45ФФ', 'ПУ1222');

-- ТЕСТ 4: Нарушение CHECK chk_phone_number_format (неверный формат номера телефона)
INSERT INTO clients (name, surname, phone_number, driving_expirience, passport_series, passport_number)
VALUES ('Артем', 'Греческий', '+59998887456', 3, '4511', '121256');

-- ТЕСТ 5: Нарушение CHECK chk_price_positive (отрицательная или нулевая цена)
INSERT INTO model_prices (model_id, price, valid_from, valid_to)
VALUES (1, -500, '2026-01-01', '2026-01-10');

-- ТЕСТ 6: Нарушение составного CHECK chk_rental_dates (дата окончания раньше начала)
INSERT INTO rentals (client_id, car_id, rating, start_date, end_date, total_cost)
VALUES (1, 1, 5.0, '2026-06-20', '2026-06-15', 10000);

-- ТЕСТ 7: Нарушение UNIQUE uq_car_government_number (дубликат госномера авто)
INSERT INTO cars (model_id, government_number)
VALUES (2, 'A123BC77');

-- ТЕСТ 8: Нарушение CHECK chk_rental_rating (рейтинг выше 5.0)
INSERT INTO rentals (client_id, car_id, rating, start_date, end_date, total_cost)
VALUES (2, 2, 5.5, '2026-09-01', '2026-09-05', 12000);

-- ТЕСТ 9: Нарушение FOREIGN KEY fk_rentals_cars (ссылка на несуществующую машину)
INSERT INTO rentals (client_id, car_id, rating, start_date, end_date, total_cost)
VALUES (1, 99999, 4.0, '2026-09-01', '2026-09-05', 12000);