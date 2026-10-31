-- KAIDA 수입 승용차 신규등록 (2026년 1~9월) — PostgreSQL
DROP TABLE IF EXISTS brand_monthly;
DROP TABLE IF EXISTS monthly_totals;

CREATE TABLE monthly_totals (
    month          DATE PRIMARY KEY,
    total_2026     INTEGER NOT NULL,
    total_2025     INTEGER NOT NULL,
    ev_units_2026  INTEGER            -- 일부 월은 미공개(NULL)
);

CREATE TABLE brand_monthly (
    month  DATE        NOT NULL REFERENCES monthly_totals(month),
    brand  VARCHAR(30) NOT NULL,
    units  INTEGER     NOT NULL,
    PRIMARY KEY (month, brand)
);

-- psql에서 실행:
-- \copy monthly_totals FROM 'kaida_monthly_totals.csv' CSV HEADER NULL ''
-- \copy brand_monthly  FROM 'kaida_brand_monthly.csv'  CSV HEADER
