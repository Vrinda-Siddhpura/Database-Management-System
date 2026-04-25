CREATE TABLE STU_MASTER(
	Rno INT,
	Name VARCHAR(20),
	Branch VARCHAR(20), 
	SPI DECIMAL(3,2),
	Bklog INT
);

INSERT INTO STU_MASTER(Rno, Name, Branch, SPI, Bklog)
VALUES(101, 'Raju', 'CE', 8.80, 0),
	(102, 'Amit', 'CE', 2.20, 3),
	(103, 'Sanjay', 'ME', 1.50, 6),
	(104, 'Neha', 'EC', 7.65, 0),
	(105, 'Meera', 'EE', 5.52, 2),
	(106, 'Mahesh', 'NULL', 4.50, 3)

SELECT * FROM STU_MASTER

-------------------------------------PART A-----------------------------------

--1.Do not allow SPI more than 10

CREATE TABLE STU_MASTER_1(
	Rno INT PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
    SPI DECIMAL(4,2) NOT NULL CHECK (SPI < 10)
);

--2.Do not allow Bklog less than 0.

CREATE TABLE STU_MASTER_2(
	Rno INT PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
    SPI DECIMAL(4,2) NOT NULL CHECK (SPI < 10),
    Bklog INT NOT NULL CHECK (Bklog > 0)
);

--3.Enter the default value as ‘General’ in branch to all new records IF no other value is specified.

CREATE TABLE STU_MASTER_3(
	Rno INT PRIMARY KEY,
	NAME VARCHAR(100) NOT NULL,
	BRANCH VARCHAR(50) DEFAULT 'General',     
    SPI DECIMAL(4,2) NOT NULL CHECK (SPI < 10),
    Bklog INT NOT NULL CHECK (Bklog > 0)
);

--4.Try to update SPI of Raju from 8.80 to 12.

UPDATE STU_MASTER 
SET SPI = 12
WHERE SPI = 8.8

--5.Try to update Bklog of Neha from 0 to -1

UPDATE STU_MASTER
SET Bklog = -1
WHERE Bklog = 0

-------------------------------------PART B-----------------------------------

--1.Emp_details(Eid, Ename, Did, Cid, Salary, Experience), Dept_details(Did, Dname), City_details(Cid, Cname)

CREATE TABLE Dept_details(
	Did INT PRIMARY KEY,
    Dname VARCHAR(100) NOT NULL
);

CREATE TABLE City_details (
	Cid INT PRIMARY KEY,
	Cname VARCHAR(100) NOT NULL
);

CREATE TABLE Emp_details(
	Eid INT PRIMARY KEY,
    Ename VARCHAR(100) NOT NULL,
    Did INT NOT NULL,
    Cid INT NOT NULL,
    Salary DECIMAL(12,2) NOT NULL CHECK (Salary > 0),      
    Experience INT NOT NULL CHECK (Experience >= 0),     
    FOREIGN KEY (Did) REFERENCES Dept_details(Did),
    FOREIGN KEY (Cid) REFERENCES City_details(Cid)
);

INSERT INTO Dept_details (Did, Dname) 
VALUES (1, 'HR'),
	   (2, 'Engineering'),
	   (3, 'Sales')

INSERT INTO City_details (Cid, Cname) 
VALUES (10, 'Mumbai'),
	   (20, 'Delhi'),
	   (30, 'Ahmedabad')

INSERT INTO Emp_details (Eid, Ename, Did, Cid, Salary, Experience) 
VALUES (1001, 'Alice', 2, 20, 50000.00, 5)

----------

INSERT INTO Emp_details (Eid, Ename, Did, Cid, Salary, Experience)
VALUES (1002, 'Bob', 2, 20, -1000.00, 2)

INSERT INTO Emp_details (Eid, Ename, Did, Cid, Salary, Experience)
VALUES (1003, 'Charlie', 1, 10, 30000.00, -3)

INSERT INTO Emp_details (Eid, Ename, Did, Cid, Salary, Experience)
VALUES (1004, 'David', 99, 20, 45000.00, 4)

INSERT INTO Emp_details (Eid, Ename, Did, Cid, Salary, Experience)
VALUES (1005, 'Eve', 1, 999, 55000.00, 3)

INSERT INTO Emp_details (Eid, Ename, Did, Cid, Salary, Experience) 
VALUES (1001, 'Frank', 2, 10, 60000.00, 7)

SELECT * FROM Emp_details
SELECT * FROM Dept_details
SELECT * FROM City_details

-------------------------------------PART C-----------------------------------

--1.Emp_info(Eid, Ename, Did, Cid, Salary, Experience), Dept_info(Did, Dname), City_info(Cid, Cname, Did)), District(Did, Dname, Sid), State(Sid, Sname, Cid), Country(Cid, Cname)

CREATE TABLE Country_1(
	Cid INT PRIMARY KEY,
    Cname VARCHAR(100) NOT NULL
);

CREATE TABLE State_1(
    Sid INT PRIMARY KEY,
    Sname VARCHAR(100) NOT NULL,
    Cid INT NOT NULL,  
    FOREIGN KEY (Cid) REFERENCES Country_1(Cid)
);

CREATE TABLE District_1(
    Did INT PRIMARY KEY,
    Dname VARCHAR(100) NOT NULL,
    Sid INT NOT NULL,
    FOREIGN KEY (Sid) REFERENCES State_1(Sid)
);

CREATE TABLE City_info_1(
    Cid INT PRIMARY KEY,
    Cname VARCHAR(100) NOT NULL,
    Did INT NOT NULL,
    FOREIGN KEY (Did) REFERENCES District_1(Did)
);

CREATE TABLE Dept_info_1(
    Did INT PRIMARY KEY,
    Dname VARCHAR(100) NOT NULL
);

CREATE TABLE Emp_info_1(
    Eid INT PRIMARY KEY,
    Ename VARCHAR(100) NOT NULL,
    DeptDid INT NOT NULL,  
    CityCid INT NOT NULL,   
    Salary DECIMAL(12,2) NOT NULL CHECK (Salary > 0),
    Experience INT NOT NULL CHECK (Experience >= 0),
  
    FOREIGN KEY (DeptDid) REFERENCES Dept_info_1(Did),
    FOREIGN KEY (CityCid) REFERENCES City_info_1(Cid)
);

--2.Insert 5 records in each table.

INSERT INTO Country_1 (Cid, Cname)
VALUES (1, 'India'),
      (2, 'USA'),
      (3, 'UK'),
      (4, 'Australia'),
      (5, 'Canada')
  
INSERT INTO State_1 (Sid, Sname, Cid)
VALUES (10, 'Gujarat', 1),
      (11, 'California', 2),
      (12, 'England', 3),
      (13, 'New South Wales', 4),
      (14, 'Ontario', 5)

INSERT INTO District (Did, Dname, Sid) VALUES
  (100, 'Ahmedabad', 10),
  (101, 'Los Angeles County', 11),
  (102, 'Greater London', 12),
  (103, 'Sydney Region', 13),
  (104, 'Toronto Division', 14)

INSERT INTO City_info_1 (Cid, Cname, Did) 
VALUES (1000, 'Ahmedabad City', 100),
      (1001, 'LA City', 101),
      (1002, 'London City', 102),
      (1003, 'Sydney City', 103),
      (1004, 'Toronto City', 104)

INSERT INTO Dept_info_1 (Did, Dname)
VALUES (201, 'HR'),
      (202, 'Engineering'),
      (203, 'Sales'),
      (204, 'Marketing'),
      (205, 'Finance')

INSERT INTO Emp_info_1 (Eid, Ename, DeptDid, CityCid, Salary, Experience) 
VALUES (3001, 'Alice', 202, 1000, 50000.00, 5),
      (3002, 'Bob', 201, 1001, 60000.00, 8),
      (3003, 'Charlie', 203, 1002, 55000.00, 4),
      (3004, 'Diana', 204, 1003, 70000.00, 10),
      (3005, 'Ethan', 205, 1004, 65000.00, 6)

--3.Display employeename, departmentname, Salary, Experience, City, District, State and country of all employees.

SELECT
  e.Ename            AS EmployeeName,
  d.Dname            AS DepartmentName,
  e.Salary,
  e.Experience,
  ci.Cname           AS City,
  dist.Dname         AS District,
  st.Sname           AS State,
  cn.Cname           AS Country
FROM Emp_info_1 e
JOIN Dept_info_1 d ON e.DeptDid = d.Did
JOIN City_info_1 ci ON e.CityCid = ci.Cid
JOIN District_1 dist ON ci.Did = dist.Did
JOIN State_1 st ON dist.Sid = st.Sid
JOIN Country_1 cn ON st.Cid = cn.Cid;