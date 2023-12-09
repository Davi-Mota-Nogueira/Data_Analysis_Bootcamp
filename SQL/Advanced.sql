/*
-- CTEs
*/
WITH CTE_Employee AS (
SELECT FirstName, LastName, Gender, Salary
,COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender
,AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary
FROM EmployeeDemographics Emp
JOIN EmployeeSalary Sal
	ON Emp.EmployeeId = Sal.EmployeeId
WHERE Salary > '45000'
)
SELECT *
FROM CTE_Employee

/*
-- Temp Tables
*/
CREATE TABLE #table_Employee (
	EmployeeId int,
	JobTitle varchar(100),
	Salary int
)

INSERT INTO #table_Employee 
VALUES (1001, 'HR', 45000)

SELECT * FROM #table_Employee

INSERT INTO #table_Employee
SELECT *
FROM EmployeeSalary

DROP TABLE IF EXISTS #Temp_Employee2
CREATE TABLE #Temp_Employee2 (
	JobTitle varchar(50),
	EmployeePerJob int,
	AvgAge int,
	AvgSalary int
)

INSERT INTO #Temp_Employee2
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics Emp
JOIN EmployeeSalary Sal
	ON Emp.EmployeeId = Sal.EmployeeId
GROUP BY JobTitle

SELECT *
FROM #Temp_Employee2

/*
-- String Functions (TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOWER)
*/

DROP TABLE IF EXISTS EmployeeErrors
CREATE TABLE EmployeeErrors (
	EmployeeId varchar(50),
	FirstName varchar(50),
	LastName varchar(50)
)						

INSERT INTO EmployeeErrors 
VALUES 
('1001  ', 'jIMBO', 'Halbert'),
('  1002', 'Pamela', 'Beasly'),
('1005', 'T0by', 'Flanderson - Fired')

SELECT *
FROM EmployeeErrors

---- Using TRIM, LTRIM, RTRIM
SELECT EmployeeId, TRIM(EmployeeId) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeId, LTRIM(EmployeeId) AS IDTRIM
FROM EmployeeErrors

SELECT EmployeeId, RTRIM(EmployeeId) AS IDTRIM
FROM EmployeeErrors

---- Using REPLACE
SELECT LastName, REPLACE(LastName, '- Fired','') AS LastNameFixed
FROM EmployeeErrors

---- Using Substring
SELECT SUBSTRING(FirstName,1,3)
FROM EmployeeErrors

SELECT err.FirstName, SUBSTRING(err.FirstName,1,3), Dem.FirstName, SUBSTRING(Dem.FirstName,1,3)
FROM EmployeeErrors Err
JOIN EmployeeDemographics Dem
	ON SUBSTRING(err.FirstName, 1, 3) = SUBSTRING(dem.FirstName, 1, 3)


---- Using UPPER and lower
SELECT FirstName, LOWER(FirstName)
FROM EmployeeErrors

SELECT FirstName, UPPER(FirstName)
FROM EmployeeErrors

/*
-- Stored Procedures
*/

CREATE PROCEDURE TEST
AS
SELECT *
FROM EmployeeDemographics

EXEC TEST

CREATE PROCEDURE Temp_Employee
AS
CREATE TABLE #temp_employee(
JobTitle varchar(100),
EmployeePerJob int,
AvgAge int,
AvgSalary int
)

INSERT INTO #temp_employee
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics Emp
JOIN EmployeeSalary Sal
	ON Emp.EmployeeId = Sal.EmployeeId
GROUP BY JobTitle

SELECT *
FROM #temp_employee

EXEC Temp_Employee @JobTitle = 'Salesman'

/*
-- Subqueries
*/

SELECT *
FROM EmployeeSalary

---- Subquary in SELECT

SELECT EmployeeId, Salary, (SELECT AVG(Salary) FROM EmployeeSalary) AS AllAvgSalary
FROM EmployeeSalary

---- How to do it with PARTITION BY

SELECT EmployeeId, Salary, AVG(Salary) OVER () AS AllAvgSalary
FROM EmployeeSalary

---- Why GROUP BY doesn't work

SELECT EmployeeId, Salary, AVG(Salary) as AllAvgSalary
FROM EmployeeSalary
GROUP BY EmployeeId, Salary
ORDER BY 1,2

---- Subquery in FROM

SELECT a.EmployeeId, AllAvgSalary
FROM (SELECT EmployeeId, Salary, AVG(Salary) OVER() AS AllAvgSalary
	  FROM EmployeeSalary) a

---- Subquery in WHERE

SELECT EmployeeId, JobTitle, Salary
FROM EmployeeSalary
WHERE EmployeeId in (
			SELECT EmployeeId
			FROM EmployeeDemographics
			WHERE Age > 30)
