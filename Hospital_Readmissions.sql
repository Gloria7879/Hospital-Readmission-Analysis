-- Project: Hospital Readmission Risk Analysis
-- Purpose: Cleaning raw Kaggle data for Tablaeu visualization
-- Author: Gloria

-- Data Cleaning


-- 1. Remove Duplicates
-- 2. Standardize Data
-- 3. Null Values or blank values
-- 4. Remove any columns



CREATE TABLE hospital_readmissions_staging
LIKE hospital_readmissions;

SELECT *
FROM hospital_readmissions_staging;

INSERT hospital_readmissions_staging
SELECT *
FROM hospital_readmissions;

SELECT *,
ROW_NUMBER() OVER(
PARTITION BY patient_id, age, gender, blood_pressure, cholesterol , bmi, diabetes, hypertension, medication_count, length_of_stay, discharge_destination, readmitted_30_days) AS row_num
FROM hospital_readmissions_staging;

WITH duplicate_cte AS
( 
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY patient_id, age, gender, blood_pressure, cholesterol , bmi, diabetes, hypertension, medication_count, length_of_stay, discharge_destination, readmitted_30_days) AS row_num
FROM hospital_readmissions_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

CREATE TABLE `hospital_readmissions_staging2` (
  `patient_id` int DEFAULT NULL,
  `age` int DEFAULT NULL,
  `gender` text,
  `blood_pressure` text,
  `cholesterol` int DEFAULT NULL,
  `bmi` double DEFAULT NULL,
  `diabetes` text,
  `hypertension` text,
  `medication_count` int DEFAULT NULL,
  `length_of_stay` int DEFAULT NULL,
  `discharge_destination` text,
  `readmitted_30_days` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM hospital_readmissions_staging2;

-- Standardizing Data

SELECT DISTINCT patient_id
FROM hospital_readmissions_staging2;


INSERT INTO hospital_readmissions_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY patient_id, age, gender, blood_pressure, cholesterol , bmi, diabetes, hypertension, medication_count, length_of_stay, discharge_destination, readmitted_30_days) AS row_num
FROM hospital_readmissions_staging;

SELECT DISTINCT age
FROM hospital_readmissions_staging2
ORDER BY 1;

SELECT *
FROM hospital_readmissions_staging2;

SELECT DISTINCT cholesterol
FROM hospital_readmissions_staging2;

SELECT DISTINCT bmi
FROM hospital_readmissions_staging2
ORDER BY 1;

SELECT * 
FROM hospital_readmissions_staging2;

SELECT DISTINCT gender
FROM hospital_readmissions_staging2;

SELECT DISTINCT blood_pressure, age, hypertension
FROM hospital_readmissions_staging2
WHERE blood_pressure > 120
ORDER BY 1 ;

SELECT DISTINCT diabetes
FROM hospital_readmissions_staging2;

SELECT DISTINCT hypertension
FROM hospital_readmissions_staging2;


SELECT DISTINCT medication_count
FROM hospital_readmissions_staging2;

SELECT distinct length_of_stay
FROM hospital_readmissions_staging2;

SELECT distinct discharge_destination
FROM hospital_readmissions_staging2;

SELECT distinct readmitted_30_days
FROM hospital_readmissions_staging2;

SELECT *
FROM hospital_readmissions_staging2
WHERE readmitted_30_days IS NULL;

-- Performed similar checks to all other columns

SELECT *
FROM hospital_readmissions_staging2;

ALTER TABLE hospital_readmissions_staging2
DROP COLUMN row_num;


SELECT * 
FROM hospital_readmissions_staging2;

-- Data Quality Check

SELECT MAX(age), MAX(blood_pressure), MAX(BMI), MAX(cholesterol)
FROM hospital_readmissions_staging2;

SELECT MIN(age), MIN(blood_pressure), MIN(BMI), MIN(cholesterol)
FROM hospital_readmissions_staging2;

SELECT AVG (length_of_stay)
FROM hospital_readmissions_staging2;

SELECT MAX(length_of_stay)
FROM hospital_readmissions_staging2;

SELECT MIN(length_of_stay)
FROM hospital_readmissions_staging2;

SELECT COUNT(*)
FROM hospital_readmissions_staging2
WHERE readmitted_30_days = 'Yes';

SELECT DISTINCT medication_count
FROM hospital_readmissions_staging2;


