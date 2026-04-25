CREATE TABLE STUDENT(
	StuID INT,
	FirstName VARCHAR(25),
	LastName VARCHAR(25),
	WEBSITE VARCHAR(50),
	CITY VARCHAR(25),
	ADDRESS VARCHAR(100)
);

INSERT INTO STUDENT (StuID, FirstName, LastName, WEBSITE, CITY, ADDRESS)
VALUES (1011, 'KEYUR', 'PATEL', 'TECHONTHENET.COM', 'RAJKOT', 'A-303 ''VASANT KUNJ'', RAJKOT'),
	(1022, 'HARDIK', 'SHAH', 'DIGMINECRAFT.COM', 'AHMEDABAD', '"RAM KRUPA", RAIYA ROAD'),
	(1033, 'KAJAL', 'TRIVEDI', 'BIGACTIVITES.COM', 'BARODA', 'RAJ BHAVAN PLOT, NEAR GARDEN'),
	(1044, 'BHOOMI', 'GAJERA', 'CHECKYOURMATH.COM', 'AHMEDABAD', '"JIG''S HOME", NAROL'),
	(1055, 'HARMIT', 'MITEL', '@ME.DARSHAN.COM', 'RAJKOT', 'B-55, RAJ RESIDENCY'),
	(1066, 'ASHOK', 'JANI', NULL, 'BARODA', 'A502, CLUB HOUSE BUILDING')

SELECT * FROM STUDENT

-------------------------------------PART A-----------------------------------

--1.Display the name of students whose name starts with ‘k’.

SELECT FirstName FROM STUDENT 
WHERE FirstName LIKE 'K%'

--2.Display the name of students whose name consists of five characters.

SELECT FirstName FROM STUDENT 
WHERE FirstName LIKE '_____'

--3.Retrieve the first name & last name of students whose city name ends with ‘a’ & contains six characters.

SELECT FirstName, LastName FROM STUDENT
WHERE CITY LIKE '_____A'

--4.Display all the students whose last name ends with ‘tel’.

SELECT LastName FROM STUDENT
WHERE LastName LIKE '%TEL'

--5.Display all the students whose first name starts with ‘ha’ & ends with‘t’.

SELECT FirstName FROM STUDENT 
WHERE FirstName LIKE 'HA%T'

--6.Display all the students whose first name starts with ‘k’ and third character is ‘y’.

SELECT FirstName FROM STUDENT
WHERE FirstName LIKE 'K_Y%'

--7.Display the name of students having no website and name consists of five characters.

SELECT FirstName FROM STUDENT
WHERE WEBSITE IS NULL AND FirstName LIKE '_____'

--8.Display all the students whose last name consist of ‘jer’.

SELECT LastName FROM STUDENT
WHERE LastName LIKE '%JER%'

--9.Display all the students whose city name starts with either ‘r’ or ‘b’.

SELECT FirstName FROM STUDENT
WHERE CITY LIKE 'R%' OR CITY LIKE 'B%'

--10.Display all the name students having websites.

SELECT FirstName FROM STUDENT
WHERE WEBSITE IS NOT NULL

--11.Display all the students whose name starts from alphabet A to H.

SELECT FirstName FROM STUDENT
WHERE FirstName LIKE '[A-H]%'

--12.Display all the students whose name’s second character is vowel.

SELECT FirstName FROM STUDENT
WHERE FirstName LIKE '_[AEIOU]'

--13.Display the name of students having no website and name consists of minimum five characters.

SELECT FirstName FROM STUDENT
WHERE WEBSITE IS NULL AND FirstName LIKE '_____'

--14.Display all the students whose last name starts with ‘Pat’.

SELECT LastName FROM STUDENT
WHERE LastName LIKE 'PAT%'

--15.Display all the students whose city name does not starts with ‘b’.

SELECT FirstName FROM STUDENT
WHERE CITY NOT LIKE 'B%'

--16.Display all the students whose student ID ends with digit.

SELECT FirstName FROM STUDENT
WHERE StuID LIKE '%[0-9$]'

--17.Display all the students whose address does not contain any digit.

SELECT FirstName FROM STUDENT
WHERE ADDRESS NOT LIKE '%[0-9]%'

--18.Find students whose first name starts with 'B', last name ends with 'A', and their website contains either 'math' or 'science'. Ensure that their city does not start with 'B'.

SELECT FirstName, LastName FROM STUDENT
WHERE FirstName LIKE 'B%' 
AND LastName LIKE '%A' 
AND WEBSITE LIKE '%MATH%' 
OR WEBSITE LIKE '%SCIENCE%' 
AND CITY NOT LIKE 'B%'

--19.Retrieve students who have 'Shah' in their last name and whose city ends with 'd'. Additionally, their website should be either null or contain 'com'.

SELECT FirstName FROM STUDENT 
WHERE LastName = 'SHAH' 
AND CITY LIKE '%D' 
AND WEBSITE IS NULL 
OR WEBSITE LIKE '%COM%'

--20.Select students whose first and second character is a vowel. Their city should start with 'R' and they must have a website containing '.com'.

SELECT FirstName FROM STUDENT
WHERE FirstName LIKE '[AEIOU][AEIOU]%'
AND CITY LIKE 'R%'
AND WEBSITE LIKE '%.COM'

-------------------------------------PART B-----------------------------------

--1.Display all the students whose name’s second character is vowel and of and start with H.

SELECT FirstName FROM STUDENT 
WHERE FirstName LIKE 'H[AEIOU]%'

--2.Display all the students whose last name does not ends with ‘a’.

SELECT FirstNAME FROM STUDENT
WHERE LastName NOT LIKE '%A'

--3.Display all the students whose first name starts with consonant.

SELECT FirstName FROM STUDENT
WHERE FirstName NOT LIKE '[AEIOU]%'

--4.Retrieve student details whose first name starts with 'K', last name ends with 'tel', and either their website contains 'tech' or they live in a city starting with 'R'.

SELECT FirstName FROM STUDENT
WHERE FirstName LIKE 'K%'
AND LastName LIKE '%TEL'
AND WEBSITE LIKE '%TECH%'
OR CITY LIKE 'R%'

--5.Retrieve students whose address contains a hyphen '-' and whose city starts with either 'R' or 'B'. They must have a website that ends with '.com' and their first name should not start with 'A'.

SELECT FirstNaME FROM STUDENT
WHERE ADDRESS LIKE '%-%'
AND CITY LIKE 'R%'
OR CITY LIKE 'B%'
AND WEBSITE LIKE '%.COM'
AND FirstName NOT LIKE 'A%'


-------------------------------------PART C----------------------------------

--1.Display all the students whose address contains single quote or double quote.

SELECT FirstName FROM STUDENT
WHERE ADDRESS LIKE '%''%''%'
OR ADDRESS LIKE '%"%"%'

--2.Find students whose city does not contain the letter 'S' and their address contains either single or double quotes. Their last name should start with 'P' and they must have a website that contains 'on'.

SELECT FirstName FROM STUDENT
WHERE CITY NOT LIKE '%S%'
AND ADDRESS LIKE '%''%''%'
OR ADDRESS LIKE '%"%"%'
AND LastName LIKE 'P%'
AND WEBSITE LIKE '%ON%'

--EXTRA

SELECT WEBSITE, LEFT(WEBSITE, 3) 
FROM STUDENT