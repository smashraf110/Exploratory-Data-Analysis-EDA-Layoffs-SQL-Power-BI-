# Exploratory-Data-Analysis-EDA-Layoffs-SQL-Power-BI-

<img width="1308" height="741" alt="Image" src="https://github.com/user-attachments/assets/0c7ac5c0-bc37-4824-91ae-50980e1eae56" />

## Subtitle:
A portfolio project using a real, publicly available dataset, showcasing SQL-based exploratory data analysis and visual storytelling through Power BI.
By Shoeb Md Ashraf


## Project Overview
This exploratory data analysis project investigates the global wave of tech layoffs during and after the COVID-19 pandemic, using a publicly available dataset sourced from Layoffs.fyi. The aim is to uncover patterns across time, geography, industries, company stages, and funding levels.
It also includes interactive dashboards to illustrate key findings for business decision-makers and job seekers.

## Key Steps:
  ➣ Data understanding and exploration using SQL
  ➣ Structured queries to answer business questions
  ➣ Data cleaning and transformation
  ➣ Visualization and storytelling with Power BI
  ➣ Interpretation of patterns and anomalies


## 🔍SQL-Based Analysis:

## Question 1: What are the layoff trends over time?
## Purpose: To understand macro-level patterns of the Tech Layoffs (spikes, slowdowns)
## SQL Concepts: GROUP BY month, rolling sum using window functions
## Insight:
🔺Layoffs surged sharply from mid-2022, peaking in January 2023, indicating a widespread correction across the tech industry.

-  - - - 
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

-  - - - 

## Question 2: Which countries were affected the most by layoffs?
## Purpose: To Identify regions hit hardest
## SQL Concepts: GROUP BY, SUM, ORDER BY
## Insight:
🌎 The United States accounted for nearly 70% of total layoffs, indicating a US-centric concentration of the tech layoffs.

-  - - - 
SELECT 
  country, 
  SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_duplicate_2
GROUP BY country
ORDER BY Total_Laid_Off DESC;
-  - - - 

## Question 3: Which companies laid off the most employees over time?
## Purpose: To Identify consistently high layoff contributors per year
## SQL Concepts: CTE, DENSE_RANK(), PARTITION BY
## Insight:
💼 Meta and Amazon led in 2022 layoffs, while Google and Microsoft dominated in 2023. Some companies appeared consistently across both years.

-  - - - 
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

-  - - - 

## Question 4: Are startups in later funding stages more likely to lay off employees?
## Purpose: To look for Funding stage vs layoff intensity – shows risks at Series C+, etc.
## SQL Concepts: GROUP BY stage
## Insight:
💸 Post-IPO companies were responsible for nearly 59% of layoffs, highlighting that even mature startups were not immune to market corrections.

-  - - - 
SELECT 
  stage, 
  SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_duplicate_2
GROUP BY stage
ORDER BY Total_Laid_Off DESC;
-  - - - 

## Question 5: Which industries had the most layoffs?
## Purpose: Spot industry-wide instability (e.g., tech, crypto, finance)
## SQL Concepts: GROUP BY industry
## Insight:
🏭 Consumer and Retail Tech were hit hardest, each accounting for around 24% of total layoffs, followed by Transportation and Crypto.

-  - - - 
SELECT 
  industry, 
  SUM(total_laid_off) AS Total_Laid_Off
FROM layoffs_duplicate_2
GROUP BY industry
ORDER BY Total_Laid_Off DESC;
-  - - - 

## Question 6: Companies with high layoff % despite raising large funds?
## Purpose: To Detect possible mismanagement or overhiring
## SQL Concepts: GROUP BY industry
## Insight:
🧾 Companies that laid off 50–100% of staff despite raising significant funding may signal poor resource allocation or unsustainable growth models.

-  - - - 
SELECT 
  company, 
  total_laid_off, 
  percentage_laid_off, 
  funds_raised_millions
FROM layoffs_duplicate_2
WHERE percentage_laid_off >= 0.5
ORDER BY funds_raised_millions DESC
limit 20;
-  - - - 


## 📊 Power BI Dashboard Highlights

## Visuals:

🟦 Line Chart: Monthly Layoffs
Insight: Layoffs peaked in January 2023 with over 24% of the total recorded layoffs in a single month.

🟥 Stacked Bar Chart: Top 5 Affected Countries
Insight: The US alone contributed ~70% of all layoffs, followed distantly by India and Canada.

🟨 Pie Chart: Industries Most Affected
Insight: Consumer and Retail industries each contributed ~24% of total layoffs.

🟩 Clustered Column Chart: Companies with Most Layoffs Over Time
Insight: Meta and Amazon led layoffs in 2022; Google and Microsoft in 2023, showing a shift in organizational strategies.

🟪 Line Chart: Layoff Ratio vs. Funds Raised
Insight: Companies with high funds (> $500M) still laid off 85–100% of staff, while some with less funding completely shut down. Raises the question: mismanagement or overambition?

🟫 Column Chart: Layoffs by Company Stage
Insight: Post-IPO companies represent nearly 59% of layoffs, emphasizing pressure even after public market entries.
____________________________________________________________________________

## 🧠 Key Insights Summary:
  ➣ January 2023 recorded the highest layoffs in recent years.
  ➣ Tech, Consumer, and Crypto were the most vulnerable sectors.
  ➣ Post-IPO startups laid off the most, indicating that market maturity didn’t safeguard them.
  ➣ The US was disproportionately affected, contributing to almost 70% of global tech layoffs.
  ➣ Several highly funded startups still laid off massive percentages of their workforce, hinting at flawed strategies or market overvaluation.


## 🔗 Connect with Me
I'm always excited to connect with fellow data enthusiasts, professionals, and collaborators.

- 💼 [**LinkedIn – Shoeb Md Ashraf**](https://www.linkedin.com/in/shoebmdashraf)  
- 🌐 [**GitHub – smashraf110**](https://github.com/smashraf110)  
- 📧 **Email:** smashraf110@gmail.com

Let’s build something meaningful together—reach out anytime!

## Note This portfolio project uses a public dataset for demonstration and practical learning of SQL, Excel and Power BI modeling and reporting.
