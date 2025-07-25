

-- Monthly Layoffs Trend
WITH Monthly_Layoffs AS (
  SELECT 
    SUBSTRING(`date`, 1, 7) AS `Month`, 
    SUM(total_laid_off) AS Total_Laid_Off
  FROM layoffs_duplicate_2
  GROUP BY `Month`
)
SELECT 
  `Month`, 
  Total_Laid_Off,
  SUM(Total_Laid_Off) OVER (ORDER BY `Month`) AS Rolling_Total
FROM Monthly_Layoffs
where `Month` is not null
ORDER BY `Month`;

-- Most affected countries from the Layoffs
SELECT 
  country, 
  SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_duplicate_2
GROUP BY country
ORDER BY Total_Laid_Off DESC;


-- Top 10 companies with most layoffs each year
WITH Company_Year AS (
  SELECT 
    company, 
    YEAR(`date`) AS `Year`, 
    SUM(total_laid_off) AS Total_Laid_Off
  FROM layoffs_duplicate_2
  GROUP BY company, `Year`
), Ranked_Companies AS (
  SELECT 
    *, 
    DENSE_RANK() OVER (PARTITION BY `Year` ORDER BY Total_Laid_Off DESC) AS Ranking
  FROM Company_Year
  WHERE `Year` IS NOT NULL
)
SELECT *
FROM Ranked_Companies
WHERE Ranking <= 10
ORDER BY `Year`, Ranking;

-- Are Startups in Later Funding Stages more likely to Layoff employees?
SELECT 
  stage, 
  SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_duplicate_2
GROUP BY stage
ORDER BY Total_Laid_Off DESC;

#--Which industries had the most Layoffs
SELECT 
  industry, 
  SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_duplicate_2
GROUP BY industry
ORDER BY Total_Laid_Off DESC;

-- Which companies had the highest layoff despite raising large funds
SELECT 
  company, 
  total_laid_off, 
  percentage_laid_off, 
  funds_raised_millions
FROM layoffs_duplicate_2
WHERE percentage_laid_off >= 0.5
ORDER BY funds_raised_millions DESC
limit 20;
## Top 20 highest funds raised all companies have more than 50% layoff rate


