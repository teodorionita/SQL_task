# Data Processing SQL Test

This repository contains scripts to generate test data, process it using BigQuery, and create a pivot table from the nested JSON data. The requested task can be found under `normalize_table.sql`.

## Contents

- `normalize_table.sql`: SQL script requested by task to normalize and pivot the data.
- `random_data_generator.py`: Python script to generate test data.
- `sample_data.json`: Example of generated test data (can overwrite with script to test).
- `bigquery_result.csv`: Example of table generated after SQL script is run.

## Prerequisites

- Python 3.x installed.
- Access to a Google BigQuery console.

## Setup Instructions

### Step 1: Clone the GitHub Repository

   Open a terminal and run the following command to clone the repository:

   ```bash
   gh repo clone teodorionita/SQL_task
   ```

### Step 2: Generate Test Data

   Open a terminal and navigate to the directory containing `random_data_generator.py`. Run the script to generate the test data.

   ```bash
   python3 random_data_generator.py
   ```

### Step 3: Upload Test Data to BigQuery

Open the BigQuery Console and create a new dataset called `test_data`.

Create a new table within your dataset called `sample_data` and upload the `sample_data.json` file. Make sure to configure the schema to auto detect to match the structure of the generated JSON data.

### Step 4: Run the SQL Script

In the BigQuery console paste and run the SQL script `normalize_table.sql`.


**NOTE:** For script simplicity the source dataset and table names have not been formated. Please maintain the same names for the script to work or update the names appropriately.

