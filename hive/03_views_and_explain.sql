--Pour répondre aux exigences de "Vues métiers" et "Explain".
USE energy_db;

--creation de la vue pour la consommation moyenne par type de bâtiment par jour
CREATE VIEW IF NOT EXISTS view_daily_consumption AS
SELECT building_id, date(`timestamp`) as day, AVG(meter_reading) as avg_consumption
FROM managed_meter_readings
GROUP BY building_id, date(`timestamp`);

-- Commande EXPLAIN pour le rapport 
EXPLAIN SELECT * FROM view_daily_consumption WHERE building_id = 0;

--Création d'une Vue Matérialisée 
-- Stocke physiquement les agrégations pour booster les performances des dashboards
CREATE MATERIALIZED VIEW IF NOT EXISTS mv_conso_par_usage 
AS 
SELECT 
    primary_use, 
    SUM(meter_reading) as total 
FROM vue_metier_complete 
GROUP BY primary_use;

-- Mécanisme de rafraîchissement de la vue matérialisée
ALTER MATERIALIZED VIEW mv_conso_par_usage REBUILD;

-- Analyse des performances 
-- Commande EXPLAIN pour valider l'optimisation des requêtes par le moteur Tez
EXPLAIN SELECT * FROM view_daily_consumption WHERE building_id = 0;
