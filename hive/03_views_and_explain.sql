--Pour répondre aux exigences de "Vues métiers" et "Explain".
USE energy_db;

-- Création d'une vue métier : Consommation moyenne par type de bâtiment
CREATE VIEW IF NOT EXISTS view_avg_consumption AS
SELECT b.primary_use, AVG(m.meter_reading) as avg_reading
FROM managed_meter_readings m
JOIN ext_building_metadata b ON m.building_id = b.building_id
GROUP BY b.primary_use;

-- Commande EXPLAIN pour le rapport (à exécuter et screener demain)
EXPLAIN SELECT * FROM view_avg_consumption WHERE avg_reading > 100;