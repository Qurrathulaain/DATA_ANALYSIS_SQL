--Top demanded skills

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
