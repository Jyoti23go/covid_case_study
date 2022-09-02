SELECT * FROM covid19_case_study.dbo.covid_data;
-- data where death>2
select * from covid19_case_study.dbo.covid_data where Death>2;
-- count total number of data
select count(*) from covid19_case_study.dbo.covid_data;
-- complete data
select * from covid19_case_study.dbo.covid_data;
select count(*) from covid19_case_study.dbo.covid_data where state in ('Kerala','Delhi');
-- where death>1 and case>1
select state,Date from covid19_case_study..covid_data where Death>1 and total_case>1;
-- select the state which start from letter M
select state from covid19_case_study..covid_data where state like 'M%' group by state;
-- count of data per state
select state,count(state) from covid19_case_study..covid_data group by state;
-- sum of total cases
select state,sum(total_case) as total_cases,max(total_case) as maximum_case from covid19_case_study..covid_data group by state;
-- average cases
select round(avg(total_case),0) as avge from covid19_case_study..covid_data;
select state,avg(total_case) as avg_case from covid19_case_study..covid_data group by state order by avg_case asc;
-- delete 
delete from covid19_case_study..covid_data where total_case<4;
select state,count(state) as count_ from covid19_case_study..covid_data group by state order by count_ desc
--count and max
select state, count(new_case) as case_new from covid19_case_study..covid_data group by state having count(new_case)>50;
select state, max(total_case) as case_ from covid19_case_study..covid_data group by state order by case_ desc;
select top 3 state, max(total_case) as case_ from covid19_case_study..covid_data group by state order by case_ desc;
-- top and bottom 3 state have total case 

-- store above data by creating a new table
create table b(
state nvarchar(250),
top_state  float,

);
insert into b 
select state, max(total_case) as case_ from covid19_case_study..covid_data group by state order by case_ desc;
select * from (
select top 3 * from b order by top_state asc) c
union
select * from (
select top 3 * from b order by top_state desc)d;
-- from where and when > 1st case of covid was found
select state,Date,total_case from covid19_case_study..covid_data where total_case>0;
-- about death
select state,Date,death from covid19_case_study..covid_data where death>1 order by death desc;
-- so maximum death was taken in maharashtra in august
-- about the medical services and cured rate
select state,Date,cured  from covid19_case_study..covid_data order by cured desc;
select month(Date),sum(cured) as cured from covid19_case_study..covid_data group by month(Date) order by sum(cured) desc;
--month vise cases
select month(Date),sum(total_case) as total_case,sum(cured) as cured from covid19_case_study..covid_data group by month(Date) order by sum(total_case) desc;
--where cured rate is greater than cases
select month(Date) as month,sum(total_case) as total_case,sum(cured) as cured,sum(cured) / sum(total_case)*100 as rate from covid19_case_study..covid_data group by month(Date) order by sum(total_case) desc;
--  new  recovery rate
select month(Date) as month,sum(new_case) as new_case,sum(new_recovered) as cured,sum(new_recovered) / sum(new_case)*100 as rate from covid19_case_study..covid_data group by month(Date) order by sum(new_case) desc;
-- hence new_recovery rate was maximum in august