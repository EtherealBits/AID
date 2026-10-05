-- HISTORICAL_EVENTS

-- row counts
SELECT COUNT(*) AS num_rows
FROM HISTORICAL_EVENTS;

-- number of countries
SELECT COUNT(DISTINCT country_name) AS num_countries
FROM HISTORICAL_EVENTS;

-- number of years
SELECT COUNT(DISTINCT year) AS num_years
FROM HISTORICAL_EVENTS;

-- year span
SELECT MIN(year) AS min_year, MAX(year) AS max_year
FROM HISTORICAL_EVENTS;

-- years with events
SELECT DISTINCT year
FROM HISTORICAL_EVENTS
ORDER BY year;

-- years with no events
WITH RECURSIVE years AS (
  SELECT (SELECT MIN(year) FROM HISTORICAL_EVENTS) AS year
  UNION ALL
  SELECT year + 1
  FROM years
  WHERE year < (SELECT MAX(year) FROM HISTORICAL_EVENTS)
)
SELECT year AS years_without_events
FROM years
WHERE year NOT IN (
  SELECT DISTINCT year
  FROM HISTORICAL_EVENTS
);

-- distinct countries
SELECT DISTINCT country_name
FROM HISTORICAL_EVENTS
ORDER BY country_name;

-- missing values
SELECT *
FROM HISTORICAL_EVENTS
WHERE year IS NULL OR year = 0
  OR iso3 IS NULL OR iso3 = ''
  OR country_name IS NULL OR country_name = ''
  OR event IS NULL OR event = ''
  OR category IS NULL OR category = ''
  OR economic_impact IS NULL OR economic_impact = '';

-- eventful years (useful to look for major events spanning multiple countries)
SELECT year, COUNT(*) AS num_events
FROM HISTORICAL_EVENTS
GROUP BY year
HAVING num_events > 6;

-- categories describing a high number of events
SELECT category, COUNT(*) AS num_events
FROM HISTORICAL_EVENTS
GROUP BY category
HAVING num_events >= 20
ORDER BY num_events DESC;


-- WDI_INDICATORS

-- units of measurement
SELECT DISTINCT indicator_name, indicator_code
FROM WDI_INDICATORS
ORDER BY indicator_name;

-- row counts
SELECT COUNT(*) AS num_rows
FROM WDI_INDICATORS;

-- number of countries
SELECT COUNT(DISTINCT country_name) AS num_countries
FROM WDI_INDICATORS;

-- number of years
SELECT COUNT(DISTINCT year) AS num_years
FROM WDI_INDICATORS;

-- number of indicators
SELECT COUNT(DISTINCT indicator_code) AS num_indicators
FROM WDI_INDICATORS;

-- year span
SELECT MIN(year) AS min_year, MAX(year) AS max_year
FROM WDI_INDICATORS;

-- distinct countries
SELECT DISTINCT country_name
FROM WDI_INDICATORS
ORDER BY country_name;

-- start and end year of each indicator in each country
SELECT country_name, indicator_name, MIN(year), MAX(year)
FROM WDI_INDICATORS
GROUP BY country_name, indicator_name
ORDER BY country_name, indicator_name;

-- missing values
SELECT *
FROM WDI_INDICATORS
WHERE iso3 IS NULL OR iso3 = ''
  OR country_name IS NULL OR country_name = ''
  OR indicator_code IS NULL OR indicator_code = ''
  OR indicator_name IS NULL OR indicator_name = ''
  OR year IS NULL OR year = 0
  OR value IS NULL;

-- years with observations
SELECT DISTINCT year
FROM WDI_INDICATORS
ORDER BY year;

-- years with no observations
WITH RECURSIVE years AS (
  SELECT (SELECT MIN(year) FROM WDI_INDICATORS) AS year
  UNION ALL
  SELECT year + 1
  FROM years
  WHERE year < (SELECT MAX(year) FROM WDI_INDICATORS)
)
SELECT year AS years_without_events
FROM years
WHERE year NOT IN (
  SELECT DISTINCT year
  FROM WDI_INDICATORS
);
