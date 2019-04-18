-- Create and use gv_weather_db
CREATE DATABASE gv_weather_db;
USE gv_weather_db;

-- We can directly use the joined table
SELECT * FROM gv_and_weather;

-- Or we can join the tables through MySQL
SELECT * FROM gv;
SELECT * FROM weather;

SELECT gv.Incident_Date, gv.State, gv.City_Or_County, gv.Address, gv.num_Killed, gv.num_Injured, weather.High_temp, weather.Low_temp, weather.Condition, weather.Precipitation
From gv
LEFT JOIN weather
ON gv.Incident_Date = weather.Incident_Date;
