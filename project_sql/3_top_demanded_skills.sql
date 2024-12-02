select skills AS SKILL_NAME,
        count(skills_job_dim.job_id) AS DEMAND_COUNT
from 
    job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id=job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
where
     job_title_short ='Data Analyst'
GROUP BY
     skills
order by 
    DEMAND_COUNT DESC

