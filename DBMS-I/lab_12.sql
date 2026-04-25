CREATE TABLE PERSON(
	PersonID INT,
	PersonName Varchar(100),
	DepartmentID INT,
	Salary Decimal(8,2),
	JoiningDate Datetime,
	City Varchar(100)
);

INSERT INTO PERSON(PersonID, PersonName, DepartmentID, Salary, JoiningDate, City)
VALUES (101, 'Rahul Tripathi', 2, 56000, '2000-01-01', 'Rajkot'),
	(102, 'Hardik Pandya', 3, 18000, '2001-09-25', 'Ahmedabad'),
	(103, 'Bhavin Kanani', 4, 25000, '2000-05-14', 'Baroda'),
	(104, 'Bhoomi Vaishnav', 1, 39000, '2005-02-08', 'Rajkot'),
	(105, 'Rohit Topiya', 2, 17000, '2001-07-23', 'Jamnagar'),
	(106, 'Priya Menpara', NULL, 9000, '2000-10-18', 'Ahmedabad'),
	(107, 'Neha Sharma', 2, 34000, '2002-12-25', 'Rajkot'),
	(108, 'Nayan Goswami', 3, 25000, '2001-07-01', 'Rajkot'),
	(109, 'Mehul Bhundiya', 4, 13500, '2005-01-09', 'Baroda'),
	(110, 'Mohit Maru', 5, 14000, '2000-05-25', 'Jamnagar')

SELECT * FROM PERSON

CREATE TABLE DEPT(
	DepartmentID Int,
	DepartmentName Varchar(100),
	DepartmentCode Varchar(50),
	Location Varchar(50)
);

INSERT INTO DEPT(DepartmentID, DepartmentName, DepartmentCode, Location)
VALUES (1, 'Admin', 'Adm', 'A-Block'),
	(2, 'Computer', 'CE', 'C-Block'),
	(3, 'Civil', 'CI', 'G-Block'),
	(4, 'Electrical', 'EE', 'E-Block'),
	(5, 'Mechanical', 'ME', 'B-Block')

SELECT * FROM DEPT

-------------------------------------PART A-----------------------------------

--1.Combine information from Person and Department table using cross join or Cartesian product.

SELECT *
FROM PERSON CROSS JOIN DEPT

--2.Find all persons with their department name

SELECT
	PERSON.PersonName, DEPT.DepartmentName 
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID

--3.Find all persons with their department name & code.

SELECT
	PERSON.PersonName, DEPT.DepartmentName, DEPT.DepartmentCode 
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID

--4.Find all persons with their department code and location.

SELECT
	PERSON.PersonName, DEPT.DepartmentCode, DEPT.Location 
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID

--5.Find the detail of the person who belongs to Mechanical department.

SELECT *
FROM PERSON LEFT OUTER JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE DEPT.DepartmentName = 'Mechanical'

--6.Final person’s name, department code and salary who lives in Ahmedabad city.

SELECT 
	PERSON.PersonName, DEPT.DepartmentCode, PERSON.Salary
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE PERSON.City = 'Ahmedabad'

--7.Find the person's name whose department is in C-Block.

SELECT 
	PERSON.PersonName
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE DEPT.Location = 'C-Block'

--8.Retrieve person name, salary & department name who belongs to Jamnagar city.

SELECT PersonName, PERSON.Salary, DEPT.DepartmentName
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE PERSON.City = 'Jamnagar'

--9.Retrieve person’s detail who joined the Civil department after 1-Aug-2001.

SELECT *
FROM PERSON LEFT OUTER JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE DEPT.DepartmentName = 'Civil' AND PERSON.JoiningDate > '2001-08-01'

--10.Display all the person's name with the department whose joining date difference with the current date is more than 365 days.

SELECT
  PERSON.PersonName, DEPT.DepartmentName
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE DATEDIFF(DAY, PERSON.JoiningDate, GETDATE()) > 365

--11.Find department wise person counts.

SELECT
	DEPT.DepartmentName, COUNT(PERSON.PersonName) AS TOTAL_PERSON
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
GROUP BY DEPT.DepartmentName

--12.Give department wise maximum & minimum salary with department name.

SELECT 
	DEPT.DepartmentName, MAX(PERSON.SALARY) AS MAX_SALARY, MIN(PERSON.SALARY) AS MIN_SALARY
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
GROUP BY DEPT.DepartmentName

--13.Find city wise total, average, maximum and minimum salary.

SELECT 
	PERSON.City, SUM(SALARY) AS TOTAL_SALARY,AVG(PERSON.SALARY) AS AVG_SALARY, MAX(PERSON.SALARY) AS MAX_SALARY, MIN(PERSON.SALARY) AS MIN_SALARY
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
GROUP BY PERSON.City

--14.Find the average salary of a person who belongs to Ahmedabad city.

SELECT 
	PERSON.City, AVG(PERSON.Salary) AS AVG_SALARY
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
GROUP BY PERSON.City
HAVING PERSON.City = 'Ahmedabad'

--15.Produce Output Like: <PersonName> lives in <City> and works in <DepartmentName> Department. (In single column)

SELECT 
	PERSON.PersonName + ' Lives in ' + PERSON.City + ' and works in ' + DEPT.DepartmentName + ' Department.'
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID

-------------------------------------PART B-----------------------------------

--1.Produce Output Like: <PersonName> earns <Salary> from <DepartmentName> department monthly. (In single column)

SELECT 
	PERSON.PersonName + ' earns ' + CAST(PERSON.Salary AS VARCHAR) + ' from ' + DEPT.DepartmentName + ' department monthly.'
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID

--2.Find city & department wise total, average & maximum salaries.

SELECT 
	PERSON.City, DEPT.DepartmentName, SUM(PERSON.Salary) AS TOTAL_SALARY, MAX(PERSON.SALARY) AS MAX_SALARY
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
GROUP BY PERSON.City, DEPT.DepartmentName

--3.Find all persons who do not belong to any department.

SELECT * 
FROM PERSON LEFT OUTER JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE DEPT.DepartmentName IS NULL

--4.Find all departments whose total salary is exceeding 100000.

SELECT *
FROM PERSON RIGHT OUTER JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE PERSON.Salary > 100000

-------------------------------------PART C-----------------------------------

--1.List all departments who have no person.

SELECT *
FROM PERSON LEFT OUTER JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE PERSON.PersonName IS NULL

--2.List out department names in which more than two persons are working.

SELECT 
	DEPT.DepartmentName, COUNT(PERSON.PersonName) AS TOTAL_PERSON
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
GROUP BY DEPT.DepartmentName
HAVING COUNT(PERSON.PersonName) > 2

--3.Give a 10% increment in the computer department employee’s salary. (Use Update)

UPDATE PERSON
SET SALARY += SALARY*0.1
FROM PERSON JOIN DEPT
ON PERSON.DepartmentID = DEPT.DepartmentID
WHERE DEPT.DepartmentName = 'computer'