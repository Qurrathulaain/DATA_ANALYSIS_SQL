--here we will write queries for the project.
--Here we write query for the capstone
--Query to find top pauing jobs
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

