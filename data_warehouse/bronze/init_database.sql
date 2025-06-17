/*

************************************************************
SQL Script: Initialize Database
************************************************************

The purpose of this script:
    - initialize the database and create the necessary schemas.

 */

USE ROLE ACCOUNTADMIN;


CREATE OR REPLACE DATABASE HR_ANALYTICS;

CREATE OR REPLACE SCHEMA HR_ANALYTICS.BRONZE;
CREATE OR REPLACE SCHEMA HR_ANALYTICS.SILVER;
CREATE OR REPLACE SCHEMA HR_ANALYTICS.GOLD;

