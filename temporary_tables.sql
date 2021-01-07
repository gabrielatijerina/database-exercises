#Create a file named temporary_tables.sql to do your work for this exercise.

#1 Using the example from the lesson, re-create the employees_with_departments table.

use easley_1266;

select * 
from employees.employees_with_departments;

CREATE TEMPORARY TABLE emps_w_depts as (
	select *
	from employees.employees_with_departments);

#Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

ALTER TABLE emps_w_depts 
ADD full_name VARCHAR(100);

SELECT *
FROM emps_w_depts;

#Update the table so that full name column contains the correct data

UPDATE emps_w_depts 
SET full_name = CONCAT(first_name, ' ', last_name);

SELECT * 
FROM emps_w_depts;


#Remove the first_name and last_name columns from the table.

ALTER TABLE emps_w_depts
DROP COLUMN first_name;


SELECT *
FROM emps_w_depts;

ALTER TABLE emps_w_depts
DROP COLUMN last_name;

SELECT *
FROM emps_w_depts;

#What is another way you could have ended up with this same table?

ALTER TABLE emps_w_depts
DROP COLUMN first_name,
DROP COLUMN last_name;

#2 Create a temporary table based on the payment table from the sakila database.

USE easley_1266;

CREATE TEMPORARY TABLE payment AS
	(SELECT * 
	FROM sakila.payment);
	
SELECT *
FROM payment;



#Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

ALTER TABLE payment ADD new_amount INT;

SELECT * 
FROM payment;

UPDATE payment 
SET new_amount = amount * 100;

SELECT *
FROM payment;

ALTER TABLE payment DROP COLUMN amount;

SELECT * 
FROM payment;

ALTER TABLE payment CHANGE COLUMN new_amount amount int;

SELECT *
from payment;

#2 alternate solution 

select *
from sakila.payment;

CREATE TEMPORARY TABLE new_payment1 AS (
		SELECT *
		FROM sakila.payment);

select *
from new_payment1;

# Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. 
# For example, 1.99 should become 199.

Alter table new_payment1 
modify AMOUNT DECIMAL(10, 4);

UPDATE new_payment1
SET AMOUNT = AMOUNT * 100;

Alter table new_payment1 
modify AMOUNT INT;


#3 Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

#simplest solution from ryan 

use ryan;

-- Obtain the average histortic salary and the historic standard deviation of salary
-- Write the numbers down:
-- 63,810 historic average salary
-- 16,904 historic standard deviation
select avg(salary) as avg_salary, std(salary) as std_salary
from employees.salaries	;

create temporary table current_info as (
	select dept_name, avg(salary) as department_current_average
	from employees.salaries
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
	where employees.dept_emp.to_date > curdate()
	and employees.salaries.to_date > curdate()
	group by dept_name
);

-- Create columns to hold the average salary, std, and the zscore
alter table current_info add average float(10,2);
alter table current_info add standard_deviation float(10,2);
alter table current_info add zscore float(10,2);

update current_info set average = 63810;
update current_info set standard_deviation = 16904;

-- z_score  = (avg(x) - x) / std(x) */
update current_info 
set zscore = (department_current_average - historic_avg) / historic_std;

select * from current_info
order by zscore desc;

#3 solution 

use ryan;

-- Historic average and standard deviation b/c the problem says "use historic average"
-- 63,810 historic average salary
-- 16,904 historic standard deviation
create temporary table historic_aggregates as (
	select avg(salary) as avg_salary, std(salary) as std_salary
	from employees.salaries	
);

create temporary table current_info as (
	select dept_name, avg(salary) as department_current_average
	from employees.salaries
	join employees.dept_emp using(emp_no)
	join employees.departments using(dept_no)
	where employees.dept_emp.to_date > curdate()
	and employees.salaries.to_date > curdate()
	group by dept_name
);

select * from current_info;

alter table current_info add historic_avg float(10,2);
alter table current_info add historic_std float(10,2);
alter table current_info add zscore float(10,2);

update current_info set historic_avg = (select avg_salary from historic_aggregates);
update current_info set historic_std = (select std_salary from historic_aggregates);

select * from current_info;

update current_info 
set zscore = (department_current_average - historic_avg) / historic_std;

select * from current_info
order by zscore desc;