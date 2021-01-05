#Join Example Questions

#1 Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;


SELECT * FROM users;

SELECT * FROM roles;

#2 Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT *
FROM users
JOIN roles ON users.id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.id = roles.id;

#3 Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT 
    roles.name as role_name,
    COUNT(role_id) as number_of_employees
from users
RIGHT join roles on users.role_id = roles.id
GROUP BY role_name;

#Employees Database Questions 

#1
Use employees;

select * 
from employees 
join salaries on salaries.emp_no = employees.emp_no
where salaries.to_date > curdate();

SELECT CONCAT(e.first_name, ' ', e.last_name) AS full_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON d.dept_no = de.dept_no
WHERE de.to_date = '9999-01-01' AND e.emp_no = 10001;

#2
SELECT departments.dept_name AS 'Department Name', CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager'
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE to_date > curdate();


#3
SELECT departments.dept_name AS 'Department Name', CONCAT(employees.first_name, ' ', employees.last_name) AS 'Department Manager'
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE to_date > curdate() and gender = "f"
ORDER BY dept_name;

#4
SELECT title as 'Title', count(*) as 'Count'
FROM employees
JOIN dept_emp on dept_emp.emp_no = employees.emp_no
JOIN titles ON titles.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE titles.to_date > curdate() and dept_name = "Customer Service"
GROUP BY title;

#5
SELECT departments.dept_name AS 'Department Name', CONCAT(employees.first_name, ' ', employees.last_name) AS 'Name', Salary
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
JOIN salaries ON salaries.emp_no = dept_manager.emp_no
WHERE salaries.to_date > curdate() AND dept_manager.to_date > curdate();

#6
SELECT departments.dept_no, dept_name, count(*) AS num_employees
FROM employees
JOIN dept_emp on dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > curdate()
group by departments.dept_no;

#7
SELECT departments.dept_name, AVG(salary) AS average_salary
FROM employees
JOIN dept_emp on dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date > curdate() AND salaries.to_date > curdate()
GROUP BY departments.dept_name
ORDER BY average_salary DESC
LIMIT 1;

#8
SELECT first_name, last_name
FROM employees
JOIN dept_emp on dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = dept_emp.emp_no
WHERE departments.dept_name = "Marketing" and salaries.to_date > curdate()
ORDER BY salary DESC
LIMIT 1;

#9
SELECT first_name, last_name, salary, dept_name
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
JOIN salaries ON salaries.emp_no = dept_manager.emp_no
WHERE salaries.to_date > curdate() AND dept_manager.to_date > curdate()
ORDER BY salary DESC
LIMIT 1;

#10
select concat(employees.first_name, " ", employees.last_name) as "employee_name", 
dept_name, 
concat(managers.first_name, " ", managers.last_name) as "manager_name"
from employees
join dept_emp using (emp_no)
join departments using(dept_no)
join dept_manager using(dept_no)
join employees as managers on managers.emp_no = dept_manager.emp_no
where dept_manager.to_date > curdate()
and dept_emp.to_date > curdate();

#11
select first_name, last_name, salary, dept_name
from employees
join salaries on salaries.emp_no = employees.emp_no
join dept_emp on dept_emp.emp_no = employees.emp_no
join departments on departments.dept_no = dept_emp.dept_no
where salary in (
	select max(salary)
	from employees
	join salaries on salaries.emp_no = employees.emp_no
	join dept_emp on dept_emp.emp_no = employees.emp_no
	join departments on departments.dept_no = dept_emp.dept_no
	group by dept_name
)
and salaries.to_date > curdate()
and dept_emp.to_date > curdate();
