---------------------------------Part – A----------------------------------

CREATE TABLE LOG(
	LogMsg VARCHAR(100),
	LogDate DATETIME
)
					
SELECT * FROM STUDENT
SELECT * FROM COURSE
SELECT * FROM FACULTY
SELECT * FROM ENROLLMENT

--1.Create trigger for blocking student deletion.

CREATE OR ALTER TRIGGER TR_DELETE_STUDENT
ON STUDENT
INSTEAD OF DELETE
AS
BEGIN
	PRINT 'STUDENT DELETED IS BLOCKED!'
END

DELETE FROM STUDENT
WHERE StudentID = 32

DROP TRIGGER TR_DELETE_STUDENT

--2.Create trigger for making course read-only.

CREATE OR ALTER TRIGGER TR_COURSE_READ
ON COURSE
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	PRINT 'COURSE TABLE IS READ ONLY!!'
END

DELETE FROM COURSE
WHERE CourseID = 'CS101'

DROP TRIGGER TR_COURSE_READ

--3.Create trigger for preventing faculty removal.

CREATE OR ALTER TRIGGER TR_FACULTY_REMOVAL
ON FACULTY
INSTEAD OF DELETE
AS
BEGIN
	PRINT 'FACULTY DELETION IS NOT ALLOWED!!'
END

DELETE FROM FACULTY
WHERE FacultyID = 101

DROP TRIGGER TR_FACULTY_REMOVAL

--4.Create instead of trigger to log all operations on COURSE (INSERT/UPDATE/DELETE) into Log table. (Example: INSERT/UPDATE/DELETE operations are blocked for you in course table)

CREATE OR ALTER TRIGGER TR_LOG_ON_COURSE
ON COURSE
INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
	INSERT INTO LOG
	VALUES ('INSERT/UPDATE/DELETE operations are blocked for you in course table', GETDATE())

	--------

	DECLARE @InsertedCount INT,
			@DeletedCount INT

	SELECT @InsertedCount = COUNT(*) FROM inserted
	SELECT @DeletedCount = COUNT(*) FROM deleted

	IF @InsertedCount>0 AND @DeletedCount>0
		INSERT INTO LOG
		VALUES('UPDATE ATTEMPTED ON COURSE', GETDATE())

	ELSE IF @InsertedCount>0
		INSERT INTO LOG
		VALUES('INSERT ATTEMPTED ON COURSE', GETDATE())

	ELSE IF @DeletedCount>0
		INSERT INTO LOG
		VALUES('DELETE ATTEMPTED ON COURSE ', GETDATE())

	--------

END

DELETE FROM COURSE
WHERE CourseID = 'CS101'

SELECT * FROM LOG

DROP TRIGGER TR_LOG_ON_COURSE

--5.Create trigger to Block student to update their enrollment year and print message ‘students are not allowed to update their enrollment year’

CREATE OR ALTER TRIGGER TR_UPDATE_ENROLL_YEAR
ON STUDENT
INSTEAD OF UPDATE
AS
BEGIN
	IF UPDATE(StuEnrollmentYear)
	BEGIN
		PRINT 'students are not allowed to update their enrollment year'
		RETURN
	END
END

UPDATE STUDENT
SET StuEnrollmentYear = 2026
WHERE StudentID = 32

DROP TRIGGER TR_UPDATE_ENROLL_YEAR

--6.Create trigger for student age validation (Min 18).

CREATE OR ALTER TRIGGER TR_AGE_VALIDATION
ON STUDENT
AFTER INSERT, UPDATE
AS
BEGIN
	DECLARE @DOB DATE

	SELECT @DOB = StuDateOfBirth FROM inserted

	IF DATEDIFF(YEAR, @DOB, GETDATE()) < 18
	BEGIN
		PRINT 'STUDENT MUST BE AL LEAST 18 YEARS OLD!!'
		RETURN
	END

	INSERT INTO STUDENT
	SELECT * FROM inserted
END

UPDATE STUDENT
SET StuDateOfBirth = '2025-01-01'
WHERE StudentID = 4

SELECT * FROM STUDENT

DROP TRIGGER TR_AGE_VALIDATION

---------------------------------Part – B----------------------------------

--7.Create trigger for unique faculty’s email check.

CREATE OR ALTER TRIGGER TR_UNIQUE_EMAIL
ON FACULTY
INSTEAD OF INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM FACULTY F
		JOIN inserted I
		ON F.FacultyEmail = I.FacultyEmail
		WHERE F.FacultyID <> I.FacultyID
	)
	BEGIN
		PRINT 'EMAIL MUST BE UNIQUE!'
		RETURN
	END

	INSERT INTO FACULTY
	SELECT * FROM inserted
END

--8.Create trigger for preventing duplicate enrollment.

CREATE OR ALTER TRIGGER TR_NO_DUPLICATE_ENROLL
ON ENROLLMENT
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM ENROLLMENT E
		JOIN inserted I
		ON E.StudentID = I.StudentID
		AND E.CourseID = I.CourseID
	)
	BEGIN
		PRINT 'DUPLICATE ENROLLMENT NOT ALLOWED!'
		RETURN
	END

	INSERT INTO ENROLLMENT (StudentID, CourseID, EnrollmentDate, Grade, EnrollmentStatus)
	SELECT StudentID, CourseID, EnrollmentDate, Grade, EnrollmentStatus
	FROM inserted
END

---------------------------------Part – C----------------------------------

--9.Create trigger to Allow enrolment in month from Jan to August, otherwise print message enrolment closed.

CREATE OR ALTER TRIGGER TR_RULES_ENROLL
ON ENROLLMENT
INSTEAD OF INSERT
AS
BEGIN
	IF EXISTS (
		SELECT 1
		FROM inserted
		WHERE MONTH(EnrollmentDate) NOT BETWEEN 1 AND 8
	)
	BEGIN
		PRINT 'ENROLLMENT CLOSED!'
		RETURN
	END

	INSERT INTO ENROLLMENT (StudentID, CourseID, EnrollmentDate, Grade, EnrollmentStatus)
	SELECT StudentID, CourseID, EnrollmentDate, Grade, EnrollmentStatus
	FROM inserted
END

--10.Create trigger to Allow only grade change in enrollment (block other updates)

CREATE OR ALTER TRIGGER TR_ONLY_GRADE_UPDATE
ON ENROLLMENT
INSTEAD OF UPDATE
AS
BEGIN
	IF UPDATE(StudentID) OR UPDATE(CourseID) 
	   OR UPDATE(EnrollmentDate) OR UPDATE(EnrollmentStatus)
	BEGIN
		PRINT 'ONLY GRADE CAN BE UPDATED!'
		RETURN
	END

	UPDATE E
	SET E.Grade = I.Grade
	FROM ENROLLMENT E
	JOIN inserted I
	ON E.EnrollmentID = I.EnrollmentID
END
