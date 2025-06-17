/*

************************************************************
Procedure: Load Bronze Layer Tables
************************************************************

The purpose of this script.
    - This SQL/Python script defines the procedure to load the bronze layer tables.
    - Running this script will re-define the procedure.
    - The procedure will truncate the bronze layer table before loading the data into the bronze table
    - The procedure is written in Python and uses the Snowpark Python API

Data Source:
    - The data is loaded from an S3 bucket in AWS
    - This uses a storage integration to access the S3 bucket
    - See create_snowflake_stage.sql for stage and storage integration setup

************************************************************
                        WARNING
************************************************************

    - This script will TRUNCATE the bronze layer tables and load the data from the bronze stage.
    - Use with caution, and ensure that all relevant data is backed up before running the script.

 */

USE ROLE ACCOUNTADMIN;
CREATE OR REPLACE PROCEDURE HR_ANALYTICS.BRONZE.load_data()
RETURNS STRING -- Confirmation/error message
-- Set language to Python
LANGUAGE PYTHON
RUNTIME_VERSION = '3.12'
-- Snowpark Python API required to access Snowflake functionality
PACKAGES = ('snowflake-snowpark-python')
-- Handler function name
HANDLER = 'run'
EXECUTE AS OWNER
AS
$$
def run(session):
    try:
        session.sql("TRUNCATE TABLE HR_ANALYTICS.BRONZE.EMPLOYEES").collect()
        session.sql("""
            COPY INTO HR_ANALYTICS.BRONZE.EMPLOYEES
            FROM @HR_ANALYTICS.BRONZE.STAGE/HR_Data.csv
            ON_ERROR = 'ABORT_STATEMENT'
            """).collect()
        return "Successfully loaded data"
    except Exception as e:
        return f"Error occurred: {str(e)}"
$$;

CALL HR_ANALYTICS.BRONZE.load_data();

        