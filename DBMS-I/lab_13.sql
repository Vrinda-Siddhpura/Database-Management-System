CREATE TABLE AUTHOR(
	AuthorID INT,
	AuthorName VARCHAR(100),
	Country VARCHAR(50)
);

INSERT INTO AUTHOR(AuthorID, AuthorName, Country)
VALUES(1, 'Chetan Bhagat', 'India'),
	(2, 'Arundhati Roy', 'India'),
	(3, 'Amish Tripathi', 'India'),
	(4, 'Ruskin Bond', 'India'),
	(5, 'Jhumpa Lahiri', 'India'),
	(6, 'Paulo Coelho', 'Brazil'),
	(7, 'Sudha Murty', 'India')

SELECT * FROM AUTHOR

CREATE TABLE PUBLISHER(
	PublisherID INT,
	PublisherName VARCHAR(100),
	City VARCHAR(50)
);

INSERT INTO PUBLISHER(PublisherID, PublisherName, City)
VALUES(1, 'Rupa Publications', 'New Delhi'),
	(2, 'Penguin India', 'Gurugram'),
	(3, 'HarperCollins India', 'Noida'),
	(4, 'Aleph Book Company', 'New Delhi')

SELECT * FROM PUBLISHER

CREATE TABLE BOOK(
	BookID INT,
	Title VARCHAR(200),
	AuthorID INT,
	PublisherID INT,
	Price DECIMAL(5,2),
	PublicationYear INT
);

INSERT INTO BOOK(BookID, Title, AuthorID, PublisherID, Price, PublicationYear)
VALUES(101, 'Five Point Someone', 1, 1, 250.00, 2004),
	(102, 'The God of Small Things', 2, 2, 350.00, 1997),
	(103, 'Immortals of Meluha', 3, 3, 300.00, 2010),
	(104, 'The Blue Umbrella', 4, 1, 180.00, 1980),
	(105, 'The Lowland', 5, 2, 400.00, 2013),
	(106, 'Revolution', 1, 1, 275.00, 2011),
	(107, 'Sita: Warrior of Mithila', 3, 3, 320.00, 2017),
	(108, 'The Room on the Roof', 4, 4, 200.00, 1956)

SELECT * FROM BOOK

-------------------------------------PART A-----------------------------------

--1.List all books with their authors.

SELECT 
	BOOK.Title, AUTHOR.AuthorName
FROM BOOK JOIN AUTHOR
ON BOOK.AuthorID = AUTHOR.AuthorID

--2.List all books with their publishers.

SELECT 
	BOOK.Title, PUBLISHER.PublisherName
FROM BOOK JOIN PUBLISHER
ON BOOK.PublisherID = PUBLISHER.PublisherID

--3.List all books with their authors and publishers.

SELECT 
	BOOK.Title, AUTHOR.AuthorName, PUBLISHER.PublisherName
FROM BOOK
JOIN AUTHOR
  ON BOOK.AuthorID = AUTHOR.AuthorID
JOIN PUBLISHER
  ON BOOK.PublisherID = PUBLISHER.PublisherID

--4.List all books published after 2010 with their authors and publisher and price.

SELECT 
	BOOK.Title, BOOK.PublicationYear, AUTHOR.AuthorName, BOOK.Price
FROM BOOK JOIN AUTHOR
ON BOOK.AuthorID = AUTHOR.AuthorID
WHERE BOOK.PublicationYear > 2010

--5.List all authors and the number of books they have written.

SELECT 
	AUTHOR.AuthorName, COUNT(BOOK.BookID) AS TOTAL_BOOKS
FROM AUTHOR LEFT OUTER JOIN BOOK
ON BOOK.AuthorID = AUTHOR.AuthorID
GROUP BY AUTHOR.AuthorName

--6.List all publishers and the total price of books they have published.

SELECT 
	PUBLISHER.PublisherName, SUM(BOOK.Price) AS TOTAL_PRICE
FROM PUBLISHER JOIN BOOK
ON PUBLISHER.PublisherID = BOOK.PublisherID
GROUP BY PUBLISHER.PublisherName

--7.List authors who have not written any books.

SELECT 
	AUTHOR.AuthorName, COUNT(BOOK.BookID) AS TOTAL_BOOKS
FROM AUTHOR LEFT OUTER JOIN BOOK
ON BOOK.AuthorID = AUTHOR.AuthorID
GROUP BY AUTHOR.AuthorName
HAVING COUNT(BOOK.BookID) = 0

--8.Display total number of Books and Average Price of every Author.

SELECT
	AUTHOR.AuthorName ,COUNT(BOOK.BookID) AS TOTAL_BOOKS, AVG(BOOK.Price) AS AVG_PRICE
FROM BOOK JOIN AUTHOR
ON BOOK.AuthorID = AUTHOR.AuthorID
GROUP BY AUTHOR.AuthorName

--9.lists each publisher along with the total number of books they have published, sorted from highest to lowest.

SELECT 
	PUBLISHER.PublisherName, COUNT(BOOK.BookID) AS TOTAL_BOOKS
FROM BOOK JOIN PUBLISHER
ON BOOK.PublisherID = PUBLISHER.PublisherID
GROUP BY PUBLISHER.PublisherName
ORDER BY COUNT(BOOK.BookID) DESC

--10.Display number of books published each year.

SELECT 
	BOOK.PublicationYear ,COUNT(BOOK.BookID) AS TOTAL_BOOKS
FROM BOOK JOIN PUBLISHER
ON BOOK.PublisherID = PUBLISHER.PublisherID
GROUP BY BOOK.PublicationYear

-------------------------------------PART B-----------------------------------

--1.List the publishers whose total book prices exceed 500, ordered by the total price.

SELECT 
	PUBLISHER.PublisherName, SUM(BOOK.Price) AS TOAL_PRICE
FROM BOOK JOIN PUBLISHER
ON BOOK.PublisherID = PUBLISHER.PublisherID
GROUP BY PUBLISHER.PublisherName
HAVING SUM(BOOK.Price) > 500
ORDER BY TOAL_PRICE

--2.List most expensive book for each author, sort it with the highest price.

SELECT 
	TOP 1
	AUTHOR.AuthorName,
	BOOK.Price AS HIGHEST_RICE
FROM AUTHOR JOIN BOOK
ON AUTHOR.AuthorID = BOOK.AuthorID
ORDER BY BOOK.Price DESC

-------------------------------------PART C-----------------------------------

--1.Emp_info(Eid, Ename, Did, Cid, Salary, Experience), Dept_info(Did, Dname), City_info(Cid, Cname, Did)), District(Did, Dname, Sid), State(Sid, Sname, Cid), Country(Cid, Cname)

CREATE TABLE Emp_info(
	Eid INT,
	Ename VARCHAR(20),
	Did INT,
	Cid INT,
	Salary DECIMAL(8,2),
	Experience INT
);

CREATE TABLE Dept_info(
	Did INT, 
	Dname VARCHAR(20)
);

CREATE TABLE City_info(
	Cid INT, 
	Cname VARCHAR(20), 
	Did INT
);

CREATE TABLE District(
	Did INT, 
	Dname VARCHAR(20), 
	Sid INT
);

CREATE TABLE State(
	Sid INT, 
	Sname VARCHAR(20), 
	Cid INT
);

CREATE TABLE Country(
	Cid INT, 
	Cname VARCHAR(20)
);

--2.Insert 5 records in each table.

INSERT INTO Emp_info(Eid, Ename, Did, Cid, Salary, Experience)
VALUES(1, 'Amit Patel', 100, 1000, 75000, 8),
	(2, 'Sophia Johnson', 101, 1001, 90000, 12),
	(3, 'Lukas Schmidt', 102, 1002, 85000, 10),
	(4, 'Emily Brown', 103, 1003, 78000, 7),
	(5, 'Michael Davis', 104, 1004, 92000, 15)

SELECT * FROM Emp_info

INSERT INTO Dept_info(Did, Dname)
VALUES (100, 'Engineering'),
	(101, 'Human Resources'),
	(102, 'Marketing'),
	(103, 'Finance'),
	(104, 'Customer Support')
	
SELECT * FROM Dept_info

INSERT INTO City_info(Cid, Cname, Did)
VALUES (1000, 'Rajkot', 100),            
	(1001, 'San Francisco', 101),
    (1002, 'Munich', 102),
    (1003, 'Sydney', 103),
    (1004, 'Toronto', 104)

SELECT * FROM City_info

INSERT INTO District(Did, Dname, Sid)
VALUES(100, 'Rajkot District', 10),
	(101, 'San Francisco County', 11),
	(102, 'Munich District', 12),
	(103, 'Sydney District', 13),
	(104, 'Toronto District', 14)

SELECT * FROM District

INSERT INTO State(Sid, Sname, Cid)
VALUES(10, 'Gujarat', 1),
	(11, 'California', 2),
	(12, 'Bavaria', 3),
	(13, 'New South Wales', 4),
	(14, 'Ontario', 5)

SELECT * FROM State

INSERT INTO Country(Cid, Cname)
VALUES(1, 'India'),
	(2, 'USA'),
	(3, 'Germany'),
	(4, 'Australia'),
	(5, 'Canada')

SELECT * FROM Country

--3.Display employeename, departmentname, Salary, Experience, City, District, State and country of all employees.

SELECT
	Emp_info.Ename, Dept_info.Dname, Emp_info.Salary, Emp_info.Experience, City_info.Cname, District.Dname, State.Sname, Country.Cname
FROM Emp_info JOIN Dept_info
ON Emp_info.Did = Dept_info.Did
JOIN City_info
ON Emp_info.Cid = City_info.Cid
JOIN District
ON City_info.Did = District.Did
JOIN State
ON District.Sid = State.Sid
JOIN Country
ON State.Cid = Country.Cid