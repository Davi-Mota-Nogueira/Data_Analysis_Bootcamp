101. Re-enforcing Skills
========================

## SQL
### Basic:
With SELECT you can use some more statements to change its return:
- Top
- Distinct
- Count
- As
- Max
- Min
- Avg
What to use with the WHERE statement:
- =
- <> ('except')
- <,>
- AND
- OR
- LIKE (You can use some 'wildcards' like regex)
- NULL, NOT NULL
- IN (to make it short, ex.: '...WHERE FirstName = 'Jim' AND FirstName = 'Pam' --> 'WHERE Firstname IN ('Jim', 'Pam'))
Other uses:
- Group by
- Order by (ASC, DESC; Can put numbers instead of column names[starting from 1])
### Intermediate:
- JOINS:
    - (SELECT * FROM [table_name] LEFT OUTER JOIN [other_table] ON [table.id] = [table.id])
    - INNER
    - To make an OUTER JOIN, you must specify: 'Right', 'Left', 'Full' (... FULL OUTER JOIN [table_name])
- UNIONS
    - UNION and UNION ALL (Shows all results)
- Case Statements
    - When using CASE, must put an END
- Updating/Deleting Data
    - (UPDATE [table_name] SET [column] = [value] WHERE [atribute to specific(s) row(s)])
    - (DELETE FROM [table_name]) Deletes all
    - (DELETE FROM [table_name] WHERE [condition])
- Partition By
    - Makes a better GROUP BY, in the table as result
    -   SELECT FirstName, LastName, Age, Salary,
        COUNT(Gender) OVER (PARTITION BY Gender) AS TotalGender
        FROM EmployeeDemographics Dem
        JOIN EmployeeSalary Sal
        	ON Dem.EmployeeId = Sal.EmployeeId
- Data Types
- Aliasing
    - Alias (AS)
- Creating Views
- Having vs Group By statement
- GETDATE()
- Primary Key (PK) vs Foreign Key (FK)
### Advanced
- CTEs (Common Table Expression)
    - Subquary
        - 
    - You can use aggregate functions within it
    - WITH CTE_Employee AS (
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
- SYS Table
- Temp Tables
    - It acts like a normal table;
    - Like a variable to keep a table, instead of running the same query;
- String Functions (TRIM, LTRIM, RTRIM, REPLACE, SUBSTRING, UPPER, LOWER)
    - It is functions, so it does not maintain in the table;
- Regular Expressions
- Stored Procedures
    - You create a procedure to make a query when you put it to execute
    - CREATE PROCEDURE Test
       AS
       SELECT *
       FROM [table_name]
       EXEC Test
- Importing Data from different File Types/Sources
- Exporting Data to different File Types