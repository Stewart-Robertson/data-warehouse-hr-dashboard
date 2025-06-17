/*

************************************************************
Create Snowflake Storage Integration and Stage
************************************************************

The purpose of this script:
    - Create a storage integration between Snowflake and the AWS S3 bucket containing the HR data
    - Create the Snowflake stage for the HR Analytics database.

 */


USE DATABASE HR_ANALYTICS;
USE SCHEMA BRONZE;



CREATE STORAGE INTEGRATION S3_INTEGRATION_HR_ANALYTICS
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = S3
    ENABLED = TRUE
    STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::493249671090:role/snowflake_role_HR_analytics'
    STORAGE_ALLOWED_LOCATIONS = ('s3://hr-analytics-interworks/');

DESCRIBE INTEGRATION S3_INTEGRATION_HR_ANALYTICS;


GRANT USAGE ON INTEGRATION S3_INTEGRATION_HR_ANALYTICS TO ACCOUNTADMIN;


CREATE OR REPLACE STAGE HR_ANALYTICS.BRONZE.STAGE
    STORAGE_INTEGRATION = S3_INTEGRATION_HR_ANALYTICS
    URL = 's3://hr-analytics-interworks/'
    FILE_FORMAT = (
        TYPE = CSV 
        FIELD_DELIMITER = ',' 
        SKIP_HEADER = 1
        FIELD_OPTIONALLY_ENCLOSED_BY = '"' -- in case some values contain commas
    );

GRANT USAGE ON STAGE HR_ANALYTICS.BRONZE.STAGE TO ROLE ACCOUNTADMIN;

GRANT ALL PRIVILEGES ON FUTURE TABLES IN SCHEMA HR_ANALYTICS.BRONZE TO ROLE ACCOUNTADMIN;

DESC STAGE HR_ANALYTICS.BRONZE.STAGE;