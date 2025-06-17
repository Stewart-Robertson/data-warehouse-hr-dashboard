/*

************************************************************
Procedure: Load Gold Layer View
************************************************************

The purpose of this script.
    - This SQL script defines the procedure to load the gold layer view.
    - Running this script will re-define the procedure.
    - The procedure will truncate the gold layer view before loading the data into the gold view

Data Source:
    - The data is loaded from the silver layer table

************************************************************
                        WARNING
************************************************************

    - This script will TRUNCATE the gold layer view and load the data from the silver stage.
    - Use with caution, and ensure that all relevant data is backed up before running the script.

 */

CREATE OR REPLACE VIEW HR_ANALYTICS.GOLD.GOLD_VIEW
AS
SELECT
    Age,
    CASE 
        WHEN Age BETWEEN 18 AND 24 THEN '18-24'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        WHEN Age BETWEEN 55 AND 64 THEN '55-64'
        ELSE 'Other'
    END AS AgeCategory,
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
FROM HR_ANALYTICS.SILVER.EMPLOYEES;