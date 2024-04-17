/*
HERE WE WILL WRITE ALL THE DEMANDING SKILLS AND THE ASSOCIATED PAYS FOR THE SKILLS*/

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