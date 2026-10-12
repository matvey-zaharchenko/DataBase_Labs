CREATE TABLE clients (
    client_id BIGSERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    surname VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    driving_expirience INT NOT NULL,
    passport_series VARCHAR(4) NOT NULL,
    passport_number VARCHAR(6) NOT NULL,

    CONSTRAINT uq_client_passport UNIQUE (passport_series, passport_number),
    CONSTRAINT uq_phone_number UNIQUE (phone_number),

    CONSTRAINT chk_driving_expirience CHECK (driving_expirience >= 0 AND driving_expirience <= 70),
    CONSTRAINT chk_passports_data CHECK (passport_series ~ '^[0-9]{4}$' AND passport_number ~ '^[0-9]{6}$'),
    CONSTRAINT chk_phone_number_format CHECK (phone_number ~ '^\+7[0-9]{10}$'),
    CONSTRAINT chk_name_and_surname_length CHECK (char_length(name) >= 1 AND char_length(surname) >= 1)
);

CREATE TABLE models (
    model_id BIGSERIAL PRIMARY KEY,
    mark VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    category VARCHAR(30) NOT NULL,

    CONSTRAINT chk_mark_length CHECK (char_length(mark) >= 1),
    CONSTRAINT chk_model_length CHECK (char_length(model) >= 1),
    CONSTRAINT chk_category_length CHECK (char_length(category) >= 1)
);

CREATE TABLE model_prices (
    price_id BIGSERIAL PRIMARY KEY,
    model_id BIGINT NOT NULL,
    price INT NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,

    CONSTRAINT fk_prices_models FOREIGN KEY (model_id) 
        REFERENCES models(model_id) 
        ON DELETE CASCADE,

    CONSTRAINT chk_price_positive CHECK (price > 0),

    CONSTRAINT chk_price_dates CHECK (valid_to >= valid_from)
);

CREATE TABLE cars (
    car_id BIGSERIAL PRIMARY KEY,
    model_id BIGINT NOT NULL,
    government_number VARCHAR(15) NOT NULL,

    CONSTRAINT uq_car_government_number UNIQUE (government_number),

    CONSTRAINT fk_cars_models FOREIGN KEY (model_id) 
        REFERENCES models(model_id) 
        ON DELETE RESTRICT
);

CREATE TABLE rentals (
    rent_id BIGSERIAL PRIMARY KEY,
    client_id BIGINT NOT NULL,
    car_id BIGINT NOT NULL,
    rating DECIMAL(4, 1),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_cost INT NOT NULL,

    CONSTRAINT fk_rentals_clients FOREIGN KEY (client_id) 
        REFERENCES clients(client_id) 
        ON DELETE CASCADE,

    CONSTRAINT fk_rentals_cars FOREIGN KEY (car_id) 
        REFERENCES cars(car_id) 
        ON DELETE RESTRICT,

    CONSTRAINT chk_rental_rating CHECK (rating IS NULL OR (rating >= 0.0 AND rating <= 5.0)),

    CONSTRAINT chk_total_cost CHECK (total_cost >= 0),

    CONSTRAINT chk_rental_dates CHECK (end_date >= start_date)
);