TRUNCATE TABLE rentals, model_prices, cars, models, clients RESTART IDENTITY CASCADE;

INSERT INTO clients (name, surname, phone_number, driving_expirience, passport_series, passport_number)
VALUES 
    ('Алексей', 'Смирнов', '+79991112233', 5, '4510', '123456'),
    ('Елена', 'Иванова', '+79992223344', 2, '4512', '654321'),
    ('Дмитрий', 'Кузнецов', '+79993334455', 10, '4005', '789012'),
    ('Мария', 'Попова', '+79994445566', 0, '4518', '345678');

INSERT INTO models (mark, model, category)
VALUES 
    ('Toyota', 'Camry', 'Бизнес'),
    ('Hyundai', 'Solaris', 'Эконом'),
    ('BMW', 'X5', 'Премиум'),
    ('Kia', 'Rio', 'Эконом');


INSERT INTO model_prices (model_id, price, valid_from, valid_to)
VALUES 
    (1, 4500, '2026-01-01', '2026-05-31'),
    (1, 5500, '2026-06-01', '2026-12-31'),
    (2, 2200, '2026-01-01', '2026-12-31'),
    (3, 9000, '2026-01-01', '2026-12-31'),
    (4, 2100, '2026-01-01', '2026-12-31');

INSERT INTO cars (model_id, government_number)
VALUES 
    (1, 'A123BC77'),
    (1, 'M777MM77'),
    (2, 'B456OP199'),
    (3, 'X999XX777'),
    (4, 'C789TK77');

INSERT INTO rentals (client_id, car_id, rating, start_date, end_date, total_cost)
VALUES 
    (1, 1, 4.8, '2026-06-10', '2026-06-15', 27500),
    (2, 3, 5.0, '2026-06-12', '2026-06-14', 4400),
    (3, 4, 4.5, '2026-07-01', '2026-07-10', 90000),
    (4, 3, 0.5, '2026-08-01', '2026-08-03', 4400), 
    (1, 2, 5.0, '2026-08-15', '2026-08-18', 16500);