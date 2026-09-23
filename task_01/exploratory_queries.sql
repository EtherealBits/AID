-- number of countries in historical events
SELECT COUNT(DISTINCT country_name) AS num_countries
FROM HISTORICAL_EVENTS;

-- year range of historical events
SELECT MIN(year) AS min_year, MAX(year) AS max_year
FROM HISTORICAL_EVENTS;

-- distinct countries in historical events
SELECT DISTINCT country_name
FROM HISTORICAL_EVENTS
ORDER BY country_name;