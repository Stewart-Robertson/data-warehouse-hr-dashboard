/*

************************************************************
Procedure: Load Silver Layer Tables
************************************************************

The purpose of this script.
    - This SQL script defines the procedure to load the silver layer table.
    - Running this script will re-define the procedure.
    - The procedure will truncate the silver layer table before loading the data into the silver table

Data Source:
    - The data is loaded from the bronze layer table

************************************************************
                        WARNING
************************************************************

    - This script will TRUNCATE the silver layer table and load the data from the bronze stage.
    - Use with caution, and ensure that all relevant data is backed up before running the script.

 */
CREATE OR REPLACE PROCEDURE HR_ANALYTICS.SILVER.LOAD_SILVER_TABLES()
RETURNS STRING
LANGUAGE SQL
AS
$$
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE HR_ANALYTICS.SILVER.EMPLOYEES';
    
    INSERT INTO HR_ANALYTICS.SILVER.EMPLOYEES (
        Age,
        Attrition,
        BusinessTravel,
        Department,
        DistanceFromHome,
        Education,
        EducationField,
        EmployeeNumber,
        EmployeeCount,
        EnvironmentSatisfaction,
        Gender,
        JobInvolvement,
        JobLevel,
        JobRole,
        JobSatisfaction,
        MaritalStatus,
        MonthlyIncome,
        MonthlyIncomeCategory,
        NumCompaniesWorked,
        OverTime,
        PercentSalaryHike,
        PerformanceRating,
        RelationshipSatisfaction,
        StandardHours,
        StockOptionLevel,
        TotalWorkingYears,
        TrainingTimesLastYear,
        WorkLifeBalance,
        YearsAtCompany,
        YearsInCurrentRole,
        YearsSinceLastPromotion,
        YearsWithCurrManager
    )
    SELECT
        Age,
        Attrition,
        BusinessTravel,
        Department,
        DistanceFromHome,
        CASE Education
            WHEN 1 THEN 'Below College'
            WHEN 2 THEN 'College'
            WHEN 3 THEN 'Bachelor'
            WHEN 4 THEN 'Master'
            WHEN 5 THEN 'Doctor'
        END AS Education,
        EducationField,
        EmployeeNumber,
        EmployeeCount,
        EnvironmentSatisfaction,
        Gender,
        JobInvolvement,
        JobLevel,
        JobRole,
        JobSatisfaction,
        MaritalStatus,
        MonthlyIncome,
        CASE 
            WHEN MonthlyIncome < 5000 THEN 'Low'
            WHEN MonthlyIncome BETWEEN 5000 AND 10000 THEN 'Medium'
            WHEN MonthlyIncome BETWEEN 10000 AND 15000 THEN 'High'
            ELSE 'Top-level'
        END AS MonthlyIncomeCategory,
        NumCompaniesWorked,
        OverTime,
        PercentSalaryHike,
        PerformanceRating,
        RelationshipSatisfaction,
        StandardHours,
        StockOptionLevel,
        TotalWorkingYears,
        TrainingTimesLastYear,
        WorkLifeBalance,
        YearsAtCompany,
        YearsInCurrentRole,
        YearsSinceLastPromotion,
        YearsWithCurrManager
    FROM HR_ANALYTICS.BRONZE.EMPLOYEES;
    
    RETURN 'Successfully loaded silver layer data';
END;
$$;

CALL HR_ANALYTICS.SILVER.LOAD_SILVER_TABLES();



    