-- 1. Creating the database
CREATE DATABASE terrorism_analysis;

-- 2. Creating the table
CREATE TABLE terrorism_data (
    event_id INT PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    country TEXT,
    region TEXT,
    city TEXT,
    latitude FLOAT,
    longitude FLOAT,
    attack_type TEXT,
    target_type TEXT,
    target_subtype TEXT,
    nationality TEXT,
    motive TEXT,
    weapon_type TEXT,
    weapon_subtype TEXT,
    num_killed INT,
    num_wounded INT,
    summary TEXT
);

-- 3. Loading the data into the table
COPY terrorism_data
FROM 'D:\project\Book2.csv'
DELIMITER ',' 
CSV HEADER;

-- 4. Data Cleaning

-- (a) Checking for missing values
SELECT COUNT(*) AS missing_values
FROM terrorism_data
WHERE year IS NULL
   OR month IS NULL
   OR day IS NULL
   OR country IS NULL
   OR region IS NULL
   OR city IS NULL;

-- (b) Remove records with missing values
DELETE FROM terrorism_data
WHERE year IS NULL
   OR month IS NULL
   OR day IS NULL
   OR country IS NULL
   OR region IS NULL
   OR city IS NULL;

-- (c) Ensure consistent data formats
UPDATE terrorism_data
SET country = LOWER(country),
    region = LOWER(region),
    city = LOWER(city),
    attack_type = LOWER(attack_type),
    target_type = LOWER(target_type),
    weapon_type = LOWER(weapon_type);

-- 5. SQL Queries

-- (a) Total number of attacks
SELECT COUNT(*) AS total_attacks
FROM terrorism_data;

-- (b) Total number of casualties
SELECT SUM(num_killed + num_wounded) AS total_casualties
FROM terrorism_data;

-- (c) Number of Attacks per Year
SELECT year, COUNT(*) AS attacks
FROM terrorism_data
GROUP BY year
ORDER BY year;

-- (d) Most Common Attack Type
SELECT attack_type, COUNT(*) AS count
FROM terrorism_data
GROUP BY attack_type
ORDER BY count DESC
LIMIT 1;

-- (e) Top 10 Countries with Most Attacks
SELECT country, COUNT(*) AS attacks
FROM terrorism_data
GROUP BY country
ORDER BY attacks DESC
LIMIT 10;

-- (f) Monthly Distribution of Attacks
SELECT month, COUNT(*) AS attacks
FROM terrorism_data
GROUP BY month
ORDER BY month;

-- (g) Yearly Casualties by Region
SELECT year, region, SUM(num_killed + num_wounded) AS casualties
FROM terrorism_data
GROUP BY year, region
ORDER BY year, region;

-- (h) Top 5 Weapon Types Used
SELECT weapon_type, COUNT(*) AS count
FROM terrorism_data
GROUP BY weapon_type
ORDER BY count DESC
LIMIT 5;

-- (i) Attacks on Different Target Types
SELECT target_type, COUNT(*) AS count
FROM terrorism_data
GROUP BY target_type
ORDER BY count DESC;

-- (j) Geographical Distribution of Attacks
SELECT country, latitude, longitude, COUNT(*) AS attacks
FROM terrorism_data
GROUP BY country, latitude, longitude
ORDER BY attacks DESC;

-- (k) Temporal Analysis of Attacks
SELECT year, month, day, COUNT(*) AS attacks
FROM terrorism_data
GROUP BY year, month, day
ORDER BY year, month, day;