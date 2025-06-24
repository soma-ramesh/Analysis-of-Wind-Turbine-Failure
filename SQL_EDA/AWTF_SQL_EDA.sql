-- Create a Database
CREATE DATABASE wt;

-- Activate Database wt
USE wt;

-- Used python for base table creation and data importing

-- Fetch the all records from base table
SELECT * FROM wt_data;

-- Check the number of records in  base table
SELECT COUNT(*) AS "Total_Records" FROM wt_data;

-- Describe the table
DESC wt_data;

----------------------------------------------------------------------------------------------------------------------------------------------
/* Type cast and rename the columns*/
-- date column data type is Text which is to be changed as DATE format and Change the other column names
-- Save the data in a new table called wt_preprocessing as "wt_prep"
CREATE TABLE wt_prep AS 
SELECT
CAST(STR_TO_DATE(date, '%Y-%m-%d') AS DATE) AS Date ,
Wind_speed AS Wind_Speed,
Power AS Power,
Nacelle_ambient_temperature AS Nacelle_Ambient_Temp,
Generator_bearing_temperature AS Generator_Bearing_Temp,
Gear_oil_temperature AS Gea_Oil_Temp,
Ambient_temperature AS Ambient_Temp,
Rotor_Speed AS Rotor_Speed,
Nacelle_temperature AS Nacelle_Temp,
Bearing_temperature AS Bearing_Temp,
Generator_speed AS Generator_Speed,
Yaw_angle AS Yaw_Angle,
Wind_direction AS Wind_Direction,
Wheel_hub_temperature AS Wheel_Hub_Temp,
Gear_box_inlet_temperature Gearbox_Inlet_Temp,
Failure_status As Failure_Status
FROM wt_data;



-- Fetch the data from wt_prep
SELECT * FROM wt_prep;

################################ Exploratory Data Analysis #################################3
# 1. Wind_Speed
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Wind_Speed) AS Avg_Wind_Speed FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Wind_Speed AS  Median_Wind_Speed
FROM(
SELECT Wind_Speed, ROW_NUMBER() OVER(ORDER BY Wind_Speed) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Wind_Speed AS Mode_Wind_Speed FROM(
SELECT Wind_Speed, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Wind_Speed
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Wind_Speed) AS Var_Wind_Speed FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Wind_Speed) AS Std_Wind_Speed FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Wind_Speed) AS Min_Wind_Speed FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Wind_Speed) AS Max_Wind_Speed FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Wind_Speed) - min(Wind_Speed) AS Range_Wind_Speed FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Wind_Speed - (SELECT AVG(Wind_Speed) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Wind_Speed) FROM wt_prep),3))) AS Skewness_Wind_Speed
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Wind_Speed  - (SELECT AVG(Wind_Speed) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Wind_Speed) FROM wt_prep),4))) - 3) AS Kurtosis_Wind_Speed
FROM wt_prep;


-----------------------------------------------------------------------------------------------------------------------------
# 2. Power
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Power) AS Avg_Power FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Power AS  Median_Power
FROM(
SELECT Power, ROW_NUMBER() OVER(ORDER BY Power) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Power AS Mode_Power FROM(
SELECT Power, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Power
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Power) AS Var_Power FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Power) AS Std_Power FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Power) AS Min_Power FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Power) AS Max_Power FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Power) - min(Power) AS Range_Power FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Power - (SELECT AVG(Power) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Power) FROM wt_prep),3))) AS Skewness_Power
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Power  - (SELECT AVG(Power) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Power) FROM wt_prep),4))) - 3) AS Kurtosis_Power
FROM wt_prep;

--------------------------------------------------------------------------------------------------------------------------------------------
# 3. Nacelle_Ambient_Temp
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Nacelle_Ambient_Temp) AS Avg_Nacelle_Ambient_Temp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Nacelle_Ambient_Temp AS  Median_Nacelle_Ambient_Temp
FROM(
SELECT Nacelle_Ambient_Temp, ROW_NUMBER() OVER(ORDER BY Nacelle_Ambient_Temp) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Nacelle_Ambient_Temp AS Mode_Nacelle_Ambient_Temp FROM(
SELECT Nacelle_Ambient_Temp, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Nacelle_Ambient_Temp
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Nacelle_Ambient_Temp) AS Var_Nacelle_Ambient_Temp FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Nacelle_Ambient_Temp) AS Std_Nacelle_Ambient_Temp FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Nacelle_Ambient_Temp) AS Min_Nacelle_Ambient_Temp FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Nacelle_Ambient_Temp) AS Max_Nacelle_Ambient_Temp FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Nacelle_Ambient_Temp) - min(Nacelle_Ambient_Temp) AS Range_Nacelle_Ambient_Temp FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Nacelle_Ambient_Temp - (SELECT AVG(Nacelle_Ambient_Temp) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Nacelle_Ambient_Temp) FROM wt_prep),3))) AS Skewness_Ambient_Temp
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Nacelle_Ambient_Temp  - (SELECT AVG(Nacelle_Ambient_Temp) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Nacelle_Ambient_Temp) FROM wt_prep),4))) - 3) AS Kurtosis_Nacelle_Ambient_Temp
FROM wt_prep;
------------------------------------------------------------------------------------------------------------------------------------

# 4. Generator_Bearing_Temp
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Generator_Bearing_Temp) AS Avg_Generator_Bearing_Temp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Generator_Bearing_Temp AS  Median_Generator_Bearing_Temp
FROM(
SELECT Generator_Bearing_Temp, ROW_NUMBER() OVER(ORDER BY Generator_Bearing_Temp) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Generator_Bearing_Temp AS Mode_Generator_Bearing_Temp FROM(
SELECT Generator_Bearing_Temp, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Generator_Bearing_Temp
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Generator_Bearing_Temp) AS Var_Generator_Bearing_Temp FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Generator_Bearing_Temp) AS Std_Generator_Bearing_Temp FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Generator_Bearing_Temp) AS Min_Generator_Bearing_Temp FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Generator_Bearing_Temp) AS Max_Generator_Bearing_Temp FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Generator_Bearing_Temp) - min(Generator_Bearing_Temp) AS Range_Generator_Bearing_Temp FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Generator_Bearing_Temp - (SELECT AVG(Generator_Bearing_Temp) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Generator_Bearing_Temp) FROM wt_prep),3))) AS Skewness_Generator_Bearing_Temp
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Generator_Bearing_Temp  - (SELECT AVG(Generator_Bearing_Temp) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Generator_Bearing_Temp) FROM wt_prep),4))) - 3) AS Kurtosis_Generator_Bearing_Temp
FROM wt_prep;

------------------------------------------------------------------------------------------------------------------------------------

# 5. Gear_Oil_Temp
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Gear_Oil_Temp) AS Avg_Gear_Oil_Temp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Gear_Oil_Temp AS  Median_Gear_Oil_Temp
FROM(
SELECT Gear_Oil_Temp, ROW_NUMBER() OVER(ORDER BY Gear_Oil_Temp) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Gear_Oil_Temp AS Mode_Gear_Oil_Temp FROM(
SELECT Gear_Oil_Temp, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Gear_Oil_Temp
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Gear_Oil_Temp) AS Var_Gear_Oil_Temp FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Gear_Oil_Temp) AS Std_Gear_Oil_Temp FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Gear_Oil_Temp) AS Min_Gear_Oil_Temp FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Gear_Oil_Temp) AS Max_Gear_Oil_Temp FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Gear_Oil_Temp) - min(Gear_Oil_Temp) AS Range_Gear_Oil_Temp FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Gear_Oil_Temp - (SELECT AVG(Gear_Oil_Temp) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Gear_Oil_Temp) FROM wt_prep),3))) AS Skewness_Gear_Oil_Temp
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Gear_Oil_Temp  - (SELECT AVG(Gear_Oil_Temp) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Gear_Oil_Temp) FROM wt_prep),4))) - 3) AS Kurtosis_Gear_Oil_Temp
FROM wt_prep;

-------------------------------------------------------------------------------------------------------------------------
# 6. Ambient_Temp
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Ambient_Temp) AS Avg_Ambient_Temp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Ambient_Temp AS  Median_Ambient_Temp
FROM(
SELECT Ambient_Temp, ROW_NUMBER() OVER(ORDER BY Ambient_Temp) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Ambient_Temp AS Mode_Ambient_Temp FROM(
SELECT Ambient_Temp, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Ambient_Temp
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Ambient_Temp) AS Var_Ambient_Temp FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Ambient_Temp) AS Std_Ambient_Temp FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Ambient_Temp) AS Min_Ambient_Temp FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Ambient_Temp) AS Max_Ambient_Temp FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Ambient_Temp) - min(Ambient_Temp) AS Range_Ambient_Temp FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Ambient_Temp - (SELECT AVG(Ambient_Temp) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Ambient_Temp) FROM wt_prep),3))) AS Skewness_Ambient_Temp
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Ambient_Temp  - (SELECT AVG(Ambient_Temp) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Ambient_Temp) FROM wt_prep),4))) - 3) AS Kurtosis_Ambient_Temp
FROM wt_prep;

------------------------------------------------------------------------------------------------------------------------

# 7. Rotor_Speed
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Rotor_Speed) AS Avg_Rotor_Speedp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Rotor_Speed AS  Median_Rotor_Speed
FROM(
SELECT Rotor_Speed, ROW_NUMBER() OVER(ORDER BY Rotor_Speed) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Rotor_Speed AS Mode_Rotor_Speed FROM(
SELECT Rotor_Speed, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Rotor_Speed
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Rotor_Speed) AS Var_Rotor_Speed FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Rotor_Speed) AS Std_Rotor_Speed FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Rotor_Speed) AS Min_Rotor_Speed FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Rotor_Speed) AS Max_Rotor_Speed FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Rotor_Speed) - min(Rotor_Speed) AS Range_Rotor_Speed FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Rotor_Speed - (SELECT AVG(Rotor_Speed) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Rotor_Speed) FROM wt_prep),3))) AS Skewness_Rotor_Speed
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Rotor_Speed  - (SELECT AVG(Rotor_Speed) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Rotor_Speed) FROM wt_prep),4))) - 3) AS Kurtosis_Rotor_Speed
FROM wt_prep;

--------------------------------------------------------------------------------------------------

# 8. Nacelle_Temp
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Nacelle_Temp) AS Avg_Nacelle_Temp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Nacelle_Temp AS  Median_Nacelle_Temp
FROM(
SELECT Nacelle_Temp, ROW_NUMBER() OVER(ORDER BY Nacelle_Temp) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Nacelle_Temp AS Mode_Nacelle_Temp FROM(
SELECT Nacelle_Temp, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Nacelle_Temp
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Nacelle_Temp) AS Var_Nacelle_Temp FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Nacelle_Temp) AS Std_Nacelle_Temp FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Nacelle_Temp) AS Min_Nacelle_Temp FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Nacelle_Temp) AS Max_Nacelle_Temp FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Nacelle_Temp) - min(Nacelle_Temp) AS Range_Nacelle_Temp FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Nacelle_Temp - (SELECT AVG(Nacelle_Temp) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Nacelle_Temp) FROM wt_prep),3))) AS Skewness_Nacelle_Temp
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Nacelle_Temp  - (SELECT AVG(Nacelle_Temp) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Nacelle_Temp) FROM wt_prep),4))) - 3) AS Kurtosis_Nacelle_Temp
FROM wt_prep;

-------------------------------------------------------------------------------------------------------------

# 9. Bearing_Temp
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Bearing_Temp) AS Avg_Bearing_Temp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Bearing_Temp AS  Median_Bearing_Temp
FROM(
SELECT Bearing_Temp, ROW_NUMBER() OVER(ORDER BY Bearing_Temp) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Bearing_Temp AS Mode_Bearing_Temp FROM(
SELECT Bearing_Temp, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Bearing_Temp
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Bearing_Temp) AS Var_Bearing_Temp FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Bearing_Temp) AS Std_Bearing_Temp FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Bearing_Temp) AS Min_Bearing_Temp FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Bearing_Temp) AS Max_Bearing_Temp FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Bearing_Temp) - min(Bearing_Temp) AS Range_Bearing_Temp FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Bearing_Temp - (SELECT AVG(Bearing_Temp) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Bearing_Temp) FROM wt_prep),3))) AS Skewness_Bearing_Temp
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Bearing_Temp  - (SELECT AVG(Bearing_Temp) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Bearing_Temp) FROM wt_prep),4))) - 3) AS Kurtosis_Bearing_Temp
FROM wt_prep;

--------------------------------------------------------------------------------------------------------------

# 10. Generator_Speed
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Generator_Speed) AS Avg_Generator_Speed FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Generator_Speed AS  Median_Generator_Speed
FROM(
SELECT Generator_Speed, ROW_NUMBER() OVER(ORDER BY Generator_Speed) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Generator_Speed AS Mode_Generator_Speed FROM(
SELECT Generator_Speed, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Generator_Speed
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Generator_Speed) AS Var_Generator_Speed FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Generator_Speed) AS Std_Generator_Speed FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Generator_Speed) AS Min_Generator_Speed FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Generator_Speed) AS Max_Generator_Speed FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Generator_Speed) - min(Generator_Speed) AS Range_Generator_Speed FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Generator_Speed - (SELECT AVG(Generator_Speed) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Generator_Speed) FROM wt_prep),3))) AS Skewness_Generator_Speed
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Generator_Speed  - (SELECT AVG(Generator_Speed) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Generator_Speed) FROM wt_prep),4))) - 3) AS Kurtosis_Generator_Speed
FROM wt_prep;

-------------------------------------------------------------------------------------------------------------------------------

# 11. Yaw_Angle
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Yaw_Angle) AS Avg_Yaw_Angle FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Yaw_Angle AS  Median_Yaw_Angle
FROM(
SELECT Yaw_Angle, ROW_NUMBER() OVER(ORDER BY Yaw_Angle) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Yaw_Angle AS Mode_Yaw_Angle FROM(
SELECT Yaw_Angle, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Yaw_Angle
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Yaw_Angle) AS Var_Yaw_Angle FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Yaw_Angle) AS Std_Yaw_Angle FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Yaw_Angle) AS Min_Yaw_Angle FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Yaw_Angle) AS Max_Yaw_Angle FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Yaw_Angle) - min(Yaw_Angle) AS Range_Yaw_Angle FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Yaw_Angle - (SELECT AVG(Yaw_Angle) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Yaw_Angle) FROM wt_prep),3))) AS Skewness_Yaw_Angle
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Yaw_Angle  - (SELECT AVG(Yaw_Angle) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Yaw_Angle) FROM wt_prep),4))) - 3) AS Kurtosis_Yaw_Angle
FROM wt_prep;

-------------------------------------------------------------------------------------------------------

# 12. Wind_Direction
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Wind_Direction) AS Avg_Wind_Direction FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Wind_Direction AS  Median_Wind_Direction
FROM(
SELECT Wind_Direction, ROW_NUMBER() OVER(ORDER BY Wind_Direction) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Wind_Direction AS Mode_Wind_Direction FROM(
SELECT Wind_Direction, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Wind_Direction
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Wind_Direction) AS Var_Wind_Direction FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Wind_Direction) AS Std_Wind_Direction FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Wind_Direction) AS Min_Wind_Direction FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Wind_Direction) AS Max_Wind_Direction FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Wind_Direction) - min(Wind_Direction) AS Range_Wind_Direction FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Wind_Direction - (SELECT AVG(Wind_Direction) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Wind_Direction) FROM wt_prep),3))) AS Skewness_Wind_Direction
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Wind_Direction  - (SELECT AVG(Wind_Direction) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Wind_Direction) FROM wt_prep),4))) - 3) AS Kurtosis_Wind_Direction
FROM wt_prep;

----------------------------------------------------------------------------------------------------------------------------

# 13. Wheel_Hub_Temp
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Wheel_Hub_Temp) AS Avg_Wheel_Hub_Temp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Wheel_Hub_Temp AS  Median_Wheel_Hub_Temp
FROM(
SELECT Wheel_Hub_Temp, ROW_NUMBER() OVER(ORDER BY Wheel_Hub_Temp) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Wheel_Hub_Temp AS Mode_Wheel_Hub_Temp FROM(
SELECT Wheel_Hub_Temp, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Wheel_Hub_Temp
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Wheel_Hub_Temp) AS Var_Wheel_Hub_Temp FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Wheel_Hub_Temp) AS Std_Wheel_Hub_Temp FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Wheel_Hub_Temp) AS Min_Wheel_Hub_Temp FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Wheel_Hub_Temp) AS Max_Wheel_Hub_Temp FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Wheel_Hub_Temp) - min(Wheel_Hub_Temp) AS Range_Wheel_Hub_Temp FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Wheel_Hub_Temp - (SELECT AVG(Wheel_Hub_Temp) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Wheel_Hub_Temp) FROM wt_prep),3))) AS Skewness_Wheel_Hub_Temp
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis  ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Wheel_Hub_Temp  - (SELECT AVG(Wheel_Hub_Temp) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Wheel_Hub_Temp) FROM wt_prep),4))) - 3) AS Kurtosis_Wheel_Hub_Temp
FROM wt_prep;


------------------------------------------------------------------------------------------------------------------

# 14. Gearbox_Inlet_Temp
# First Moment Business Decision (Mean, Median and Mode)
-- Mean ( For to find the average of the column)
SELECT AVG(Gearbox_Inlet_Temp) AS Avg_Gearbox_Inlet_Temp FROM wt_prep;

-- Meadin (For to find the middel value of the columns when sorted in ascending or descending order)
SELECT Gearbox_Inlet_Temp AS  Median_Gearbox_Inlet_Temp
FROM(
SELECT Gearbox_Inlet_Temp, ROW_NUMBER() OVER(ORDER BY Gearbox_Inlet_Temp) AS Row_Num,
COUNT(*) OVER() AS Total_Rows FROM wt_prep) AS SUB_QUERY
WHERE Row_Num = (Total_Rows + 1)/2 OR Row_Num = (Total_Rows + 2)/2;

-- Mode (For to find the most frequent value in the column)
SELECT Gearbox_Inlet_Temp AS Mode_Gearbox_Inlet_Temp FROM(
SELECT Gearbox_Inlet_Temp, Count(*) AS FREQUENCY
FROM wt_prep
GROUP BY Gearbox_Inlet_Temp
ORDER BY FREQUENCY DESC
LIMIT 1) AS SUBQUERY;

# Second Moment Business Decision (Variance, Standard Deviation, Min, Max , Range)
-- Variance (For to find the average squared deviation of each data point from mean)
SELECT variance(Gearbox_Inlet_Temp) AS Var_Gearbox_Inlet_Temp FROM wt_prep;

-- Standard Deviation (For to find the amount of variation from mean)
SELECT stddev(Gearbox_Inlet_Temp) AS Std_Gearbox_Inlet_Temp FROM wt_prep;

-- Min (For to find the minimum value of the column)
SELECT min(Gearbox_Inlet_Temp) AS Min_Gearbox_Inlet_Temp FROM wt_prep;

-- Max (For to find the maximum value of the column)
SELECT max(Gearbox_Inlet_Temp) AS Max_Gearbox_Inlet_Temp FROM wt_prep;

-- Range (For to find the spread of the data points)
SELECT max(Gearbox_Inlet_Temp) - min(Gearbox_Inlet_Temp) AS Range_Gearbox_Inlet_Temp FROM wt_prep;

# Third Moment Business Decision (Skewness)
-- Skewness ( For to check the assemetry of the data distribution )
SELECT 
(SUM(POWER(Gearbox_Inlet_Temp - (SELECT AVG(Gearbox_Inlet_Temp) FROM wt_prep),3))/
(COUNT(*) * POWER((SELECT STDDEV(Gearbox_Inlet_Temp) FROM wt_prep),3))) AS Skewness_Gearbox_Inlet_Temp
FROM wt_prep;

# Fourth Moment Business Decision (Kurtosis)
-- Kurtosis ( For to check the tailedness of the data distribution )
SELECT 
((SUM(POWER(Gearbox_Inlet_Temp  - (SELECT AVG(Gearbox_Inlet_Temp) FROM wt_prep),4))/
(COUNT(*) * POWER((SELECT STDDEV(Gearbox_Inlet_Temp) FROM wt_prep),4))) - 3) AS Kurtosis_Gearbox_Inlet_Temp
FROM wt_prep;

----------------------------------------------------------------------------------------------------------------------------------

# 15. Failure_Status
-- Total Failure Counts and Overall Percentage
SELECT Failure_Status, COUNT(*) AS Failure_Counts,
ROUND(COUNT(*) * 100 / (SELECT COUNT(*) FROM wt_prep),2) AS Overall_Perc
FROM wt_prep
GROUP BY Failure_Status
ORDER BY Failure_Counts ;


SELECT YEAR(Date) AS Year, COUNT(*) AS Total_Records,
SUM(CASE
		WHEN Failure_Status = "Failure" THEN 1
        ELSE 0
	END) AS Total_Annual_Failures,
ROUND(SUM(CASE
		WHEN Failure_Status = "Failure" THEN 1
        ELSE 0
	END) * 100 / COUNT(*),2) AS Annual_Failure_perc
FROM wt_prep
GROUP BY YEAR
ORDER BY Year;




##################################################################################################################################
##################################  Create a Procedre for to find the Ourliers in each column ####################################
##################################################################################################################################
/* This function gives the only outliers records */

DELIMITER //

CREATE PROCEDURE find_outliers_iqr(IN col_name VARCHAR(64))
BEGIN
    DECLARE total_rows INT;
    DECLARE q1_pos INT;
    DECLARE q3_pos INT;
    DECLARE Q1_val DOUBLE;
    DECLARE Q3_val DOUBLE;
    DECLARE IQR_val DOUBLE;
    DECLARE Lower_Bound DOUBLE;
    DECLARE Upper_Bound DOUBLE;

    -- Step 1: Get total number of rows
    SET @sql = CONCAT('SELECT COUNT(*) INTO @total_rows FROM wt_prep WHERE ', col_name, ' IS NOT NULL');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET total_rows = @total_rows;
    SET q1_pos = ROUND(total_rows * 0.25);
    SET q3_pos = ROUND(total_rows * 0.75);

    -- Step 2: Create temporary table with row numbers
    SET @sql = CONCAT('CREATE TEMPORARY TABLE temp_values AS
                       SELECT ', col_name, ', 
                              ROW_NUMBER() OVER (ORDER BY ', col_name, ') AS rn
                        FROM wt_prep
                        WHERE ', col_name, ' IS NOT NULL');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Step 3: Fetch Q1
    SET @sql = CONCAT('SELECT ', col_name, ' INTO @Q1_val FROM temp_values WHERE rn = ', q1_pos);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Step 4: Fetch Q3
    SET @sql = CONCAT('SELECT ', col_name, ' INTO @Q3_val FROM temp_values WHERE rn = ', q3_pos);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET Q1_val = @Q1_val;
    SET Q3_val = @Q3_val;
    SET IQR_val = Q3_val - Q1_val;
    SET Lower_Bound = Q1_val - 1.5 * IQR_val;
    SET Upper_Bound = Q3_val + 1.5 * IQR_val;

    -- Step 5: Return Outliers
    SET @sql = CONCAT('SELECT * FROM wt_prep WHERE ', col_name, ' < ', Lower_Bound, ' OR ', col_name, ' > ', Upper_Bound);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Optional: Clean-up
    DROP TEMPORARY TABLE IF EXISTS temp_values;

END //

DELIMITER ;

-- Call the function 
CALL find_outliers_iqr('Wind_Speed');



##################################################################################################################################
##################################  Create a Stored Procedre for to find the Ourliers in each column #############################
##################################################################################################################################
/* This function gives the  outliers records with Q1, Q3, IQR, LB, UB Values also */

-- DROP PROCEDURE IF EXISTS find_outliers;

DELIMITER //

CREATE PROCEDURE find_outliers(IN col_name VARCHAR(64))
BEGIN
    DECLARE total_rows INT;
    DECLARE q1_pos INT;
    DECLARE q3_pos INT;
    DECLARE Q1_val DOUBLE;
    DECLARE Q3_val DOUBLE;
    DECLARE IQR_val DOUBLE;
    DECLARE Lower_Bound DOUBLE;
    DECLARE Upper_Bound DOUBLE;

    -- Step 1: Get total row count
    SET @sql = CONCAT('SELECT COUNT(*) INTO @total_rows FROM wt_prep WHERE ', col_name, ' IS NOT NULL');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET total_rows = @total_rows;
    SET q1_pos = ROUND(total_rows * 0.25);
    SET q3_pos = ROUND(total_rows * 0.75);

    -- Step 2: Create temp table with row numbers
    SET @sql = CONCAT('CREATE TEMPORARY TABLE temp_values AS
                       SELECT ', col_name, ', 
                              ROW_NUMBER() OVER (ORDER BY ', col_name, ') AS rn
                        FROM wt_prep
                        WHERE ', col_name, ' IS NOT NULL');
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Step 3: Get Q1
    SET @sql = CONCAT('SELECT ', col_name, ' INTO @Q1_val FROM temp_values WHERE rn = ', q1_pos);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Step 4: Get Q3
    SET @sql = CONCAT('SELECT ', col_name, ' INTO @Q3_val FROM temp_values WHERE rn = ', q3_pos);
    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET Q1_val = @Q1_val;
    SET Q3_val = @Q3_val;
    SET IQR_val = Q3_val - Q1_val;
    SET Lower_Bound = Q1_val - 1.5 * IQR_val;
    SET Upper_Bound = Q3_val + 1.5 * IQR_val;
    
    -- Step 5A: Show the metrics (always)
	SELECT 
    Q1_val AS Q1,
    Q3_val AS Q3,
    IQR_val AS IQR,
    Lower_Bound AS Lower_Bound,
    Upper_Bound AS Upper_Bound;

    -- Step 5B: Show Outliers with Q1, Q3, IQR, LB, UB
    SET @sql = CONCAT('SELECT *,
        ', Q1_val, ' AS Q1,
        ', Q3_val, ' AS Q3,
        ', IQR_val, ' AS IQR,
        ', Lower_Bound, ' AS Lower_Bound,
        ', Upper_Bound, ' AS Upper_Bound
     FROM wt_prep
     WHERE ', col_name, ' < ', Lower_Bound, ' OR ', col_name, ' > ', Upper_Bound);

    PREPARE stmt FROM @sql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    -- Step 6: Clean up
    DROP TEMPORARY TABLE IF EXISTS temp_values;
END //

DELIMITER ;

-- Call the function 
CALL find_outliers('Wind_Speed');
CALL find_outliers('Power');
CALL find_outliers('Nacelle_Ambient_Temp');
CALL find_outliers('Generator_Bearing_Temp');
CALL find_outliers('Gear_Oil_Temp');--------------------
CALL find_outliers('Ambient_Temp');
CALL find_outliers('Rotor_Speed');---------------
CALL find_outliers('Nacelle_Temp');
CALL find_outliers('Bearing_Temp');
CALL find_outliers('Generator_Speed');
CALL find_outliers('Yaw_Angle');-------------------------
CALL find_outliers('Wind_Direction');
CALL find_outliers('Wheel_Hub_Temp');---------------------------
CALL find_outliers('Gearbox_Inlet_Temp');



----------------------------------------------------------------------------------------------------------------------------


/* Find the Min and Max value of Wind_Speed when Turbine is Failed */
-- SELECT Date, Wind_Speed, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure" ;
-- SELECT MIN(Wind_Speed), MAX(Wind_Speed) FROM (SELECT Wind_Speed, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure") AS SUBQUERY;

## Wind_Speed
-- Min 
SELECT Date, Wind_Speed, Failure_Status 
FROM wt_prep
WHERE Wind_Speed = (SELECT MIN(Wind_Speed) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

-- Max
SELECT Date, Wind_Speed, Failure_Status 
FROM wt_prep
WHERE Wind_Speed = (SELECT MAX(Wind_Speed) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

------------------------------------------------------------------------------------------------------------------------------

## Power
-- SELECT MIN(Power), MAX(Power) FROM (SELECT Power, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure") AS SUBQUERY;
-- Min 
SELECT Date, Power, Failure_Status 
FROM wt_prep
WHERE Power = (SELECT MIN(Power) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

-- Max
SELECT Date, Power, Failure_Status 
FROM wt_prep
WHERE Power = (SELECT MAX(Power) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

SELECT Date,Power, Failure_Status 
FROM wt_prep
WHERE Power = (SELECT MAX(Power) FROM wt_prep WHERE Failure_Status = "No_failure");

SELECT Date,Wind_Speed, Power, Failure_Status FROM wt_prep WHERE Power = (SELECT MAX(Power) FROM wt_prep WHERE Failure_Status = "No_failure");
SELECT * FROM wt_prep WHERE Power > (SELECT MAX(Power) FROM wt_prep WHERE Failure_Status = "No_failure");

----------------------------------------------------------------------------------------------------------------------------
## Nacelle_Ambient_Temp
-- SELECT MIN(Nacelle_Ambient_Temp), MAX(Nacelle_Ambient_Temp) FROM (SELECT Nacelle_Ambient_Temp, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure") AS SUBQUERY;
-- Min 
SELECT Date, Nacelle_Ambient_Temp, Failure_Status 
FROM wt_prep
WHERE Nacelle_Ambient_Temp = (SELECT MIN(Nacelle_Ambient_Temp) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

-- Max
SELECT Date, Nacelle_Ambient_Temp, Failure_Status 
FROM wt_prep
WHERE Nacelle_Ambient_Temp = (SELECT MAX(Nacelle_Ambient_Temp) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

SELECT Date,Nacelle_Ambient_Temp, Failure_Status 
FROM wt_prep
WHERE Nacelle_Ambient_Temp = (SELECT MAX(Nacelle_Ambient_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");

SELECT Date,Wind_Speed, Power, Nacelle_Ambient_Temp,Failure_Status FROM wt_prep WHERE Nacelle_Ambient_Temp = (SELECT MAX(Nacelle_Ambient_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");
SELECT * FROM wt_prep WHERE Nacelle_Ambient_Temp > (SELECT MAX(Nacelle_Ambient_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");

--------------------------------------------------------------------------------------------------------------------------------------

## Generator_Bearing_Temp
-- SELECT MIN(Generator_Bearing_Temp), MAX(Generator_Bearing_Temp) FROM (SELECT Generator_Bearing_Temp, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure") AS SUBQUERY;
-- Min 
SELECT Date, Generator_Bearing_Temp, Failure_Status 
FROM wt_prep
WHERE Generator_Bearing_Temp = (SELECT MIN(Generator_Bearing_Temp) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

-- Max
SELECT Date, Generator_Bearing_Temp, Failure_Status 
FROM wt_prep
WHERE Generator_Bearing_Temp = (SELECT MAX(Generator_Bearing_Temp) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

SELECT Date,Generator_Bearing_Temp, Failure_Status 
FROM wt_prep
WHERE Generator_Bearing_Temp = (SELECT MAX(Generator_Bearing_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");

SELECT Date,Wind_Speed, Power, Nacelle_Ambient_Temp, Generator_Bearing_Temp, Failure_Status FROM wt_prep WHERE Generator_Bearing_Temp = (SELECT MAX(Generator_Bearing_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");
SELECT * FROM wt_prep WHERE Generator_Bearing_Temp > (SELECT MAX(Generator_Bearing_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");

-------------------------------------------------------------------------------------------------------------------------------------------

## Ambient_Temp
-- SELECT MIN(Ambient_Temp), MAX(Ambient_Temp) FROM (SELECT Ambient_Temp, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure") AS SUBQUERY;
-- Min 
SELECT Date, Ambient_Temp, Failure_Status 
FROM wt_prep
WHERE Ambient_Temp = (SELECT MIN(Ambient_Temp) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

-- Max
SELECT Date, Ambient_Temp, Failure_Status 
FROM wt_prep
WHERE Ambient_Temp = (SELECT MAX(Ambient_Temp) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

SELECT Date,Ambient_Temp, Failure_Status 
FROM wt_prep
WHERE Ambient_Temp = (SELECT MAX(Ambient_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");

SELECT *  FROM wt_prep WHERE Ambient_Temp = (SELECT MAX(Ambient_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");
SELECT * FROM wt_prep WHERE Ambient_Temp > (SELECT MAX(Ambient_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");
---------------------------------------------------------------------------------------------------------------------------------------------
## Rotor_Speed
-- SELECT MIN(Rotor_Speed), MAX(Rotor_Speed) FROM (SELECT Rotor_Speed, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure") AS SUBQUERY;
-- Min 
SELECT Date, Rotor_Speed, Failure_Status 
FROM wt_prep
WHERE Rotor_Speed = (SELECT MIN(Rotor_Speed) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

-- Max
SELECT Date, Rotor_Speed, Failure_Status 
FROM wt_prep
WHERE Rotor_Speed = (SELECT MAX(Rotor_Speed) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

SELECT Date,Rotor_Speed, Failure_Status 
FROM wt_prep
WHERE Rotor_Speed = (SELECT MAX(Rotor_Speed) FROM wt_prep WHERE Failure_Status = "No_failure");

SELECT *  FROM wt_prep WHERE Rotor_Speed = (SELECT MAX(Rotor_Speed) FROM wt_prep WHERE Failure_Status = "No_failure");
SELECT * FROM wt_prep WHERE Rotor_Speed > (SELECT MAX(Rotor_Speed) FROM wt_prep WHERE Failure_Status = "No_failure");

-------------------------------------------------------------------------------------------------------------------------------
## Bearing_Temp
-- SELECT MIN(Bearing_Temp), MAX(Bearing_Temp) FROM (SELECT Bearing_Temp, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure") AS SUBQUERY;
-- Min 
SELECT Date, Bearing_Temp, Failure_Status 
FROM wt_prep
WHERE Bearing_Temp = (SELECT MIN(Bearing_Temp) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

-- Max
SELECT Date, Bearing_Temp, Failure_Status 
FROM wt_prep
WHERE Bearing_Temp = (SELECT MAX(Bearing_Temp) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

SELECT Date,Bearing_Temp, Failure_Status 
FROM wt_prep
WHERE Bearing_Temp = (SELECT MAX(Bearing_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");

SELECT *  FROM wt_prep WHERE Bearing_Temp = (SELECT MAX(Bearing_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");
SELECT * FROM wt_prep WHERE Bearing_Temp > (SELECT MAX(Bearing_Temp) FROM wt_prep WHERE Failure_Status = "No_failure");

-------------------------------------------------------------------------------------------------------------------------------

## Generator_Speed
-- SELECT MIN(Generator_Speed), MAX(Generator_Speed) FROM (SELECT Generator_Speed, Failure_Status FROM wt_prep WHERE Failure_Status = "Failure") AS SUBQUERY;
-- Min 
SELECT Date, Generator_Speed, Failure_Status 
FROM wt_prep
WHERE Generator_Speed = (SELECT MIN(Generator_Speed) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

-- Max
SELECT Date, Generator_Speed,Failure_Status 
FROM wt_prep
WHERE Generator_Speed = (SELECT MAX(Generator_Speed) FROM wt_prep WHERE Failure_Status = "Failure") AND Failure_Status = "Failure";

SELECT Date,Generator_Speed, Failure_Status 
FROM wt_prep
WHERE Generator_Speed = (SELECT MAX(Generator_Speed) FROM wt_prep WHERE Failure_Status = "No_failure");

SELECT *  FROM wt_prep WHERE Generator_Speed = (SELECT MAX(Generator_Speed) FROM wt_prep WHERE Failure_Status = "No_failure");
SELECT * FROM wt_prep WHERE Generator_Speed > (SELECT MAX(Generator_Speed) FROM wt_prep WHERE Failure_Status = "No_failure");


-------------------------------------------------------------------------------------------------------------------------------

##########################################################################################################################
##############################################  Check Duplicate Records ##################################################
##########################################################################################################################

# Find Duplicate Records for Numerical Columns

SELECT 
Wind_Speed, 
Power, 
Nacelle_Ambient_Temp,
Generator_Bearing_Temp, 
Gear_Oil_Temp, 
Ambient_Temp, 
Rotor_Speed, 
Nacelle_Temp, 
Bearing_Temp, 
Generator_Speed, 
Yaw_Angle, 
Wind_Direction, 
Wheel_Hub_Temp, 
Gearbox_Inlet_Temp,
COUNT(*) AS Duplicate_Count
FROM wt_prep
GROUP BY 
Wind_Speed, 
Power, 
Nacelle_Ambient_Temp,
Generator_Bearing_Temp, 
Gear_Oil_Temp, 
Ambient_Temp, 
Rotor_Speed, 
Nacelle_Temp, 
Bearing_Temp, 
Generator_Speed, 
Yaw_Angle, 
Wind_Direction, 
Wheel_Hub_Temp, 
Gearbox_Inlet_Temp
HAVING COUNT(*) > 1;


--------------------------------------------------------------------------------------------------------------------------

#####################################################################################################################
##############################################  Check Missig Values #################################################
#####################################################################################################################

# Find Missing Values

SELECT 
COUNT(*) AS Total_Rows,
SUM( CASE WHEN Wind_Speed IS NULL THEN 1 ELSE 0 END ) AS Wind_Speed_Missing,
SUM( CASE WHEN Power IS NULL THEN 1 ELSE 0 END ) AS Power_Missing,
SUM( CASE WHEN Nacelle_Ambient_Temp IS NULL THEN 1 ELSE 0 END ) AS Nacelle_Ambient_Temp_Missing,
SUM( CASE WHEN Generator_Bearing_Temp IS NULL THEN 1 ELSE 0 END ) AS Generator_Bearing_Temp_Missing,
SUM( CASE WHEN Gear_Oil_Temp IS NULL THEN 1 ELSE 0 END ) AS Gear_Oil_Temp_Missing,
SUM( CASE WHEN Ambient_Temp IS NULL THEN 1 ELSE 0 END ) AS Ambient_Temp_Missing,
SUM( CASE WHEN Rotor_Speed IS NULL THEN 1 ELSE 0 END ) AS Rotor_Speed_Missing,
SUM( CASE WHEN Nacelle_Temp IS NULL THEN 1 ELSE 0 END ) AS Nacelle_Temp_Missing,
SUM( CASE WHEN Bearing_Temp IS NULL THEN 1 ELSE 0 END ) AS Bearing_Temp_Missing,
SUM( CASE WHEN Generator_Speed IS NULL THEN 1 ELSE 0 END ) AS Generator_Speed_Missing,
SUM( CASE WHEN Yaw_Angle IS NULL THEN 1 ELSE 0 END ) AS Yaw_Angle_Missing,
SUM( CASE WHEN Wind_Direction IS NULL THEN 1 ELSE 0 END ) AS Wind_Direction_Missing,
SUM( CASE WHEN Wheel_Hub_Temp IS NULL THEN 1 ELSE 0 END ) AS Wheel_Hub_Temp_Missing,
SUM( CASE WHEN Gearbox_Inlet_Temp IS NULL THEN 1 ELSE 0 END ) AS Gearbox_Inlet_Temp_Missing
FROM wt_prep;

--------------------------------------------------------------------------------------------------------------------------------

#############################################################################################################################
################################################### Discretization / Binning ################################################
#############################################################################################################################

/* Below Q1: "Low", Between Q1 & Q3 : "Medium", Above Q3: "High" */

SELECT
Wind_Speed,
	CASE
		WHEN Wind_Speed < 6.37 THEN "Low"
        WHEN Wind_Speed >= 6.37  AND  Wind_Speed <= 21.71  THEN "Medium"
        WHEN Wind_Speed > 21.71 THEN "High"
        ELSE "Unknown"
	END AS Wind_Speed_Discretization,
    
Power,
	CASE
		WHEN Power <  2.21 THEN "Low"
        WHEN Power >=  2.21  AND Power <= 3.24 THEN "Medium"
        WHEN Power >  3.24 THEN "High"
        ELSE "Unknown"
	END AS Power_Discretization,
    
Nacelle_Ambient_Temp,
	CASE
		WHEN Nacelle_Ambient_Temp <  1.21 THEN "Low"
        WHEN Nacelle_Ambient_Temp >=  1.21  AND  Nacelle_Ambient_Temp <= 28.02  THEN "Medium"
        WHEN Nacelle_Ambient_Temp >  28.02 THEN "High"
        ELSE "Unknown"
	END AS Nacelle_Ambient_Temp_Discretization,
    
Generator_Bearing_Temp,
	CASE
		WHEN Generator_Bearing_Temp <  72.58 THEN "Low"
        WHEN Generator_Bearing_Temp >=  72.58  AND  Generator_Bearing_Temp <= 94.96  THEN "Medium"
        WHEN Generator_Bearing_Temp >  94.96 THEN "High"
        ELSE "Unknown"
	END AS Generator_Bearing_Temp_Discretization,
    
Gear_Oil_Temp,
	CASE
		WHEN Gear_Oil_Temp <  65.96 THEN "Low"
        WHEN Gear_Oil_Temp >=  65.96  AND Gear_Oil_Temp <= 106.37  THEN "Medium"
        WHEN Gear_Oil_Temp >  106.37 THEN "High"
        ELSE "Unknown"
	END AS Gear_Oil_Temp_Discretization,
    
Ambient_Temp,
	CASE
		WHEN Ambient_Temp <  -3.93 THEN "Low"
        WHEN Ambient_Temp >=  -3.93  AND  Ambient_Temp <= 30.50 THEN "Medium"
        WHEN Ambient_Temp >  30.50 THEN "High"
        ELSE "Unknown"
	END AS Ambient_Temp_Discretization,
    
Rotor_Speed,
	CASE
		WHEN Rotor_Speed <  98.53  THEN "Low"
        WHEN Rotor_Speed >=  98.53  AND Rotor_Speed <= 262.79 THEN "Medium"
        WHEN Rotor_Speed >  262.79 THEN "High"
        ELSE "Unknown"
	END AS Rotor_Speed_Discretization,
    
Nacelle_Temp,
	CASE
		WHEN Nacelle_Temp <  36.21 THEN "Low"
        WHEN Nacelle_Temp >=  36.21 AND Nacelle_Temp <= 57.42 THEN "Medium"
        WHEN Nacelle_Temp >  57.42 THEN "High"
        ELSE "Unknown"
	END AS Nacelle_Temp_Discretization,
    
Bearing_Temp,
	CASE
		WHEN Bearing_Temp <  71.4 THEN "Low"
        WHEN Bearing_Temp >=  71.4  AND Bearing_Temp <= 102  THEN "Medium"
        WHEN Bearing_Temp >  102 THEN "High"
        ELSE "Unknown"
	END AS Bearing_Temp_Discretization,
    
Generator_Speed,
	CASE
		WHEN Generator_Speed <  1123.92 THEN "Low"
        WHEN Generator_Speed >=  1123.92  AND  Generator_Speed <= 1662.43 THEN "Medium"
        WHEN Generator_Speed >  1662.43 THEN "High"
        ELSE "Unknown"
	END AS Generator_Speed_Discretization,
    
Yaw_Angle,
	CASE
		WHEN Yaw_Angle <  6.40 THEN "Low"
        WHEN Yaw_Angle >=  6.40  AND Yaw_Angle <= 93.03 THEN "Medium"
        WHEN Yaw_Angle >  93.03 THEN "High"
        ELSE "Unknown"
	END AS Yaw_Angle_Discretization,
    
Wind_Direction,
	CASE
		WHEN Wind_Direction <  -413.41 THEN "Low"
        WHEN Wind_Direction >=  -413.41  AND  Wind_Direction <= 631.96 THEN "Medium"
        WHEN Wind_Direction >  631.96 THEN "High"
        ELSE "Unknown"
	END AS Wind_Direction_Discretization,
    
Wheel_Hub_Temp,
	CASE
		WHEN Wheel_Hub_Temp <  -19.40 THEN "Low"
        WHEN Wheel_Hub_Temp >=  -19.40  AND  Wheel_Hub_Temp <= 60.28 THEN "Medium"
        WHEN Wheel_Hub_Temp >  60.28 THEN "High"
        ELSE "Unknown"
	END AS Wheel_Hub_Temp_Discretization,
    
Gearbox_Inlet_Temp,
	CASE
		WHEN Gearbox_Inlet_Temp <  13.96 THEN "Low"
        WHEN Gearbox_Inlet_Temp >=  13.96  AND Gearbox_Inlet_Temp <= 24.72 THEN "Medium"
        WHEN Gearbox_Inlet_Temp >  24.72  THEN "High"
        ELSE "Unknown"
	END AS Gearbox_Inlet_Temp_Discretization
 
FROM wt_prep;

--------------------------------------------------------------------------------------------------------------------------------

#############################################################################################################################
################################################### Scaling #################################################################
#############################################################################################################################

/* Normalization: Min - Max Scalar */

-- Create a new table called wt_prep_scaled by applying min-max scaling to various numerical columns in the wt_prep table.
-- The min-max scaling process scales each feature to a range between 0 and 1 using the following formula:
-- Scaled value = (Value - Min(value)) / (Max(value) - Min(value))

CREATE TABLE wt_prep_scaled AS 
SELECT 
Date,
Wind_Speed,
ROUND(( Wind_Speed - (SELECT MIN(Wind_Speed) FROM wt_prep))/ ((SELECT MAX(Wind_Speed) FROM wt_prep) - (SELECT MIN(Wind_Speed) FROM wt_prep)),2) AS Scaled_Wind_Speed,
Power,
ROUND(( Power - (SELECT MIN(Power) FROM wt_prep))/ ((SELECT MAX(Power) FROM wt_prep) - (SELECT MIN(Power) FROM wt_prep)),2) AS Scaled_Power,
Nacelle_Ambient_Temp,
ROUND(( Nacelle_Ambient_Temp - (SELECT MIN(Nacelle_Ambient_Temp) FROM wt_prep))/ ((SELECT MAX(Nacelle_Ambient_Temp) FROM wt_prep) - (SELECT MIN(Nacelle_Ambient_Temp) FROM wt_prep)),2)  AS Scaled_Nacelle_Ambient_Temp,
Generator_Bearing_Temp,
ROUND(( Generator_Bearing_Temp - (SELECT MIN(Generator_Bearing_Temp) FROM wt_prep))/ ((SELECT MAX(Generator_Bearing_Temp) FROM wt_prep) - (SELECT MIN(Generator_Bearing_Temp) FROM wt_prep)),2)  AS Scaled_Generator_Bearing_Temp,
Gear_Oil_Temp,
ROUND(( Gear_Oil_Temp - (SELECT MIN(Gear_Oil_Temp) FROM wt_prep))/ ((SELECT MAX(Gear_Oil_Temp) FROM wt_prep) - (SELECT MIN(Gear_Oil_Temp) FROM wt_prep)),2)  AS Scaled_Gear_Oil_Tem,
Ambient_Temp,
ROUND(( Ambient_Temp - (SELECT MIN(Ambient_Temp) FROM wt_prep))/ ((SELECT MAX(Ambient_Temp) FROM wt_prep) - (SELECT MIN(Ambient_Temp) FROM wt_prep)),2)  AS Scaled_Ambient_Temp,
Rotor_Speed,
ROUND(( Rotor_Speed - (SELECT MIN(Rotor_Speed) FROM wt_prep))/ ((SELECT MAX(Rotor_Speed) FROM wt_prep) - (SELECT MIN(Rotor_Speed) FROM wt_prep)),2)  AS Scaled_Rotor_Speed,
Nacelle_Temp,
ROUND(( Nacelle_Temp - (SELECT MIN(Nacelle_Temp) FROM wt_prep))/ ((SELECT MAX(Nacelle_Temp) FROM wt_prep) - (SELECT MIN(Nacelle_Temp) FROM wt_prep)),2)  AS Scaled_Nacelle_Temp,
Bearing_Temp,
ROUND(( Bearing_Temp - (SELECT MIN(Bearing_Temp) FROM wt_prep))/ ((SELECT MAX(Bearing_Temp) FROM wt_prep) - (SELECT MIN(Bearing_Temp) FROM wt_prep)),2) AS Scaled_Bearing_Temp,
Generator_Speed,
ROUND(( Generator_Speed - (SELECT MIN(Generator_Speed) FROM wt_prep))/ ((SELECT MAX(Generator_Speed) FROM wt_prep) - (SELECT MIN(Generator_Speed) FROM wt_prep)),2)  AS Scaled_Generator_Spee,
Yaw_Angle,
ROUND(( Yaw_Angle - (SELECT MIN(Yaw_Angle) FROM wt_prep))/ ((SELECT MAX(Yaw_Angle) FROM wt_prep) - (SELECT MIN(Yaw_Angle) FROM wt_prep)),2)  AS Scaled_Yaw_Angle,
Wind_Direction,
ROUND(( Wind_Direction - (SELECT MIN(Wind_Direction) FROM wt_prep))/ ((SELECT MAX(Wind_Direction) FROM wt_prep) - (SELECT MIN(Wind_Direction) FROM wt_prep)),2)  AS Scaled_Wind_Direction,
Wheel_Hub_Temp,
ROUND(( Wheel_Hub_Temp - (SELECT MIN(Wheel_Hub_Temp) FROM wt_prep))/ ((SELECT MAX(Wheel_Hub_Temp) FROM wt_prep) - (SELECT MIN(Wheel_Hub_Temp) FROM wt_prep)),2)  AS Scaled_Wheel_Hub_Temp,
Gearbox_Inlet_Temp,
ROUND(( Gearbox_Inlet_Temp - (SELECT MIN(Gearbox_Inlet_Temp) FROM wt_prep))/ ((SELECT MAX(Gearbox_Inlet_Temp) FROM wt_prep) - (SELECT MIN(Gearbox_Inlet_Temp) FROM wt_prep)),2)  AS Scaled_Gearbox_Inlet_Temp
FROM wt_prep;

-- Fetch the data from wt_prep_scaled
SELECT * FROM wt_prep_scaled;

