\set ON_ERROR_STOP on

\echo '>>> Расширение схемы'
\i extend_schema.sql

\echo '>>> 1.1. Формирование содержательного набора данных'
\i 11_seed_data.sql

\echo '>>> 1.2. Операции DML'
\i 12_dml_operations.sql

\echo '>>> 2.1. Многотабличные запросы (JOIN)'
\i 21_join_queries.sql

\echo '>>> 2.2. Агрегация и группировка'
\i 22_aggregation_queries.sql

\echo '>>> 3. Подзапросы'
\i 3_subqueries.sql

\echo '>>> 4. Комплексный отчёт с CTE'
\i 4_cte_report.sql

