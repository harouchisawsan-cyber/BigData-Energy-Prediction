--Pour répondre aux exigences de "Vues métiers" et "Explain".
USE energy_db;

--creation de la vue pour la consommation moyenne par type de bâtiment par jour
CREATE VIEW IF NOT EXISTS view_daily_consumption AS
SELECT building_id, date(`timestamp`) as day, AVG(meter_reading) as avg_consumption
FROM managed_meter_readings
GROUP BY building_id, date(`timestamp`);

-- Commande EXPLAIN pour le rapport 
EXPLAIN SELECT * FROM view_daily_consumption WHERE building_id = 0;

