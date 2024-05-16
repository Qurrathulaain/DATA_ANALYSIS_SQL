# Introduction
The purpose of this project is to analyze job market for Data Analytics ,what are the top paying jobs and what are in-demand skills and the associated salaries for the skills.The SQl queries for the project are here:[sql_project_data_analysis](/sql_project_data_analysis/)


# Project Details
Here have conducted an analysis using  four different datasets. The datasets includes details such as job titles, required skills, average salaries,job location and remote work opportunities to name a few. The SQL query utilized joins,CTEs,filtering conditions to extract specific subsets of data relevant to our analysis.
### Here are the questions to answer though SQL queries and derive meaningful insight
1. What are the top payings data Annalyst jobs?
2. What are the skills required for these top paying jobs?
3. What are the most in-demands skills for data analysis?
4. What are the top skills as per the salary associated with these skills?
5. What are the optimal skills i.e. the high paying skills and their associated salaries?
# Tools used in project
Key tools used for analysis of the project are:
- **SQL**
 (Structured Query Language) is a programming language used for managing and manipulating relational databases,it it the fundamental tool i have used for analysis and management of data.
- **PostgreSQL** : PostgreSQL is an open-source relational database management system (RDBMS) that uses SQL. It is known for its reliability, scalability, and extensive features, including support for advanced data types, indexing, and transaction management.  
- **VS Code(Visual Studio Code)** : Visual Studio Code is a free, open-source code editor.VS Code offers an intuitive interface, built-in Git integration, and extensive customization options
- **Git and GitHub** : Git is a distributed version control system used for tracking changes in code and collaborating on projects with multiple contributors. GitHub is a web-based platform that hosts Git repositories and provides additional features such as issue tracking, project management, and code review. Git and GitHub are essential tools for managing and sharing code and analysis scripts, enabling seamless collaboration and version control in data analysis projects.
# Analysis for project
Each query in this project is aimed at investigating specific aspects of data analyst job market.They are as follows: 

### 1.Top_paying _data_analyst_jobs
Here i have analyzed the dataset to get the top paying data analyst jobs and their salaries focusing on remote jobs.This is the sql query for the same.
```sql 
SELECT 
        job_id,
        name AS company_name,
        job_title_short,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date
FROM job_postings_fact
LEFT JOIN company_dim ON
                job_postings_fact.company_id = company_dim.company_id
WHERE
        job_title_short = 'Data Analyst' AND
        job_location = 'Anywhere' AND
        salary_year_avg IS NOT NULL
ORDER BY 
        salary_year_avg DESC
LIMIT 10;        
```
![Top paying jobs](https://github.com/Qurrathulaain/DATA_ANALYSIS_SQL/blob/main/assets/Top_paying_jobs.png)
*Bar graph visualizing the salary for top paying jobs and this graph was created using microsoft Power BI*

### 2.Skills for top paying jobs.
In the second query i will be analyzing the dataset for top paying skills for the job role of data analyst.Below is the query for the same.

```sql
WITH top_paying_skills AS
    (
    SELECT 
            job_id,
            name AS company_name,
            job_title_short,
            salary_year_avg
    FROM job_postings_fact
    LEFT JOIN company_dim ON
                    job_postings_fact.company_id = company_dim.company_id
    WHERE
            job_title_short = 'Data Analyst' AND
            job_location = 'Anywhere' AND
            salary_year_avg IS NOT NULL
    ORDER BY 
            salary_year_avg DESC
    LIMIT 10
    )

SELECT top_paying_skills.*,
       skills
FROM top_paying_skills
INNER JOIN skills_job_dim ON
            top_paying_skills.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
            skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```
Here is the insight from the result:
- SQL 
- Python 
- Tableau.These are the top 3 skills which pays the most.

### 3.Top in demand skills
In this query i will anlyze the dataset ot fnd the top demanded skills for the data analyst role in the market.Below is the query for the same.
``` sql
SELECT skills,
        COUNT(skills_job_dim.job_id) AS skill_in_demand
FROM job_postings_fact
INNER JOIN skills_job_dim ON 
            job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
            skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
     job_title_short = 'Data Analyst' AND job_work_from_home = TRUE
GROUP BY 
    skills
ORDER BY 
    skill_in_demand DESC
LIMIT 5;
```
![Top Demanded skills](https://github.com/Qurrathulaain/DATA_ANALYSIS_SQL/blob/main/assets/Topdemandedskills.png)
*Bar graph visualizing the top skills in demand for data analyst role and this graph was created using microsoft Power BI*

### 4.Skills based on salary
In this query we are going to understand the skills which are high paying.Below is the query for the same.


``` sql
SELECT skills,
       ROUND(AVG(salary_year_avg),0) AS average_salary
FROM 
       job_postings_fact
INNER JOIN 
        skills_job_dim ON 
        job_postings_fact.job_id = skills_job_dim.job_id       
INNER JOIN 
        skills_dim ON 
        skills_job_dim.skill_id = skills_dim.skill_id
WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
GROUP BY
        skills
ORDER BY
        average_salary DESC
LIMIT 50;
```
![Top paying skills](https://github.com/Qurrathulaain/DATA_ANALYSIS_SQL/blob/main/assets/Toppayingskills.png)
*Table.Top paying skills with their associated salaries for data analyst role.*

### 5.Optimal skills to learn for the data analyst role.
In this final query i have combined insights from demand and salary data,to find the skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT  skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS jobs_in_demand,
        ROUND(AVG(job_postings_fact.salary_year_avg),0) AS average_associated_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON
        job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON
        skills_dim.skill_id = skills_job_dim.skill_id       
WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL AND
        job_work_from_home = TRUE
GROUP BY
        skills_dim.skill_id
HAVING
        COUNT(job_postings_fact.job_id) > 10
ORDER BY
        jobs_in_demand DESC,
        average_associated_salary DESC;
```        
![Optimal skills](https://github.com/Qurrathulaain/DATA_ANALYSIS_SQL/blob/main/assets/Optimalskills.png)
*Table.Optimal skills with their associated salaries for data analyst role.* 
# What I learned 
### In this project I have learned how to write complex query using joins and aggregations and CTEs and subquery this project had helped me to understand how real world data and learned how to work with huge data and analyze it to get meaningful insights.


# Conclusions
### Insights which are derived from the queries which could be turned into meaningful actions.
- Top-Paying Data Analyst Jobs: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at 6,50,000
- Skills for Top-Paying Jobs: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
- Most In-Demand Skills: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
- Skills with Higher Salaries: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
- Optimal Skills for Job Market Value: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### At the end i would say, this project has helped me improve my SQL skills and how to manage and analyze big data and derive meaningful results from it,apart from that it has also taught me what skills i should be focusing on as an aspiring data anlyst.
