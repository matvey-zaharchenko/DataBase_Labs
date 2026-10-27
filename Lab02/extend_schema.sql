BEGIN;

ALTER TABLE rentals
    ADD COLUMN IF NOT EXISTS status VARCHAR(20) NOT NULL DEFAULT 'completed';

ALTER TABLE rentals
    DROP CONSTRAINT IF EXISTS chk_rental_status;

ALTER TABLE rentals
    ADD CONSTRAINT chk_rental_status
    CHECK (status IN ('created', 'active', 'completed', 'cancelled'));

ALTER TABLE models
    DROP CONSTRAINT IF EXISTS chk_models_category;

ALTER TABLE models
    ADD CONSTRAINT chk_models_category
    CHECK (category IN ('Эконом', 'Комфорт', 'Бизнес', 'Премиум'));

COMMIT;
\d rentals
