/*

************************************************************
DDL Script: Initialise the Silver layer table
************************************************************

The purpose of this script:
    - create the Employees table in the Silver layer.

 */

CREATE OR REPLACE TABLE HR_ANALYTICS.SILVER.EMPLOYEES (
    Age INT,
    Attrition VARCHAR(50),
    BusinessTravel VARCHAR(50),
    Department VARCHAR(50),
    DistanceFromHome INT,
    Education VARCHAR(50),
    EducationField VARCHAR(50),
    EmployeeNumber INT,
    EmployeeCount INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(50),
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(50),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    MonthlyIncomeCategory VARCHAR(50),
    NumCompaniesWorked INT,
    OverTime VARCHAR(50),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT    
);