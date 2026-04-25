---------------------------------Part – A----------------------------------

CREATE TABLE LOG(
	LogMsg VARCHAR(100),
	LogDate DATETIME
)
					
SELECT * FROM STUDENT
SELECT * FROM COURSE
SELECT * FROM FACULTY	

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
	SELECT @DeletedCount = COUNT(*) FROM inserted

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
--8.Create trigger for preventing duplicate enrollment.

---------------------------------Part – C----------------------------------

--9.Create trigger to Allow enrolment in month from Jan to August, otherwise print message enrolment closed.
--10.Create trigger to Allow only grade change in enrollment (block other updates)