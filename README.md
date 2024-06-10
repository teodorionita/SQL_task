# Data Processing SQL Test

This repository contains scripts to generate test data, process it using BigQuery, and create a pivot table from the nested JSON data.

## Contents

- `normalize_table.sql`: SQL script requested by task to normalize and pivot the data.
- `generate_test_data.py`: Python script to generate test data.
- `sample_data.json`: Example of generated test data (can overwrite with script to test).
- `bigquery_result.csv`: Example of table generated after SQL script is run.

## Prerequisites

- Python 3.x installed.
- Access to a Google BigQuery project.

## Setup Instructions

### Step 1: Generate Test Data

1. **Run the Python Script**

   Open a terminal and navigate to the directory containing `generate_test_data.py`. Run the script to generate the test data.

   ```bash
   python3 generate_test_data.py
