select skills AS SKILL_NAME,
        round(avg(salary_year_avg),0) as pay_scale_per_skill
from 
    job_postings_fact
inner join skills_job_dim on skills_job_dim.job_id=job_postings_fact.job_id
inner join skills_dim on skills_dim.skill_id=skills_job_dim.skill_id
where
     job_title_short ='Data Analyst' and salary_year_avg is not NULL
GROUP BY
     skills
order by 
    pay_scale_per_skill DESC
