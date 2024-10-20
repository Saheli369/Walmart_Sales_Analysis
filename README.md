# Walmart_Sales_Analysis
 # About
 This project focuses on analyzing sales data from a retail store, including key metrics such as total sales, customer demographics, and product performance. The dataset includes information on sales transactions, customer details, and product categories, allowing for a detailed analysis of trends and patterns.



# Technologies used
PostgreSQL



# About Data
The dataset was obtained from the [Kaggle Walmart Sales Forecasting Competition](https://www.kaggle.com/). This dataset contains sales transactions from a three different branches of Walmart, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows


# Approach Used
Data Wrangling: This is the first step where inspection of data is done to make sure NULL values and missing values are detected and data replacement methods are used to replace, missing or NULL values.
Build a database
Create table and insert the data.
Select columns with null values in them. There are no null values in our database as in creating the tables, we set NOT NULL for each field, hence null values are filtered out.
Feature Engineering: This will help use generate some new columns from existing ones.
Add a new column named time_of_day to give insight of sales in the Morning, Afternoon and Evening. This will help answer the question on which part of the day most sales are made.
Add a new column named day_name that contains the extracted days of the week on which the given transaction took place (Mon, Tue, Wed, Thur, Fri). This will help answer the question on which week of the day each branch is busiest.
Add a new column named month_name that contains the extracted months of the year on which the given transaction took place (Jan, Feb, Mar). Help determine which month of the year has the most sales and profit.
Exploratory Data Analysis (EDA): Exploratory data analysis is done to answer the listed questions and aims of this project.

Conclusion:
