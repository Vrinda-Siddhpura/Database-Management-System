-------------------------------Part – A-------------------------------- 

--1.Create a stored procedure that accepts a date and returns all faculty members who joined on that date.

CREATE OR ALTER PROCEDURE PR_FACULTY_BY_DATE
@JoiningDate DATE
AS
BEGIN
	SELECT * FROM FACULTY
	WHERE FacultyJoiningDate = @JoiningDate
END

EXEC PR_FACULTY_BY_DATE '2010-07-15'

--2.Create a stored procedure for ENROLLMENT table where user enters StudentID and returns EnrollmentID, EnrollmentDate, Grade, and Status.

CREATE OR ALTER PROCEDURE PR_STUDENT_ENTERS
@StuID INT = NULL,
@CourseID VARCHAR(10) = NULL
AS
BEGIN
	SELECT EnrollmentID, EnrollmentDate, Grade, EnrollmentStatus
	FROM ENROLLMENT
	WHERE StudentID = @StuID OR CourseID = @CourseID
END

EXEC PR_STUDENT_ENTERS 1
EXEC PR_STUDENT_ENTERS @CourseID = 'CS101'

--3.Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.

CREATE OR ALTER PROCEDURE PR_COURSE_BY_CREDITS
@MIN INT,
@MAX INT
AS
BEGIN
	SELECT CourseName 
	FROM COURSE
	WHERE CourseCredits BETWEEN @MIN AND @MAX
END

EXEC PR_COURSE_BY_CREDITS 3, 4

--4.Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.

CREATE OR ALTER PROCEDURE PR_STUDENT_BY_COURSES
@StuDept VARCHAR(100)
AS
BEGIN
	SELECT STUDENT.StuName
	FROM STUDENT JOIN ENROLLMENT
	ON STUDENT.StudentID = ENROLLMENT.StudentID
	JOIN COURSE
	ON COURSE.CourseID = ENROLLMENT.CourseID
	WHERE STUDENT.StuDepartment = @StuDept
END

EXEC PR_STUDENT_BY_COURSES 'CSE'

--5.Create a stored procedure that accepts Faculty Name and returns all course assignments.

CREATE OR ALTER PROCEDURE PR_FACULTY_AND_COURSE
@FacName VARCHAR(50)
AS
BEGIN
	SELECT COURSE.CourseName
	FROM COURSE JOIN COURSE_ASSIGNMENT
	ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
	JOIN FACULTY
	ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
	WHERE FACULTY.FacultyName = @FacName
END

EXEC PR_FACULTY_AND_COURSE 'Dr. Sheth'

--6.Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.

CREATE OR ALTER PROCEDURE PR_FAC_BY_SEM_YEAR
@Sem INT,
@Year INT
AS
BEGIN
	SELECT COURSE_ASSIGNMENT.AssignmentID, COURSE_ASSIGNMENT.ClassRoom, FACULTY.FacultyName
	FROM COURSE_ASSIGNMENT JOIN FACULTY
	ON COURSE_ASSIGNMENT.FacultyID = FACULTY.FacultyID
	WHERE COURSE_ASSIGNMENT.Semester = @Sem AND COURSE_ASSIGNMENT.Year = @Year
END

EXEC PR_FAC_BY_SEM_YEAR 3, 2024

-------------------------------Part – B-------------------------------- 

--7.Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.

CREATE OR ALTER PROCEDURE PR_ENROLLMENT_BY_LETTER
@LETTER VARCHAR(1)
AS
BEGIN
	SELECT * FROM ENROLLMENT
	WHERE EnrollmentStatus LIKE @LETTER+'%'
END

EXEC PR_ENROLLMENT_BY_LETTER 'A'

--8.Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.

CREATE OR ALTER PROCEDURE PR_STUDENT_BY_STU_DEPT
@StuName VARCHAR(50) = NULL,
@DeptName VARCHAR(50) = NULL
AS
BEGIN
	SELECT * FROM STUDENT
	WHERE StuName = @StuName OR StuDepartment = @DeptName
END

EXEC PR_STUDENT_BY_STU_DEPT @DeptName = 'CSE'
EXEC PR_STUDENT_BY_STU_DEPT 'Raj Patel'


--9.Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.

CREATE OR ALTER PROCEDURE PR_STATUS_WISE_COUNT
@CourseID VARCHAR(10)
AS
BEGIN
	SELECT ENROLLMENT.EnrollmentStatus,ENROLLMENT.CourseID, COUNT(ENROLLMENT.StudentID)
	FROM COURSE JOIN ENROLLMENT
	ON COURSE.CourseID = ENROLLMENT.CourseID
	WHERE COURSE.CourseID = @CourseID
	GROUP BY ENROLLMENT.EnrollmentStatus, ENROLLMENT.CourseID
END

EXEC PR_STATUS_WISE_COUNT 'CS101' 

-------------------------------Part – C-------------------------------- 

--10.Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.

CREATE OR ALTER PROCEDURE PR_FACULTY_BY_COURSES
@Year INT
AS
BEGIN
	SELECT  FACULTY.FacultyName, COURSE_ASSIGNMENT.ClassRoom
	FROM FACULTY JOIN COURSE_ASSIGNMENT
	ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
	WHERE COURSE_ASSIGNMENT.Year = @Year
END

EXEC PR_FACULTY_BY_COURSES 2024

--11.Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.


CREATE OR ALTER PROCEDURE PR_STUDENT_BY_BDATE
@MinDate DATE,
@MaxDate DATE
AS
BEGIN
	SELECT STUDENT.StuName,STUDENT.StuDateOfBirth, COURSE.*
	FROM STUDENT JOIN ENROLLMENT
	ON STUDENT.StudentID = ENROLLMENT.StudentID
	JOIN COURSE
	ON COURSE.CourseID = ENROLLMENT.CourseID
	WHERE STUDENT.StuDateOfBirth BETWEEN @MinDate AND @MaxDate
END

EXEC PR_STUDENT_BY_BDATE '2003-05-15', '2004-11-10'

--12.Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).

CREATE OR ALTER PROCEDURE PR_COURSE_DEPT_BY_FACID
@FacultyID INT
AS
BEGIN
	SELECT COURSE.CourseDepartment, SUM(COURSE.CourseCredits)
	FROM COURSE JOIN COURSE_ASSIGNMENT
	ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
	JOIN FACULTY
	ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
	WHERE FACULTY.FacultyID = @FacultyID
	GROUP BY COURSE.CourseDepartment
END

EXEC PR_COURSE_DEPT_BY_FACID 101

--------EXTRA

CREATE OR ALTER PROCEDURE PR_COURSE_OFFERED_BY_DEPT
@CourseDept VARCHAR(50),
@COUNT INT OUTPUT
AS
BEGIN
	SELECT  @COUNT = COUNT(CourseID)
	FROM COURSE
	WHERE CourseDepartment = @CourseDept
	GROUP BY CourseDepartment
END

DECLARE @COUNT2 INT
EXEC PR_COURSE_OFFERED_BY_DEPT 'CSE', @COUNT = @COUNT2 OUTPUT
SELECT @COUNT2