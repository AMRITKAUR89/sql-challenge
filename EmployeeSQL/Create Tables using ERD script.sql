-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.departments
(
    dept_no character varying(10) COLLATE pg_catalog."default" NOT NULL,
    dept_name character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT departments_pkey PRIMARY KEY (dept_no)
);

CREATE TABLE IF NOT EXISTS public.dept_emp
(
    emp_no integer,
    dept_no character varying(10) COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.dept_manager
(
    dept_no character varying(10) COLLATE pg_catalog."default",
    emp_no integer
);

CREATE TABLE IF NOT EXISTS public.employees
(
    emp_no integer NOT NULL,
    emp_title_id character varying(10) COLLATE pg_catalog."default",
    birth_date date,
    first_name character varying(50) COLLATE pg_catalog."default",
    last_name character varying(50) COLLATE pg_catalog."default",
    sex character varying(10) COLLATE pg_catalog."default",
    hire_date date,
    CONSTRAINT employees_pkey PRIMARY KEY (emp_no)
);

CREATE TABLE IF NOT EXISTS public.salaries
(
    emp_no integer,
    salary integer
);

CREATE TABLE IF NOT EXISTS public.titles
(
    title_id character varying(10) COLLATE pg_catalog."default" NOT NULL,
    title character varying(100) COLLATE pg_catalog."default",
    CONSTRAINT titles_pkey PRIMARY KEY (title_id)
);

ALTER TABLE IF EXISTS public.dept_emp
    ADD CONSTRAINT dept_emp_dept_no_fkey FOREIGN KEY (dept_no)
    REFERENCES public.departments (dept_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.dept_emp
    ADD CONSTRAINT dept_emp_emp_no_fkey FOREIGN KEY (emp_no)
    REFERENCES public.employees (emp_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.dept_manager
    ADD CONSTRAINT dept_manager_dept_no_fkey FOREIGN KEY (dept_no)
    REFERENCES public.departments (dept_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.dept_manager
    ADD CONSTRAINT dept_manager_emp_no_fkey FOREIGN KEY (emp_no)
    REFERENCES public.employees (emp_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE IF EXISTS public.salaries
    ADD CONSTRAINT salaries_emp_no_fkey FOREIGN KEY (emp_no)
    REFERENCES public.employees (emp_no) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;
