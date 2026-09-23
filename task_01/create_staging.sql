DROP DATABASE IF EXISTS stagingDB;

CREATE DATABASE IF NOT EXISTS stagingDB;

USE stagingDB;

CREATE TABLE IF NOT EXISTS HISTORICAL_EVENTS (
  year            SMALLINT,
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3)',
  country_name    VARCHAR(255) COMMENT 'English country name',
  event           VARCHAR(255) COMMENT 'Major event(s) that took place in the country during the year',
  category        VARCHAR(255),
  economic_impact VARCHAR(255),
  PRIMARY KEY (year, iso3, event)
);

CREATE TABLE IF NOT EXISTS MADDISON_INDICATORS (
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3)',
  country_name    VARCHAR(255) COMMENT 'English country name',
  indicator_code  VARCHAR(255),
  indicator_name  VARCHAR(255),
  year            SMALLINT,
  value           DOUBLE,
  PRIMARY KEY (iso3, indicator_code, year)
);

CREATE TABLE IF NOT EXISTS WDI_INDICATORS (
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3)',
  country_name    VARCHAR(255) COMMENT 'English country name',
  indicator_code  VARCHAR(255),
  indicator_name  VARCHAR(255),
  year            SMALLINT,
  value           DOUBLE,
  PRIMARY KEY (iso3, indicator_code, year)
);

CREATE TABLE IF NOT EXISTS COUNTRY_MAPPING (
  iso3          CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3)',
  country_name  VARCHAR(255) COMMENT 'English country name',
  country_group VARCHAR(255),
  PRIMARY KEY (iso3)
);
