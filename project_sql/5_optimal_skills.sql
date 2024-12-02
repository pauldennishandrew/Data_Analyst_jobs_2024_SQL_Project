WITH skill_demand AS (
    SELECT  
        skills_dim.skills AS SKILL_NAME,
        skills_job_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS DEMAND_COUNT
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL 
    GROUP BY
        skills_dim.skills, skills_job_dim.skill_id
),
average_salary AS (
    SELECT
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS pay_scale_per_skill
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
    INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)
SELECT 
    skill_demand.skill_id,
    skill_demand.skill_name,
    skill_demand.DEMAND_COUNT,
    average_salary.pay_scale_per_skill
FROM skill_demand
INNER JOIN average_salary 
    ON skill_demand.skill_id = average_salary.skill_id
where DEMAND_COUNT > 10
order by 
    --DEMAND_COUNT desc , 
    pay_scale_per_skill DESC,
    DEMAND_COUNT desc 
limit 25;
