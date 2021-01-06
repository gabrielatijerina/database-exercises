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



#3 Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?