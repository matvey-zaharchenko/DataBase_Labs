SELECT 
    m.model_id, 
    m.mark, 
    m.model,
    COUNT(r.rent_id) AS rents_count,
    COUNT(DISTINCT r.client_id) AS unique_clients,
    ROUND(AVG(r.total_cost), 2) AS rents_avg_cost,
    ROUND(AVG(rating), 2) AS avg_rating
FROM models AS m
LEFT JOIN cars AS c
    ON c.model_id = m.model_id
LEFT JOIN rentals AS r 
    ON r.car_id = c.car_id
WHERE r.status = 'completed'
GROUP BY m.model_id
ORDER BY rents_avg_cost ASC;