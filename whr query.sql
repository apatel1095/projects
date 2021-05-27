use [whr project]
go

-- Top 5 happiest countries 
SELECT TOP 5 *
FROM dbo.['world-happiness-report$']

-- Top 5 least happiest countries
SELECT TOP 5 *
FROM dbo.['world-happiness-report$']
ORDER BY [Ladder score] ASC

-- Rank of happiest countries per region 
SELECT *,
RANK() OVER (PARTITION BY [Regional indicator] ORDER BY [Ladder score] DESC) AS [Rank per region]
FROM dbo.['world-happiness-report$']

-- Rank of least happiest countries per region 
SELECT *,
RANK() OVER (PARTITION BY [Regional indicator] ORDER BY [Ladder score] ASC) AS [Rank per region]
FROM dbo.['world-happiness-report$']

-- Longest life expectancy compared to overall happiness
SELECT [Healthy life expectancy], [Country name], [Ladder score],
RANK() OVER (PARTITION BY [Ladder score] ORDER BY [Healthy life expectancy] DESC) AS [RANK]
FROM dbo.['world-happiness-report$']

-- Top 4 happiest countries per region
WITH whr AS (SELECT *,
RANK() OVER (PARTITION BY [Regional indicator] ORDER BY [Ladder score] DESC) AS [Rank per region]
FROM dbo.['world-happiness-report$'])
SELECT *
FROM whr 
WHERE [Rank per region] <= 4
ORDER BY [Regional Indicator]

--Healthy life expectancy vs happiness
SELECT [Country name], [Healthy life expectancy], [Ladder score],
ROW_NUMBER() OVER(ORDER BY [Healthy life expectancy] DESC) AS [Healthy life expectancy rank],
ROW_NUMBER() OVER(ORDER BY [Ladder score] DESC) AS [Ladder score rank]
FROM dbo.['world-happiness-report$']
ORDER BY [Ladder score rank]

--Perceptions of corruption vs happiness
SELECT [Country name],[Ladder score],[Perceptions of corruption],
ROW_NUMBER() OVER(ORDER BY [Perceptions of corruption] DESC) AS [Corruption rank],
ROW_NUMBER() OVER(ORDER BY [Ladder score] DESC) AS [Ladder score rank]
FROM dbo.['world-happiness-report$']
ORDER BY [Ladder score rank]

--Ranks of each category
SELECT *,
ROW_NUMBER() OVER(ORDER BY [Healthy life expectancy] DESC) AS [Healthy life expectancy rank],
ROW_NUMBER() OVER(ORDER BY [Ladder score] DESC) AS [Ladder score rank],
ROW_NUMBER() OVER(ORDER BY [Perceptions of corruption] DESC) AS [Corruption rank],
ROW_NUMBER() OVER(ORDER BY [Logged GDP per capita] DESC) AS [GDP rank],
ROW_NUMBER() OVER(ORDER BY [Social support] DESC) AS [Social support rank],
ROW_NUMBER() OVER(ORDER BY [Freedom to make life choices] DESC) AS [Freedom rank],
ROW_NUMBER() OVER(ORDER BY [Generosity] DESC) AS [Generosity rank]
FROM dbo.['world-happiness-report$']
ORDER BY [Ladder score rank]