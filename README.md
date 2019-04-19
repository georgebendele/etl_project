# etl_project
ETL project repository


## Project Proposal:

The purpose of this project is to Extract, Transform, and Load data from 2 sources into a database. For this project we have chosen a dataset of gun-violence incidents from data.world (Geocoded: Incidents of Gun Violence in San Antonio (2018)), which we will join by date with weather data obtained from OpenWeatherMap to determine any correlations between daily temperatures and gun violence incidence. Once the data is extracted, and cleaned, we will store it in a SQL database.

## Data Sources:

1) data.world -- Geocoded: Incidents of Gun Violence in San Antonio (2018)
https://data.world/rivardreport/geocoded-incidents-of-gun-violence-in-san-antonio-2018

Description: Incidents of gun violence in San Antonio in 2018 according to the Gun Violence Archive.

2) Weather Underground -- San Antonio, TX Calendar | Weather Underground
https://www.wunderground.com/calendar/us/tx/san-antonio/KSAT/date/2018

Description: Weather Undergrond provides local & long range weather forecasts, weather reports, maps & tropical weather conditions for locations worldwide.

## **E**xtract:

The gun violence data from data.world was a "clean" dataset that was availale to download as a Microsoft Excel file. We initially intended to extract weather data from the OpenWeatherMap API; however, we decided to challenge ourselves with scraping the required data from the Weather Underground website instead. The data on the Weather Underground website was presented in the form of a monthly calendar, which included the day of the month, weather condition, maximum and minimum temperatures (°F), and amount of precipitation (in.).

![alt text](https://github.com/georgebendele/etl_project/blob/master/img/weatherunderground.png?raw=true)

To extract the data, we used Splinter with Chromedriver to iterate through the months of interest (April-June, 2018). We used BeautifulSoup to parse the HTML and create BeautifulSoup elements containing only the code associated with each calendar instance and then looped through these elements to identify (by class) and extract the data as text that could be stored in list variables. The date data extracted with the weather data was just the day of the month, so we created an associated month column that was derived from the same month variable used to build the url for each calendar call. The lists of weather data were then converted to an integrated dataframe using Pandas, and the dataframe was exported to csv.

Issues: The HTML that was being returned from our weather-data scraping was inconsistent due to the time the webpage took to load the data (e.g., from API calls). To get around this, we created a while loop to continue looking for the desired data until the result was non-empty.

## **T**ransform:

The gun violence Excel file and the weather data csv were read into a Jupyter Notebook. The weather data had a duplicate index column read in from the csv, so this column was dropped. Since the gun violence data was already clean, we opted to transform the weather data to conform to the formatting of the gun violence data in order to merge the two datasets. The dates associated with the weather data were transformed by adding zeros before the single-digit day and month integers, then concatenating these day and month columns together with the year into a new column with formatting that matched the gun violence data (yyyy-mm-dd). This column was then transformed to a datetime data type. The two datasets were then merged on datetime.

## **L**oad:

The resulting merged data was placed in a MySQL database using pymysql. Since the datasets were matched by date, without missing values, we decided that an SQL database was optimal.

## **C**onclusion:

The premise for this exercise was to determine any correlations between daily temperatures and gun violence incidence. The a linear regression line through the scatter plot of temperature highs and violent incidents in San Antonio between April and June 2018 shows a slightly negative correlation. However, no conclusive conclusion can be made of correlation or non-correlation, primarily because of the limited dataset.
![alt text](https://github.com/georgebendele/etl_project/blob/master/img/temp_vs_violence.png?raw=true)