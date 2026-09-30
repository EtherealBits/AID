DROP DATABASE IF EXISTS stagingDB;

CREATE DATABASE IF NOT EXISTS stagingDB;

USE stagingDB;

CREATE TABLE IF NOT EXISTS HISTORICAL_EVENTS (
  year            SMALLINT COMMENT 'Year in which the event(s) occurred',
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3) identifying the country associated with the event(s)',
  country_name    VARCHAR(255) COMMENT 'English country name corresponding to the ISO3 code',
  event           VARCHAR(255) COMMENT 'Description of historical event(s)',
  category        VARCHAR(255) COMMENT 'Category/classification of the event(s)',
  economic_impact VARCHAR(255) COMMENT 'Qualitative description/classification of the economic impact of the event(s)',
  PRIMARY KEY (year, iso3, event)
);

CREATE TABLE IF NOT EXISTS MADDISON_INDICATORS (
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3) identifying the country associated with the indicator',
  country_name    VARCHAR(255) COMMENT 'English country name corresponding to the ISO3 code',
  indicator_code  VARCHAR(255) COMMENT 'Code identifying the Maddison indicator',
  indicator_name  VARCHAR(255) COMMENT 'Human-readable Maddison indicator description',
  year            SMALLINT COMMENT 'Observation year',
  value           DOUBLE COMMENT 'Indicator value; units depend on the indicator',
  PRIMARY KEY (iso3, indicator_code, year)
);

CREATE TABLE IF NOT EXISTS WDI_INDICATORS (
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3) identifying the country associated with the indicator',
  country_name    VARCHAR(255) COMMENT 'English country name corresponding to the ISO3 code',
  indicator_code  VARCHAR(255) COMMENT 'World Bank WDI indicator code',
  indicator_name  VARCHAR(255) COMMENT 'Human-readable WDI indicator description',
  year            SMALLINT COMMENT 'Observation year',
  value           DOUBLE COMMENT 'Indicator value; units depend on the indicator',
  PRIMARY KEY (iso3, indicator_code, year)
);

CREATE TABLE IF NOT EXISTS COUNTRY_MAPPING (
  iso3          CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3) identifying the country',
  country_name  VARCHAR(255) COMMENT 'English country name corresponding to the ISO3 code',
  country_group VARCHAR(255) COMMENT 'Country group to which the country belongs',
  PRIMARY KEY (iso3)
);
