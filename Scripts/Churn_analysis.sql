use customer_churn;

-- 1) Overall churn rate--
select 
     count(*) as total_customers,
     sum(churn_label) as churned_customers,
     round(100*sum(churn_label)/ count(*),2) as churn_rate
from telco_clean;

-- 2) Churn rate by contract type--
select Contract,
       count(*) as total_customers,
       sum(churn_label) as churned_customers,
       round(100*sum(churn_label)/count(*),2) as churn_rate
from telco_clean
group by Contract
order by churn_rate desc;

-- 3) Churn_rate by payment method--
select Payment_Method,
       count(*) as total_customers,
       sum(churn_label) as churned_customers,
       round(100*sum(churn_label)/count(*),2) as churn_rate
from telco_clean
group by Payment_Method
order by churn_rate desc;


-- 4) Churn rate by Internet service--
select Internet_Type,
       count(*) as total_customers,
       sum(churn_label) as churned_customers,
       round(100*sum(churn_label)/count(*),2) as churn_rate
from telco_clean
group by Internet_Type
order by churn_rate desc;

-- 5) Churn rate by satisfaction score--
select Satisfaction_Score,
       count(*) as total_customers,
       sum(churn_label) as churned_customers,
       round(100*sum(churn_label)/count(*),2) as churn_rate
from telco_clean
group by  Satisfaction_Score
order by  Satisfaction_Score;

-- 6) Percentage of churned customers leave within the first year --
select 
	  round( sum(case when 'Tenure_ in_Months' <=12 then 1 else 0 end)*100/ count(*),2) as percentage_first_year_churn
from telco_clean
where Churn_label = 1;

-- 7) High risk customers--
select
Customer_ID,Contract, Tenure_in_Months, Internet_Type, Payment_Method,Monthly_Charge
from telco_clean
where Contract ='Month-to-Month'
and Tenure_in_Months<=12
and Monthly_Charge> 
(
select round(avg(Monthly_Charge),2)
from telco_clean
)
order by Monthly_Charge desc;



