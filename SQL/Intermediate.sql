
-- Use of JOIN
SELECT JobTitle, AVG(Salary) as 'Average Salary'
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeId = EmployeeSalary.EmployeeId
GROUP BY JobTitle

--Use of UNION

SELECT EmployeeId, FirstName, Age FROM EmployeeDemographics
UNION ALL
SELECT EmployeeId, JobTitle, Salary FROM EmployeeSalary

-- Use of CASE

SELECT FirstName, LastName, JobTitle, Salary,
CASE
	WHEN JobTitle = 'Salesman' THEN Salary + (Salary * 0.1)
	WHEN JobTitle = 'Accountant' THEN Salary + (Salary * 0.05)
	ELSE Salary + (Salary * 0.3)
END AS 'Salary After Raise'
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeId = EmployeeSalary.EmployeeId
ORDER BY JobTitle

-- Having Clause

SELECT JobTitle, COUNT(JobTitle) AS 'Sum'
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeId = EmployeeSalary.EmployeeId
--WHERE COUNT(JobTitle) > 1
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1

SELECT JobTitle, AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
	ON EmployeeDemographics.EmployeeId = EmployeeSalary.EmployeeId
--WHERE COUNT(JobTitle) > 1
GROUP BY JobTitle
HAVING AVG(Salary) > 45000
ORDER BY AVG(Salary)

-- Updating and Deleting Data (UPDATE [] SET)
SELECT * FROM EmployeeDemographics

UPDATE EmployeeDemographics
SET EmployeeId = 1012
WHERE EmployeeId IS NULL

UPDATE EmployeeDemographics
SET Gender = 'Female', Age = 31
WHERE EmployeeId = 1012

DELETE FROM EmployeeDemographics
WHERE EmployeeId = 666

-- Aliasing
SELECT FirstName + ' ' + LastName AS FullName
FROM EmployeeDemographics

SELECT Dem.EmployeeId , Dem.FirstName, Sal.JobTitle, Ware.Age
FROM EmployeeDemographics Dem
LEFT JOIN EmployeeSalary Sal
	ON Dem.EmployeeId = Sal.EmployeeId
LEFT JOIN WareHouseEmployeeDemographics Ware
	ON Dem.EmployeeId = Ware.EmployeeId

SELECT Dem.EmployeeId, Sal.Salary
FROM EmployeeDemographics Dem
LEFT JOIN EmployeeSalary Sal
	ON Dem.EmployeeId = Sal.EmployeeId

-- Partition By
SELECT FirstName, LastName, Age, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
FROM EmployeeDemographics Dem
JOIN EmployeeSalary Sal
	ON Dem.EmployeeId = Sal.EmployeeId
