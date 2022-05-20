use database shubham;

drop table if exists Employees;
drop table if exists Departmentsi;
drop table if exists Titles;
drop table if exists Salaries;
drop table if exists Department_managers;
drop table if exists Department_Employees;

CREATE TABLE Employees (
    emp_no  int  ,
    emp_titles_id varchar(10) ,
    birth_date  varchar(15) ,
    first_name  varchar(15) ,
    last_name    varchar(15),
    sex         char(1)  ,
    hire_date    varchar(15) ,
    no_of_projects int ,
    Last_performance_rating  varchar(5)  ,
    left_job int ,
    Last_date   varchar(15)               
)
stored as avro 
location '/user/anabig114215/hive/warehouse/impala/Employees'   --CHANGE AS PER NEW SQOOP COMMAND FROM THERE LOCATION WHERE YOU HAV SAVED AVRO FILE AND AVSC FILE DO THE SAME IN ALL
tblproperties('avro.schema.url' = '/user/anabig114215/capstone3/Employees.avsc');

CREATE TABLE Departments (
    dept_no     varchar(10)    ,  
    dept_name   varchar(10)
)
stored as avro 
location '/user/anabig114215/hive/warehouse/impala/Departments'
tblproperties('avro.schema.url' = '/user/anabig114215/capstone3/Departments.avsc');


CREATE TABLE Department_Employees (
    emp_no  int,
    dept_no varchar(10)
)
stored as avro 
location '/user/anabig114215/hive/warehouse/impala/Department_Employees'
tblproperties('avro.schema.url' = '/user/anabig114215/capstone3/Department_Employees.avsc');


CREATE TABLE Department_managers (
   dept_no      VARCHAR(10),
   emp_no       int 
)
stored as avro 
location '/user/anabig114215/hive/warehouse/impala/Department_managers'
tblproperties('avro.schema.url' = '/user/anabig114215/capstone3/Department_managers.avsc');


CREATE TABLE Titles(
    title_id VARCHAR(10),
    title     varchar(15)
)
stored as avro 
location '/user/anabig114215/hive/warehouse/impala/Titles'
tblproperties('avro.schema.url' = '/user/anabig114215/capstone3/Titles.avsc');

CREATE TABLE Salaries (
    emp_no      int   ,
    Salary      bigint   
)stored as avro 
location '/user/anabig114215/hive/warehouse/impala/Salaries'
tblproperties('avro.schema.url' = '/user/anabig114215/capstone3/Salaries.avsc');

drop table if exists Employees1;
create table Employees1 as
select 
    emp_no, 
    emp_titles_id ,
    birth_date,
    cast(regexp_extract(birth_date, ". *. *. *. *$",0) as int) as birth_year  , 
    first_name  , 
    last_name   , 
    sex           , 
    hire_date    ,
    cast(regexp_extract(hire_date, ". *. *. *. *$",0) as int) as hiring_year,
    no_of_projects  ,
    Last_performance_rating , 
    left_job  , 
    Last_date    from Employeesimpala;  
select * from Employees2 limit 5;
drop table if exists Employees2;
create table Employees2 as
select 
    emp_no, 
    emp_titles_id ,
    birth_date,
    cast(regexp_extract(birth_date, ". *. *. *. *$",0) as int) as birth_year  , 
    first_name  , 
    last_name   , 
    sex           , 
    hire_date    ,
    cast(regexp_extract(hire_date, ". *. *. *. *$",0) as int) as hiring_year,
    no_of_projects  ,
    Last_performance_rating , 
    left_job  , 
    Last_date,
    CASE
    WHEN left_job =1 THEN "left" 
    else "working" 
    end as status ,
    case when left_job =0 then "0" 
    else regexp_extract(last_date, ". *. *. *. *$",0)  
    end as last_year from Employeesimpala ;
select * from Employees2 limit 5;

--1. A list showing employee number, last name, first name, sex, and salary for each employee1. 

select E.emp_no,last_name,first_name,sex,S.Salary 
from Employees1 as E
inner join Salaries as S on E.emp_no =S.emp_no ;

--2.A list showing first name, last name, and hire date for employees who were hired in 1986.

select first_name,last_name,hire_date
from Employees1 
where hiring_year=="1986" ;

--3. A list showing the manager of each department with the following information: department number, department name, 
--the manager's employee number, last name, first name.

select E.emp_no,First_name,Last_name, DM.dept_no,D.dept_name
from Employees1 as E
inner join department_managers as DM on E.emp_no=DM.emp_no
inner join departments as D on DM.dept_no = D.dept_no ;

--4. A list showing the department of each employee with the following information: employee number, last name, first 
--name, and department name.

select E.emp_no, first_name,last_name,D.dept_name
from Employees1 as E
inner join department_managers as DM on E.emp_no=DM.emp_no
inner join departments as D on DM.dept_no = D.dept_no;

--5. A list showing first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B.“

select first_name,last_name,sex 
from Employees1 
where first_name like "Hercules%" and last_name like "B%" ;

--6. A list showing all employees in the Marketing department, including their employee number, last name, first name, and 
--department name.

select E.emp_no,First_name,Last_name,D.dept_name
from Employees1 as E
inner join department_managers as DM on E.emp_no=DM.emp_no
inner join departments as D on DM.dept_no = D.dept_no
where D.dept_name like "%Marketing%";


--7. A list showing all employees in the Marketing and development departments, including their employee number, last name, 
--first name, and department name

select E.emp_no,First_name,Last_name,D.dept_name
from Employees1 as E
inner join department_managers as DM on E.emp_no=DM.emp_no
inner join departments as D on DM.dept_no = D.dept_no
where D.dept_name in ('Marketing', 'development') ;

--8. A list showing the frequency count of employee last names, in descending order. ( i.e., how many employees share each 
--last name

select last_name,count(last_name) as no_of_common_last_name
from Employees1 
group by last_name
order by  no_of_common_last_name desc  ;

--9. Histogram to show the salary distribution among the employees

select Salary from Salaries ;

--10. Bar graph to show the Average salary per title (designation)

select title, avg(Salary) 
from Employees1 as E 
inner join Titles as T on E.emp_titles_id=T.title_id
inner join Salaries as S on E.emp_no =S.emp_no
group by title ;

--11. Calculate employee tenure & show the tenure distribution among the employees
select emp_no,First_name,Last_name,cast(regexp_extract(hire_date, ". *. *. *. */$",0) as int) as hiring_year  ,(case when left_job =0 then 0 else cast(regexp_extract(last_date, ". *. *. *. *$",0) as int) end) as last_year
,((case when left_job =0 then cast(regexp_extract(hire_date, ". *. *. *. */$",0) as int) else cast(regexp_extract(last_date, ". *. *. *. *$",0) as int) end)-cast(regexp_extract(hire_date, ". *. *. *. *$",0) as int)) as tenure_in_years
from Employees ;

--12. a list of employees who requires PIP
select emp_no , First_name,Last_name,Last_performance_rating
from Employees 
where Last_performance_rating = "PIP" limit 5;

--13. trend of leaving job by year
select (case when left_job =1 then cast(regexp_extract(last_date, ". *. *. *. *$",0) as int) end) as last_year, count(emp_no) as no_of_employee_left
from Employees
group by (case when left_job =1 then cast(regexp_extract(last_date, ".*. *. *. *. *$",0) as int) end) ;

--14. trend of salary and year of experience   /// considering the analysis is done on the max date which is 2013 in this data so i'm calculate on that

select (2013-cast(regexp_extract(hire_date, ". *. *. *. *$",0) as int)) as year_of_experience , round(avg(salary),2) as Average_salary 
from Employees as E
inner join Salaries as S on E.emp_no =S.emp_no 
group by (2013-cast(regexp_extract(hire_date, ". *. *. *. *$",0) as int)) ;

--15. employees per department 

select dept_name,count(E.emp_no) 
from Employees as E
inner join department_managers as DM on E.emp_no =DM.emp_no
inner join departments as D on DM.dept_no =D.dept_no
group by dept_name;

--16. Company gender ratio

select sex, count(sex) from Employees group by sex ;

--17. no of employees currently 
select count(emp_no) from Employees where left_job =0
