/*
	Creating Database
*/

CREATE DATABASE "SQL Tutorial"
USE "SQL Tutorial"

/*
	Create Tables
*/

DROP TABLE IF EXISTS EmployeeDemographics
CREATE TABLE EmployeeDemographics(
EmployeeId int,
FirstName varchar(50),
LastName varchar(100),
Age int,
Gender varchar(10))

DROP TABLE IF EXISTS EmployeeSalary
CREATE TABLE EmployeeSalary (
EmployeeId int,
JobTitle varchar(50),
Salary int)

DROP TABLE IF EXISTS WareHouseEmployeeDemographics
CREATE TABLE WareHouseEmployeeDemographics(
EmployeeId int,
FirstName varchar(50),
LastName varchar(100),
Age int,
Gender varchar(10))

/*
	Insert data
*/

INSERT INTO EmployeeDemographics
VALUES(1001, 'Jim', 'Halpert', 30, 'Male'),
(1002, 'Pam', 'Beasley', 30, 'Female'),
(1003, 'Dwight', 'Schrute', 29, 'Male'),
(1004, 'Oscar', 'Martinez', 55, 'Male'),
(1005, 'Michael', 'Scott', 35, 'Male'),
(1006, 'Angela', 'Martin', 31, 'Female'),
(1007, 'Phyllis', 'Vance', 42, 'Female'),
(1008, 'Stanley', 'Hudson', 38, 'Male'),
(1009, 'Creed', 'Bratton', 61, 'Male'),
(1010, 'Kevin', 'Malone', 31, 'Male'),
(1011, 'Ryan', 'Howard', 26, 'Male'),
(1012, 'Holly', 'Flax', 31, 'Female'),
(1013, 'Darryl', 'Philbin', NULL, 'Male')
	
/*
	Alter table to put Primary Key(PK)
*/

ALTER TABLE EmployeeDemographics
ADD PRIMARY KEY (EmployeeId)

ALTER TABLE EmployeeSalary
ADD PRIMARY KEY (EmployeeId)