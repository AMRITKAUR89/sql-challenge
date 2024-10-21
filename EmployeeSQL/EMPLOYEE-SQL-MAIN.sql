-- Create Table for Departments
CREATE TABLE departments (
    dept_no VARCHAR   NOT NULL,
    dept_name VARCHAR   NOT NULL,
    PRIMARY KEY (dept_no)
);
 select * from  departments;

-- Create Table for Employees
CREATE TABLE employees(
    emp_no INT PRIMARY KEY, 
    emp_title_id VARCHAR(10), 
    birth_date DATE, 
    first_name VARCHAR(50), 
    last_name VARCHAR(50), 
    sex VARCHAR(10), 
    hire_date DATE
);
 select * from  employees;
 

-- Create Table for Department Employees
CREATE TABLE dept_emp(
    emp_no INT NOT NULL, 
    dept_no VARCHAR(10) NOT NULL,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	PRIMARY KEY (emp_no,dept_no)
);

 select * from  dept_emp;

-- Create Table for Department Managers
CREATE TABLE dept_manager(
    dept_no VARCHAR(10) NOT NULL,
    emp_no INT NOT NULL,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no,dept_no)
);
 select * from  dept_manager;

-- Create Table for Salaries
CREATE TABLE salaries(
    emp_no INT, 
    salary INT,
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	PRIMARY KEY (emp_no)
);
 select * from salaries;
 
-- Create Table for Titles
CREATE TABLE titles(
    title_id VARCHAR(10) PRIMARY KEY, 
    title VARCHAR(100)
);
   select * from titles;

   
--1.List the employee number, last name, first name, sex, and salary of each employee.
select e.emp_no, em.last_name, em.first_name, em.sex, s.salary
from dept_emp as e 
inner join employees as em on e.emp_no = em.emp_no 
inner join salaries as s on e.emp_no = s.emp_no;

--2.List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date from employees
where extract(year from hire_date) = 1986;

--3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
select d.dept_no, d.dept_name, em.emp_no, em.last_name, em.first_name
from departments as d
inner join dept_manager as m on d.dept_no=m.dept_no
inner join employees as em on m.emp_no=em.emp_no;

--4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
select em.emp_no,m.dept_no, em.last_name, em.first_name, d.dept_name
from employees as em
join dept_emp as m  on m.emp_no = em.emp_no
join departments as d on d.dept_no=m.dept_no;

--5.List the first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
select first_name, last_name, sex from employees where last_name like 'B%';

--6.List each employee in the Sales department, including their employee number, last name, and first name.
select emp_no, last_name, first_name from employees 
where emp_no in ( 
	select emp_no from dept_emp 
	where dept_no in (
		select dept_no from departments 
		where dept_name='Sales'));
		
--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
select em.emp_no, em.last_name, em.first_name, d.dept_name
from employees as em
inner join dept_emp as dem on dem.emp_no=em.emp_no
inner join departments as d on d.dept_no=dem.dept_no
where d.dept_name in ('Sales','Development');

--8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
select last_name, count(*) as c from employees 
group by last_name order by c desc ;