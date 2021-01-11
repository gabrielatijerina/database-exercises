#1 Open Sequel Pro and login to the database server
#2 Save your work in a file named tables_exercises.sql
#3 Use the employees database
#4 List all the tables in the database
#5 Explore the employees table. What different data types are present on this table?
#6 Which table(s) do you think contain a numeric type column?
#7 Which table(s) do you think contain a string type column?
#8 Which table(s) do you think contain a date type column?
#9 What is the relationship between the employees and the departments tables?
#10 Show the SQL that created the dept_manager table.


#3
USE employees;

#4
SHOW employees;

#5
DESCRIBE employees; 

#6-9
DESCRIBE employees_with_departments;
DESCRIBE salaries;
DESCRIBE titles;
DESCRIBE departments;
DESCRIBE dept_manager;

#10
SHOW CREATE TABLE dept_manager;


