-----------------------------------Part - A-----------------------------------

--1.Write a scalar function to print "Welcome to DBMS Lab".

CREATE OR ALTER FUNCTION FN_WELCOME()
RETURNS VARCHAR(50)
AS
BEGIN
	RETURN 'Welcome to DBMS Lab.'
END

SELECT dbo.FN_WELCOME()

--2.Write a scalar function to calculate simple interest.

CREATE OR ALTER FUNCTION FN_INTEREST(
@P FLOAT,
@R FLOAT,
@T FLOAT
)
RETURNS FLOAT
AS
BEGIN
	RETURN (@P *@R *@T)/100
END

SELECT dbo.FN_INTEREST(1000,2,2)

--3.Function to Get Difference in Days Between Two Given Dates

CREATE OR ALTER FUNCTION FN_DATEDIFF(
@D1 DATE,
@D2 DATE
)
RETURNS INT
AS
BEGIN
	RETURN DATEDIFF(DAY, @D1, @D2)
END

SELECT dbo.FN_DATEDIFF('2006-10-2','2025-10-2')

--4.Write a scalar function which returns the sum of Credits for two given CourseIDs.

CREATE OR ALTER FUNCTION FN_CreditSum(
@C1 INT,
@C2 INT
)
RETURNS INT
AS
BEGIN
	RETURN @C1 + @C2
END

SELECT dbo.FN_CreditSum(4,4)

--5.Write a function to check whether the given number is ODD or EVEN.

CREATE OR ALTER FUNCTION FN_OddEven(
@Num INT
)
RETURNS VARCHAR(20)
AS
BEGIN
	IF @Num%2=0
		RETURN 'EVEN NUMBER'

	RETURN 'ODD NUMMBER'
END

SELECT dbo.FN_OddEven(3)

--6.Write a function to print number from 1 to N. (Using while loop)

CREATE OR ALTER FUNCTION FN_NumPrint(
@Num INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	DECLARE @MSG VARCHAR(MAX),
			@COUNT INT

	SET @MSG = ' '
	SET @COUNT = 1

	WHILE @COUNT<=@Num
	BEGIN
		SET @MSG = @MSG + ' ' + CAST(@COUNT AS VARCHAR)
		SET @COUNT = @COUNT + 1
	END

	RETURN @MSG
END

SELECT dbo.FN_NumPrint(5)

--7.Write a scalar function to calculate factorial of total credits for a given CourseID.

CREATE OR ALTER FUNCTION FN_FACTORIAL(
@Num INT
)
RETURNS INT
AS
BEGIN
	DECLARE @RES INT
	SET @RES = 1

	WHILE @Num > 1
	BEGIN
		SET @RES = @RES * @Num
		SET @Num = @Num - 1
	END

	RETURN @RES
END

SELECT dbo.FN_FACTORIAL(5)

--8.Write a scalar function to check whether a given EnrollmentYear is in the past, current or future (Case statement)

CREATE OR ALTER FUNCTION FN_CheckEnrollmentYear(
@YEAR INT
)
RETURNS VARCHAR(50)
AS
BEGIN
	DECLARE @RES VARCHAR(50)

	SET @RES = 
		CASE 
			WHEN @YEAR < YEAR(GETDATE()) THEN 'PAST'
			WHEN @YEAR = YEAR(GETDATE()) THEN 'CURRENT'
			ELSE 'FUTURE'
		END

	RETURN @RES
END

SELECT dbo.FN_CheckEnrollmentYear(2022)

--9.Write a table-valued function that returns details of students whose names start with a given letter.

CREATE OR ALTER FUNCTION FN_StudentByLetter(
@CHAR VARCHAR(1)
)
RETURNS TABLE
AS
RETURN
(
	SELECT *
	FROM STUDENT
	WHERE StuName LIKE @CHAR + '%'
)

SELECT * FROM dbo.FN_StudentByLetter('A')

--10.Write a table-valued function that returns unique department names from the STUDENT table.

CREATE OR ALTER FUNCTION FN_StudentByDept()
RETURNS TABLE
AS
RETURN
(
	SELECT DISTINCT StuDepartment
	FROM STUDENT															 
)

SELECT * FROM FN_StudentByDept()

-----------------------------------Part - B-----------------------------------

--11.Write a scalar function that calculates age in years given a DateOfBirth.

CREATE OR ALTER FUNCTION FN_CalculateAge(
@DOB DATETIME
)
RETURNS INT
AS
BEGIN
	DECLARE @AGE INT

	SET @AGE = DATEDIFF(YEAR, @DOB, GETDATE())

    IF (DATEADD(YEAR, @AGE, @DOB) > GETDATE())
        SET @AGE = @AGE - 1

    RETURN @AGE
END

SELECT dbo.FN_CalculateAge('2006-10-11')

--12.Write a scalar function to check whether given number is palindrome or not.

CREATE OR ALTER FUNCTION FN_CheckPalindrome(
@NUM INT
)
RETURNS VARCHAR(MAX)
AS
BEGIN

	IF @NUM=REVERSE(@NUM)
		RETURN 'NUMBER IS PALINDROME'

	RETURN 'NUMBER IS NOT PALINDROME'
END

SELECT dbo.FN_CheckPalindrome(121)

--13.Write a scalar function to calculate the sum of Credits for all courses in the 'CSE' department.

CREATE OR ALTER FUNCTION FN_CreditSum()
RETURNS FLOAT
AS
BEGIN
	DECLARE @SUM FLOAT

	SELECT @SUM = SUM(CourseCredits)
	FROM COURSE
	WHERE CourseDepartment = 'CSE'

	RETURN @SUM
END

SELECT dbo.FN_CreditSum()

--14.Write a table-valued function that returns all courses taught by faculty with a specific designation.

CREATE OR ALTER FUNCTION FN_CourseToughtByFac(
@DESIGNATION VARCHAR(MAX)
)
RETURNS TABLE
AS
RETURN
(	
	SELECT
		COURSE.CourseName,
		FACULTY.FacultyName
	FROM COURSE JOIN COURSE_ASSIGNMENT
	ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
	JOIN FACULTY
	ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
	WHERE FACULTY.FacultyDesignation = @DESIGNATION
)

SELECT * FROM dbo.FN_CourseToughtByFac('Professor')

-----------------------------------Part - C-----------------------------------

--15.Write a scalar function that accepts StudentID and returns their total enrolled credits (sum of credits from all active enrollments).

CREATE OR ALTER FUNCTION FN_SumOfCredits(
@StuID INT
)
RETURNS INT
AS
BEGIN
	DECLARE @SUM INT

	SELECT
		@SUM = SUM(COURSE.CourseCredits)
	FROM ENROLLMENT JOIN COURSE
	ON ENROLLMENT.CourseID = COURSE.CourseID
	WHERE ENROLLMENT.EnrollmentStatus = 'ACTIVE'

	RETURN @SUM
END

SELECT dbo.FN_SumOfCredits(101)

--16.Write a scalar function that accepts two dates (joining date range) and returns the count of faculty who joined in that period.

CREATE OR ALTER FUNCTION FN_FacultyJoinPeriod(
@DATE1 DATETIME,
@DATE2 DATETIME
)
RETURNS TABLE
AS
RETURN
(
	SELECT * FROM FACULTY
	WHERE FacultyJoiningDate BETWEEN @DATE1 AND @DATE2
)

SELECT * FROM FN_FacultyJoinPeriod('2010-07-15', '2018-01-15')
