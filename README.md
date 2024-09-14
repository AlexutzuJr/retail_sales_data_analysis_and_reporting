# Project Overview

This project focuses on analyzing retail orders data to derive insights on product sales, profits, and trends using Python and SQL. The dataset is sourced from Kaggle and stored in an SQL Server database for more in-depth analysis.

**Project Steps**
* Data loading and cleaning
* Feature engineering
* Data transformation
* Data storage
* SQL queries

# Local Setup

## Installation

To set up the environment and run the project, follow these steps:

* Ensure that you have the following Python packages installed: pip install pandas sqlalchemy kaggle pyodbc
* Download the retail orders dataset from Kaggle: kaggle datasets download ankitbansal06/retail-orders -f orders.csv

# Usage
Running the Jupyter Notebook:

* Open and run the orders_data_analysis.ipynb notebook.
* This will load, clean, and process the dataset, then upload it to the SQL Server database.
  
Running the SQL Queries:

* Open the sql_code.sql file in your SQL Server Management Studio (SSMS) or any SQL client.
* Execute the queries to analyze the data stored in the df_orders table.
