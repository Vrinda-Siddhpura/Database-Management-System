CREATE TABLE STU_INFO(
	Rno INT,
	Name VARCHAR(30),
	Branch VARCHAR(20)
);

INSERT INTO STU_INFO(Rno, Name, Branch)
VALUES (101,'RAJU', 'CE'),
	   (102, 'AMIT', 'CE'),
	   (103, 'SANJYA', 'ME'),
	   (104, 'NEHA', 'EC'), 
	   (105, 'MEERA', 'EE'),
	   (106, 'MAHESH', 'ME')

SELECT * FROM STU_INFO

CREATE TABLE RESULT(
	Rno INT,
	SPI DECIMAL(4,2)
);

INSERT INTO RESULT(Rno, SPI)
VALUES (101, 8.8),
	   (102, 9.2),
	   (103, 7.6),
	   (104, 8.2),
	   (105, 7.0),
	   (107, 8.9)

SELECT * FROM RESULT

CREATE TABLE EMPLOYEE_MASTER(
	EmployeeNo VARCHAR(20),
	Name VARCHAR(30),
	ManagerNo VARCHAR(20)
);

INSERT INTO EMPLOYEE_MASTER(EmployeeNo, Name, ManagerNo)
VALUES ('E01', 'TARUN', NULL),
	   ('E02', 'ROHAN', 'E02'),
	   ('E03', 'PRIYA', 'E01'),
	   ('E04', 'MILAN', 'E03'),
	   ('E05', 'JAY', 'E01'),
	   ('E06', 'ANJANA', 'E04')

SELECT * FROM EMPLOYEE_MASTER

-------------------------------------PART A-----------------------------------

--1.Combine information from student and result table using cross join or Cartesian product.

SELECT *
FROM STU_INFO CROSS JOIN RESULT

--2.Perform inner join on Student and Result tables.

SELECT * 
FROM STU_INFO INNER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno

--3.Perform the left outer join on Student and Result tables.

SELECT * 
FROM STU_INFO LEFT OUTER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno

--4.Perform the right outer join on Student and Result tables.

SELECT * 
FROM STU_INFO RIGHT OUTER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno

--5.Perform the full outer join on Student and Result tables.

SELECT * 
FROM STU_INFO FULL OUTER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno

--6.Display Rno, Name, Branch and SPI of all students.

SELECT STU_INFO.Rno, STU_INFO.Name, STU_INFO.Branch, RESULT.SPI
FROM STU_INFO LEFT OUTER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno

--7.Display Rno, Name, Branch and SPI of CE branch’s student only.

SELECT STU_INFO.Rno, STU_INFO.Name, STU_INFO.Branch, RESULT.SPI
FROM STU_INFO LEFT OUTER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno
WHERE STU_INFO.Branch = 'CE'

--8.Display Rno, Name, Branch and SPI of other than EC branch’s student only.

SELECT STU_INFO.Rno, STU_INFO.Name, STU_INFO.Branch, RESULT.SPI
FROM STU_INFO LEFT OUTER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno
WHERE STU_INFO.Branch != 'EC'

--9.Display average result of each branch.

SELECT STU_INFO.Branch, AVG(RESULT.SPI) AS AVG_RESULT
FROM STU_INFO INNER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno
GROUP BY STU_INFO.Branch

--10.Display average result of CE and ME branch.

SELECT STU_INFO.Branch, AVG(RESULT.SPI) AS AVG_RESULT
FROM STU_INFO INNER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno
WHERE STU_INFO.Branch IN('CE', 'ME')
GROUP BY STU_INFO.Branch

--11.Display Maximum and Minimum SPI of each branch.

SELECT STU_INFO.Branch, MAX(RESULT.SPI) AS MAX_RESULT, MIN(RESULT.SPI) AS MIN_RESULT
FROM STU_INFO INNER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno
GROUP BY STU_INFO.Branch

--12.Display branch wise student’s count in descending order.

SELECT STU_INFO.Branch, COUNT(STU_INFO.Name) AS TOTAL_STUDENT
FROM STU_INFO 
GROUP BY STU_INFO.Branch

-------------------------------------PART B-----------------------------------

--1.Display average result of each branch and sort them in ascending order by SPI.

SELECT STU_INFO.Branch, AVG(RESULT.SPI) AS AVG_RESULT
FROM STU_INFO INNER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno
GROUP BY STU_INFO.Branch
ORDER BY AVG(RESULT.SPI)

--2.Display highest SPI from each branch and sort them in descending order.

SELECT TOP 1 STU_INFO.Branch, MAX(RESULT.SPI) AS MAX_SPI
FROM STU_INFO INNER JOIN RESULT
ON STU_INFO.Rno = RESULT.Rno
GROUP BY STU_INFO.Branch
ORDER BY MAX(RESULT.SPI) DESC

-------------------------------------PART C----------------------------------

--1.Retrieve the names of employee along with their manager’s name from the Employee table.

SELECT E1.Name AS EMPLOYEE_NAME, M1.Name AS MANAGER_NAME
FROM EMPLOYEE_MASTER E1 INNER JOIN EMPLOYEE_MASTER M1
ON E1.ManagerNo = M1.EmployeeNo 