SELECT *
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 3,4


-- Select Data that we are going to be using
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
ORDER BY 1, 2

-- Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract COVID in your country
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
AND continent IS NOT NULL
ORDER BY 1, 2

-- Total Cases vs Population
-- Shows what percentage of population has contracted COVID
SELECT location, date, population, total_cases, (total_cases/population)*100 AS case_percentage
FROM PortfolioProject..CovidDeaths
WHERE location like '%states%'
ORDER BY 1, 2

-- Countries with Highest Infection Rate compared to Population
SELECT location, population, date, MAX(total_cases) AS highest_infection_count, MAX(total_cases/population)*100 AS infected_population_percentage
FROM PortfolioProject..CovidDeaths
GROUP BY location, population, date
ORDER BY infected_population_percentage DESC

-- Countries with Highest Death Count per Population
SELECT location, SUM(cast(new_deaths AS int)) AS total_death_count
FROM PortfolioProject..CovidDeaths
WHERE continent IS NULL
AND location NOT IN ('World', 'European Union', 'International')
AND location NOT LIKE '%income%'
GROUP BY location
ORDER BY total_death_count DESC



-- BREAKING THINGS DOWN BY CONTINENT

-- Continents with  Highest Death Count per Population
SELECT continent, SUM(CAST(total_deaths AS int)) AS total_death_count
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC

-- Continents with Highest Infection Count per Population
SELECT continent, SUM(total_cases) AS highest_infection_count
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY highest_infection_count DESC


-- GLOBAL NUMBERS
SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(CAST(new_deaths AS int))/SUM(new_cases)*100 AS death_percentage
FROM PortfolioProject..CovidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1, 2


-- Total Population vs Total Vaccinations
-- Shows Percentage of Population that has received at least one COVID Vaccine
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(int,vac.new_vaccinations)) OVER (PARTITION BY dea.location
	ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
ORDER BY 2, 3


-- USE CTE to perform calculation on Partition By in previous query
WITH pop_vs_vac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated)
AS
(
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (PARTITION BY dea.location
	ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL
)

SELECT *, (rolling_people_vaccinated/population)*100
FROM pop_vs_vac



-- TEMP TABLE to perform Calculation on Partition By in previous query
DROP TABLE IF EXISTS #percent_population_vaccinated

CREATE TABLE #percent_population_vaccinated
(continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rolling_people_vaccinated numeric)

INSERT INTO #percent_population_vaccinated
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (PARTITION BY dea.location
	ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

SELECT *, (rolling_people_vaccinated/population)*100
FROM #percent_population_vaccinated


-- Creating View to store date for later visualizations
CREATE VIEW percent_population_vaccinated AS
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	SUM(CONVERT(bigint,vac.new_vaccinations)) OVER (PARTITION BY dea.location
	ORDER BY dea.location, dea.date) AS rolling_people_vaccinated
FROM PortfolioProject..CovidDeaths dea
JOIN PortfolioProject..CovidVaccinations vac
	ON dea.location = vac.location
	AND dea.date = vac.date
WHERE dea.continent IS NOT NULL

SELECT *
FROM percent_population_vaccinated
