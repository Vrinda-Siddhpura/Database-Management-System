CREATE TABLE EMP(
	EID INT,
	EName VARCHAR(20),
	DEPARTMENT VARCHAR(20),
	SALARY INT,
	JoiningDate DATE,
	CITY VARCHAR(20),
	GENDER VARCHAR(20)
);

INSERT INTO EMP(EID, EName, DEPARTMENT, SALARY, JoiningDate, CITY, GENDER)
VALUES(101, 'RAHUL','ADMIN', 56000, '1990-01-01', 'RAJKOT', 'MALE'),
	(102, 'HARDIK', 'IT', 18000, '1990-09-25', 'AHMEDABAD', 'MALE'),
	(103, 'BHAVIN', 'HR', 25000, '1991-05-14', 'BARODA', 'MALE'),
	(104, 'BHOOMI', 'ADMIN', 39000, '1991-02-08', 'RAJKOT', 'FEMALE'),
	(105, 'ROHIT', 'IT', 17000, '1990-07-23', 'JAMNAGAR', 'MALE'),
	(106, 'PRIYA', 'IT', 9000, '1990-10-18', 'AHMEDABAD', 'FEMALE'),
	(107, 'BHOOMI', 'HR', 34000, '1991-12-25', 'RAJKOT', 'FEMALE')

SELECT * FROM EMP

-------------------------------------PART A-----------------------------------

--1.Display the Highest, Lowest, Label the columns Maximum, Minimum respectively.

SELECT MAX(SALARY) AS MAXIMUM_SALARY,
	   MIN(SALARY) AS MINIMUN_SALARY
FROM EMP

--2.Display Total, and Average salary of all employees. Label the columns Total_Sal and Average_Sal, respectively.

SELECT SUM(SALARY) AS TOTAL_SALARY,
	   AVG(SALARY) AS AVERAGE_SALARY
FROM EMP

--3.Find total number of employees of EMPLOYEE table.

SELECT COUNT(EName) AS TOTAL_EMPLOYES
FROM EMP

--4.Find highest salary from Rajkot city.

SELECT MAX(SALARY) 
FROM EMP
WHERE CITY = 'RAJKOT'

--5.Give maximum salary from IT department.

SELECT MAX(SALARY) 
FROM EMP
WHERE DEPARTMENT = 'IT'

--6.Count employee whose joining date is after 8-feb-91.

SELECT COUNT(EName) 
FROM EMP
WHERE JoiningDate = '1991-02-08'

--7.Display average salary of Admin department.

SELECT AVG(SALARY) AS AVG_SALARY 
FROM EMP
WHERE DEPARTMENT = 'ADMIN'

--8.Display total salary of HR department.

SELECT SUM(SALARY) AS TOTAL_SALARY 
FROM EMP
WHERE DEPARTMENT = 'HR'

--9.Count total number of cities of employee without duplication.

SELECT COUNT(DISTINCT CITY) AS TOTAL_CITIES 
FROM EMP

--10.Count unique departments.

SELECT COUNT(DISTINCT DEPARTMENT) AS TOTAL_DEPARTMENT 
FROM EMP

--11.Give minimum salary of employee who belongs to Ahmedabad.

SELECT MIN(SALARY) AS MIN_SALARY 
FROM EMP
WHERE CITY = 'AHMEDABAD'

--12.Find city wise highest salary.

SELECT CITY, MAX(SALARY) AS MAX_SALARY 
FROM EMP
GROUP BY CITY

--13.Find department wise lowest salary.

SELECT DEPARTMENT, MIN(SALARY) AS MIN_SALARY 
FROM EMP
GROUP BY DEPARTMENT

--14.Display city with the total number of employees belonging to each city.

SELECT CITY, COUNT(EName) AS TOTAL_EMP 
FROM EMP
GROUP BY CITY

--15.Give total salary of each department of EMP table.

SELECT DEPARTMENT,SUM(SALARY) AS TOTAL_SALARY
FROM EMP
GROUP BY DEPARTMENT

--16.Give average salary of each department of EMP table without displaying the respective department name.

SELECT AVG(SALARY) AS AVG_SALARY 
FROM EMP
GROUP BY DEPARTMENT 

--17.Count the number of employees for each department in every city.

SELECT DEPARTMENT, CITY, COUNT(EName) AS TOTAL_EMPLOYEE 
FROM EMP
GROUP BY DEPARTMENT,CITY

--18.Calculate the total salary distributed to male and female employees.

SELECT GENDER, SUM(SALARY) AS TOTAL_SALARY 
FROM EMP
GROUP BY GENDER

--19.Give city wise maximum and minimum salary of female employees.

SELECT CITY, 
	   MAX(SALARY) AS MAX_SALARY,
	   MIN(SALARY) AS MIN_SALARY 
FROM EMP
GROUP BY CITY

--20.Calculate department, city, and gender wise average salary.

SELECT DEPARTMENT, CITY, GENDER, AVG(SALARY) AS AVG_SALARY
FROM EMP
GROUP BY DEPARTMENT, CITY, GENDER

-------------------------------------PART B-----------------------------------

--1.Count the number of employees living in Rajkot.

SELECT CITY, COUNT(EName) AS TOTAL_EMPLOYEE 
FROM EMP
WHERE CITY = 'RAJKOT'
GROUP BY CITY

--2.Display the difference between the highest and lowest salaries. Label the column DIFFERENCE.

SELECT MAX(SALARY)-MIN(SALARY) AS DIFFERENCE
FROM EMP

--3.Display the total number of employees hired before 1st January, 1991.

SELECT JoiningDate, COUNT(EName) AS TOTAL_EMPLOYEE 
FROM EMP
WHERE JoiningDate < '1991-01-01' 
GROUP BY JoiningDate

-------------------------------------PART C-----------------------------------

--1.Count the number of employees living in Rajkot or Baroda.

SELECT CITY, COUNT(EName) AS TOTAL_EMPLOYEE
FROM EMP
WHERE CITY = 'RAJKOT' OR CITY = 'BARODA'
GROUP BY CITY

--2.Display the total number of employees hired before 1st January, 1991 in IT department.

SELECT JoiningDate, DEPARTMENT, COUNT(EName) AS TOTAL_EMPLOYEE 
FROM EMP
WHERE JoiningDate < '1991-011-01' 
AND DEPARTMENT = 'IT'
GROUP BY JoiningDate, DEPARTMENT

--3.Find the Joining Date wise Total Salaries.

SELECT JoiningDate, SUM(SALARY) AS TOTAL_SALARY
FROM EMP
GROUP BY JoiningDate

--4.Find the Maximum salary department & city wise in which city name starts with ‘R’.

SELECT DEPARTMENT, CITY, MAX(SALARY) AS MAXIMUM_SALARY 
FROM EMP
WHERE CITY = 'R%'
GROUP BY DEPARTMENT, CITY