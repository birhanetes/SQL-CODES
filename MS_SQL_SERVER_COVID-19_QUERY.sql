-- Covid 19 ms sql query

select *
from Portfolio_Project.dbo.CovidDeaths$
order by 3, 4;-- ->order by col 

--Select data to be starting with
Select Location, date, total_cases, new_cases, total_deaths, population
From Portfolio_Project.dbo.CovidDeaths$
Where continent is not null 
order by 1,2;

-- Total cases Vs Total deaths in the UAE
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 As death_to_case_ratio
From Portfolio_Project.dbo.CovidDeaths$
Where location like '%emirates%' And continent is not null 
order by 1,2;


-- Total Cases vs Population: What percentage of population infected with Covid
Select Location, date, total_cases, population, (total_cases/population)*100 As percentage_ppl_infected
From Portfolio_Project.dbo.CovidDeaths$
Where location like '%emirates%' And continent is not null 
order by 1,2;

-- Total cases Vs Total deaths in Eritrea
Select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 As death_to_case_ratio
From Portfolio_Project.dbo.CovidDeaths$
Where location = 'Eritrea' And continent is not null 
order by 1,2;

-- Total Cases vs Population: What percentage of population infected with Covid
Select Location, date, total_cases, population, (total_cases/population)*100 As percentage_ppl_infected
From Portfolio_Project.dbo.CovidDeaths$
Where location ='Eritrea' And continent is not null 
order by 1,2;

-- Countries with Highest Infection Rate compared to Population
Select Location, Population, MAX(total_cases) as highest_infection_count,  Max((total_cases/population))*100 as Percent_population_infected
From Portfolio_Project.dbo.CovidDeaths$
Group by Location, Population
order by Percent_population_infected desc;

-- Which countries are with Highest number death
Select Location, MAX(cast(total_deaths as int)) as total_death_count
From Portfolio_Project.dbo.CovidDeaths$
Where continent is not null 
Group by Location
order by total_death_count desc;


-- Which contintents have the highest number of deaths
Select continent, MAX(cast(total_deaths as int)) as total_death_count
From Portfolio_Project.dbo.CovidDeaths$
Where continent is not null 
Group by continent
order by total_death_count desc;

-- Worldwide new number of cases
Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as death_percentage
From Portfolio_Project.dbo.CovidDeaths$
where continent is not null 
order by 1,2;


--Total Population vs Vaccinations: What percentage of population recieved at least one Covid Vaccine
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From Portfolio_Project.dbo.CovidDeaths$ d
Join Portfolio_Project.dbo.CovidDeaths$ v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
order by 2,3; 


-- Use CTE to perform Calculation on Partition By for the previous query
With Pop_vac (Continent, Location, Date, Population, New_vaccinations, Rolling_people_vaccinated)
as
(
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as Rolling_people_vaccinated
--, (Rolling_people_vaccinated/population)*100
From Portfolio_Project.dbo.CovidDeaths$ d
Join Portfolio_Project.dbo.CovidVaccinations$ v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null 
)
Select *, (Rolling_people_vaccinated/Population)*100
From Pop_vac;


-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #Percent_population_vaccinated
Create Table #Percent_population_vaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Rolling_people_vaccinated numeric
);

Insert into #Percent_population_vaccinated
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as Rolling_people_vaccinated
--, (RollingPeopleVaccinated/population)*100
From Portfolio_Project.dbo.CovidDeaths$ d
Join Portfolio_Project.dbo.CovidVaccinations$ v
	On d.location = v.location
	and d.date = v.date
Select *, (Rolling_people_vaccinated/Population)*100
From #Percent_population_vaccinated;



-- Create View to store data for later visualizations
Create View Percent_population_vaccinated as
Select d.continent, d.location, d.date, d.population, v.new_vaccinations
, SUM(CONVERT(int,v.new_vaccinations)) OVER (Partition by d.Location Order by d.location, d.Date) as Rolling_people_vaccinated
--, (Rolling_people_vaccinated/population)*100
From Portfolio_Project.dbo.CovidDeaths$ d
Join Portfolio_Project.dbo.CovidVaccinations$ v
	On d.location = v.location
	and d.date = v.date
where d.continent is not null;

