-------------------------------Part – A-------------------------------- 

--1.INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)

--StuID	  Name	         Email	        Phone	  Department	DOB	      EnrollmentYear
-- 10	Harsh Parmar  harsh@univ.edu  9876543218	CSE	      2005-09-18	2023
-- 20	Om Patel	  om@univ.edu     9876543211	IT	      2002-08-22	2022

CREATE OR ALTER PROCEDURE PR_INSERT_STUDENT
@StuID INT,
@Name VARCHAR(100), 
@Email VARCHAR(100),
@Phone VARCHAR(15),
@Department VARCHAR(50),	
@DOB DATE,
@EnrollmentYear INT,
@Cgpa DECIMAL(3,2)
AS
BEGIN
	INSERT INTO STUDENT VALUES(@StuID, '@Name', '@Email', @Phone, '@Department', @DOB, @EnrollmentYear, @Cgpa)
END

EXEC PR_INSERT_STUDENT 10, 'Harsh Parmar', 'harsh@univ.edu', 9876543218, 'CSE', '2005-09-18', 2023, NULL
EXEC PR_INSERT_STUDENT 20, 'Om Patel', 'om@univ.edu', 9876543211, 'IT', '2002-08-22', 2022, NULL

--2.INSERT Procedures: Create stored procedures to insert records into COURSE tables (SP_INSERT_COURSE)

--CourseID	   CourseName	      Credits	Dept	Semester
-- CS330	Computer Networks	    4	     CSE	   5
-- EC120	Electronic Circuits	    3	     ECE	   2

CREATE OR ALTER PROCEDURE PR_INSTER_COURSE
@CourseID VARCHAR(10),
@CourseName VARCHAR(100),
@Credits INT,
@Dept VARCHAR(50),
@Semester INT
AS
BEGIN
	INSERT INTO COURSE VALUES (@CourseID, @CourseName, @Credits, @Dept, @Semester)
END

EXEC PR_INSTER_COURSE 'CS330', 'Computer Networks', 4, 'CSE', 5
EXEC PR_INSTER_COURSE 'EC120', 'Electronic Circuits', 3, 'ECE', 2

--3.UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)

CREATE OR ALTER PROCEDURE PR_UPDATE_STUDENT
@StuID INT
AS
BEGIN
	UPDATE STUDENT
	SET StuEmail = 'vrinda11@gmail.com', StuPhone = 9998612217
	WHERE StudentID = @StuID
END

EXEC PR_UPDATE_STUDENT 3

--4.DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.

CREATE OR ALTER PROCEDURE PR_DELETE_STUDENT
AS
BEGIN
	DELETE FROM STUDENT
	WHERE StuName = 'Om Patel'
END

--5.SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.

CREATE OR ALTER PROCEDURE PR_SELECT_STUDENT_BY_ID
@StuID INT
AS
BEGIN
	SELECT * FROM STUDENT
	WHERE StudentID = @StuID
END

EXEC PR_SELECT_STUDENT_BY_ID 3

--6.Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.

CREATE OR ALTER PROCEDURE PR_STUDENT_DETAILS
AS
BEGIN
	SELECT TOP 5 * FROM STUDENT
	ORDER BY StuEnrollmentYear
END

EXEC PR_STUDENT_DETAILS

-------------------------------Part – B-------------------------------- 

--7.Create a stored procedure which displays faculty designation-wise count.

CREATE OR ALTER PROCEDURE PR_DISPLAY_FACULTY
AS
BEGIN
	SELECT FacultyDesignation, COUNT(FacultyID)
	FROM FACULTY
	GROUP BY FacultyDesignation
END

EXEC PR_DISPLAY_FACULTY

--8.Create a stored procedure that takes department name as input and returns all students in that department.

CREATE OR ALTER PROCEDURE PR_STUDENT_BY_DEPARTMENT
@DeptName VARCHAR(50)
AS
BEGIN
	SELECT StuName 
	FROM STUDENT
	WHERE StuDepartment = @DeptName
END

EXEC PR_STUDENT_BY_DEPARTMENT 'IT'

-------------------------------Part – C-------------------------------- 

--9.Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.

CREATE OR ALTER PROCEDURE PR_DEPTWISE_COURSE_CREDITS
AS
BEGIN
	SELECT CourseDepartment, MAX(CourseCredits) AS MAX_CREDITS, MIN(CourseCredits) AS MIN_CREDITS, AVG(CourseCredits) AS AVG_CREDITS
	FROM COURSE
	GROUP BY CourseDepartment
END

EXEC PR_DEPTWISE_COURSE_CREDITS

--10.Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.

CREATE OR ALTER PROCEDURE PR_STUDENT_ENROLLED
@StuID INT
AS
BEGIN
	SELECT COURSE.CourseName, ENROLLMENT.Grade
	FROM STUDENT JOIN ENROLLMENT
	ON STUDENT.StudentID = ENROLLMENT.StudentID
	JOIN COURSE
	ON COURSE.CourseID = ENROLLMENT.CourseID
	WHERE STUDENT.StudentID = @StuID
END

EXEC PR_STUDENT_ENROLLED 1