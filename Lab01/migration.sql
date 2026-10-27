BEGIN;

CREATE TABLE broken_details_info (
    broken_id BIGSERIAL PRIMARY KEY,
    rent_id BIGINT NOT NULL,
    fix_date DATE NOT NULL,
    describe VARCHAR(300),

    CONSTRAINT fk_broken_rent_id FOREIGN KEY (rent_id)
        REFERENCES rentals(rent_id)
        ON DELETE RESTRICT
);

COMMIT;