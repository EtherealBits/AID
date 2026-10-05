DROP DATABASE IF EXISTS datawarehouseDB;

CREATE DATABASE IF NOT EXISTS datawarehouseDB;

USE datawarehouseDB;

CREATE TABLE IF NOT EXISTS DIM_COUNTRY (
  country_id    INT COMMENT 'Surrogate key',
  iso3          CHAR(3)  COMMENT 'Three-letter country code (ISO 3166-1 alpha-3) identifying the country',
  country_name  VARCHAR(255) COMMENT 'English country name corresponding to the ISO3 code',
  country_group VARCHAR(255) COMMENT 'Country group to which the country belongs',
  PRIMARY KEY (country_id)
);

CREATE TABLE IF NOT EXISTS DIM_TIME (
  time_id INT COMMENT 'Surrogate key',
  year    SMALLINT COMMENT 'Year',
  decade  SMALLINT COMMENT 'Decade associated with the year',
  PRIMARY KEY (time_id)
);

CREATE TABLE IF NOT EXISTS DIM_SECTOR (
  sector_id     INT COMMENT 'Surrogate key',
  sector_name   VARCHAR(255) COMMENT 'Name of the sector',
  broad_sector  VARCHAR(255) COMMENT 'Broad sector',
  PRIMARY KEY (sector_id)
);

CREATE TABLE IF NOT EXISTS FACT_ECONOMY (
  country_id      INT COMMENT 'Foreign key to country dimension',
  time_id         INT COMMENT 'Foreign key to time dimension',
  gdp             BIGINT COMMENT 'Gross domestic product; measured in 2011 international dollars',
  gdp_per_capita  DOUBLE COMMENT 'Gross domestic product per capita; measured in 2011 international dollars per person',
  gdp_growth_pct  DOUBLE COMMENT 'Gross domestic product growth; measured in annual percent change of real GDP',
  exports_pct_gdp DOUBLE COMMENT 'Exports of goods and services; measured in percentage of GDP',
  imports_pct_gdp DOUBLE COMMENT 'Imports of goods and services; measured in percentage of GDP',
  PRIMARY KEY (country_id, time_id),
  FOREIGN KEY (country_id) REFERENCES DIM_COUNTRY(country_id),
  FOREIGN KEY (time_id) REFERENCES DIM_TIME(time_id)
);

CREATE TABLE IF NOT EXISTS FACT_SOCIETY (
  country_id      INT COMMENT 'Foreign key to country dimension',
  time_id         INT COMMENT 'Foreign key to time dimension',
  population      DOUBLE COMMENT 'Population (mid-year); measured in thousands of people',
  gni_per_capita  DOUBLE COMMENT 'Gross national income per capita; measured in current US dollars using the Atlas method',
  life_expectancy DOUBLE COMMENT 'Life expectancy at birth; measured in years',
  urban_pop_pct   DOUBLE COMMENT 'Urban population; measured in percentage of total population',
  PRIMARY KEY (country_id, time_id),
  FOREIGN KEY (country_id) REFERENCES DIM_COUNTRY(country_id),
  FOREIGN KEY (time_id) REFERENCES DIM_TIME(time_id)
);

CREATE TABLE IF NOT EXISTS FACT_SECTOR (
  country_id          INT COMMENT 'Foreign key to country dimension',
  time_id             INT COMMENT 'Foreign key to time dimension',
  sector_id           INT COMMENT 'Foreign key to sector dimension',
  value_added_pct_gdp DOUBLE COMMENT 'Value added from given sector; measured in percentage of GDP',
  value_added_usd     DOUBLE COMMENT 'Value added from given sector; measured in current US dollars',
  employment_pct      DOUBLE COMMENT 'Employment in given sector; measured in percentage of total employment',
  PRIMARY KEY (country_id, time_id, sector_id),
  FOREIGN KEY (country_id) REFERENCES DIM_COUNTRY(country_id),
  FOREIGN KEY (time_id) REFERENCES DIM_TIME(time_id),
  FOREIGN KEY (sector_id) REFERENCES DIM_SECTOR(sector_id)
);

CREATE TABLE IF NOT EXISTS BRIDGE_EVENTS (
  event_id        INT COMMENT 'Surrogate key',
  country_id      INT COMMENT 'Foreign key to country dimension',
  time_id         INT COMMENT 'Foreign key to time dimension',
  event           VARCHAR(255) COMMENT 'Description of historical event(s)',
  category        VARCHAR(255) COMMENT 'Category/classification of the event(s)',
  economic_impact VARCHAR(255) COMMENT 'Qualitative description/classification of the economic impact of the event(s)',
  PRIMARY KEY (event_id),
  FOREIGN KEY (country_id) REFERENCES DIM_COUNTRY(country_id),
  FOREIGN KEY (time_id) REFERENCES DIM_TIME(time_id)
);
