-- Variables 
DECLARE dataset_name STRING DEFAULT 'test_data';
DECLARE target_table_name STRING DEFAULT 'target_table';
DECLARE full_target_table_name STRING DEFAULT CONCAT(dataset_name, '.', target_table_name);
DECLARE unique_keys ARRAY<STRING>;
DECLARE query STRING;
DECLARE duplicate_uuid_count INT64;

-- Check for duplicate UUIDs and raise an error if it's true
SET duplicate_uuid_count = (
  SELECT COUNT(uuid)
  FROM (
    SELECT uuid
    FROM test_data.sample_data
    GROUP BY uuid
    HAVING COUNT(*) > 1
  )
);

IF duplicate_uuid_count > 0 THEN
  RAISE USING MESSAGE = FORMAT("Error: Found %d duplicate UUIDs.", duplicate_uuid_count);
END IF;

-- Extract unique keys from the properties
SET unique_keys = (
  SELECT ARRAY_AGG(DISTINCT property.key ORDER BY property.key)
  FROM test_data.sample_data,
  UNNEST(properties) AS property
);

-- Construct the dynamic SQL query to create or replace the pivot table
SET query = "SELECT uuid, ";

-- Dynamically append columns for each key in the SELECT statement
FOR key_struct IN (SELECT AS STRUCT key FROM UNNEST(unique_keys) AS key) DO
  SET query = CONCAT(query, FORMAT(
    "MAX(IF(property.key = '%s', COALESCE(property.value.value, CAST(property.value.numerical_value AS STRING)), NULL)) AS `%s`, ",
    key_struct.key, key_struct.key
  ));
END FOR;

-- Remove the last comma and concat query to execute
SET query = CONCAT(RTRIM(query, ', '), " FROM test_data.sample_data, UNNEST(properties) AS property GROUP BY uuid");

-- Dynamically construct final query to create or replace the target table
EXECUTE IMMEDIATE FORMAT("CREATE OR REPLACE TABLE %s AS %s", full_target_table_name, query);