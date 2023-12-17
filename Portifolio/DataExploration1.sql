SELECT *
FROM CovidDeaths

SELECT *
FROM CovidVaccinations

-- Select Data used
SELECT location, date, total_cases, new_cases, total_deaths,population
FROM CovidDeaths
ORDER BY 1,2

-- Atempting to Convert Columns from nvarchar to int
ALTER TABLE CovidDeaths
ALTER COLUMN hosp_patients_per_million float

ALTER TABLE CovidDeaths
ALTER COLUMN weekly_icu_admissions float

ALTER TABLE CovidDeaths
ALTER COLUMN weekly_icu_admissions_per_million float

ALTER TABLE CovidDeaths
ALTER COLUMN weekly_hosp_admissions float

ALTER TABLE CovidDeaths
ALTER COLUMN weekly_hosp_admissions_per_million float

-- Convert CovidVaccinations table
ALTER TABLE CovidVaccinations
ALTER COLUMN hospital_beds_per_thousand float

ALTER TABLE CovidVaccinations
ALTER COLUMN life_expectancy float

ALTER TABLE CovidVaccinations
ALTER COLUMN human_development_index float

ALTER TABLE CovidVaccinations
ALTER COLUMN excess_mortality_cumulative_absolute float

ALTER TABLE CovidVaccinations
ALTER COLUMN excess_mortality_cumulative float

ALTER TABLE CovidVaccinations
ALTER COLUMN excess_mortality float

ALTER TABLE CovidVaccinations
ALTER COLUMN excess_mortality_cumulative_per_million float

-- Total cases vs Total deaths
SELECT Location, date, total_cases, total_deaths, (total_deaths / total_cases *100) as DeathPercentage
FROM CovidDeaths
ORDER BY 1,2

-- Total cases vs Total deaths in Brazil
SELECT Location, date, total_cases, total_deaths, (total_deaths / total_cases *100) as DeathPercentage
FROM CovidDeaths
WHERE location = 'Brazil'
ORDER BY 1,2

-- Looking at Total Cases vs Population
-- Shows percentage of population got Covid in Brazil
-- Obs.: Bad thing is that population number does not change
SELECT Location, date, population, total_cases, (total_cases/ population*100) as PercentageOfPopulationInfected
FROM CovidDeaths
WHERE location = 'Brazil'
ORDER BY 1,2

-- Countries with Highest Death Count
SELECT Location, MAX(total_deaths) as HighestDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY Location
ORDER BY HighestDeathCount desc

-- Countries with Highest Infection Rate compared to Population
SELECT Location, population, MAX(total_cases) as HighestInfectionCount, MAX(total_cases/ population*100) as PercentageOfPopulationInfected
FROM CovidDeaths
GROUP BY location, population
ORDER BY PercentageOfPopulationInfected desc

-- Continents with Highest Death Count (Difference between using location and continent(Apparently using location is the correct number))
SELECT Location, MAX(total_deaths) as HighestDeathCount
FROM CovidDeaths
WHERE continent is null
GROUP BY Location
ORDER BY HighestDeathCount desc

SELECT continent, MAX(total_deaths) as HighestDeathCount
FROM CovidDeaths
WHERE continent is not null
GROUP BY continent
ORDER BY HighestDeathCount desc

-- Global Numbers
SELECT date, SUM(new_cases) as CasesInDay,
SUM(cast(new_deaths as float)) as DeathsInDay,
(SUM(cast(new_deaths as float))/NULLIF(SUM(new_cases), 0)) * 100 AS DeathPercentage
FROM CovidDeaths
WHERE continent is not null
GROUP BY date
ORDER BY 1,2