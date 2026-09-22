DROP DATABASE IF EXISTS stagingDB;

CREATE DATABASE IF NOT EXISTS stagingDB;

USE stagingDB;

-- TODO restrict length based on known values or use VARCHAR(255) ?
-- TODO what to do about the extra column in row 362: ignore ? replace , with ; ?
CREATE TABLE IF NOT EXISTS HISTORICAL_EVENTS (
  year            YEAR,
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3)',
  country_name    VARCHAR(14) COMMENT 'English country name',
  event           VARCHAR(101) COMMENT 'Major event(s) that took place in the country during the year',
  category        VARCHAR(47),
  economic_impact VARCHAR(37),
  PRIMARY KEY (year, iso3)
);

-- TODO restrict length based on known values or use VARCHAR(255) ?
CREATE TABLE IF NOT EXISTS MADDISON_INDICATORS (
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3)',
  country_name    VARCHAR(9) COMMENT 'English country name',
  indicator_code  VARCHAR(5),
  indicator_name  VARCHAR(37),
  year            YEAR,
  value           DOUBLE,
  PRIMARY KEY (iso3, indicator_code, year)
);

-- TODO restrict length based on known values or use VARCHAR(255) ?
-- TODO some indicator names are quoted (""), some aren't
CREATE TABLE IF NOT EXISTS WDI_INDICATORS (
  iso3            CHAR(3) COMMENT 'Three-letter country code (ISO 3166-1 alpha-3)',
  country_name    VARCHAR(14) COMMENT 'English country name',
  indicator_code  VARCHAR(17),
  indicator_name  VARCHAR(72),
  year            YEAR,
  value           DOUBLE,
  PRIMARY KEY (iso3, indicator_code, year)
);
