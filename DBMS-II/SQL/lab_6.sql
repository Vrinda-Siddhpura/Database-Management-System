CREATE TABLE LOG(
	LogMessage varchar(100), 
	logDate Datetime
)

SELECT * FROM STUDENT
SELECT * FROM FACULTY
SELECT * FROM COURSE

---------------------------------Part – A-------------------------------

--1.Create trigger for printing appropriate message after student registration.

CREATE OR ALTER TRIGGER TR_STUDENT_REGISTRATION
ON STUDENT
AFTER INSERT
AS
BEGIN
	PRINT 'STUDENT INSERTED'
END

INSERT INTO STUDENT VALUES(30, 'Vrinda', 'v1@gmail.com', 9998612212, 'CSE', '2024-10-11', 2024, 8.79)

--2.Create trigger for printing appropriate message after faculty deletion.

CREATE OR ALTER TRIGGER TR_FACULTY_DELETE
ON FACULTY
AFTER DELETE
AS
BEGIN
	PRINT 'FACULTY DELETED'
END

INSERT INTO FACULTY VALUES(110, 'ABC', 'ABC.@GMAIL.COM', 'CSE', 'PROF', '2024-10-11')

DELETE FROM FACULTY
WHERE FacultyID = 110

--3.Create trigger for monitoring all events on course table. (print only appropriate message)

CREATE OR ALTER TRIGGER TR_COURSE_MONITORING
ON COURSE
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	PRINT 'SOMEONE IS MONITORING ON COURSE TABLE'
END

INSERT INTO COURSE VALUES('CS1', 'DBMS-2', 4, 'CSE', 4)

UPDATE COURSE 
SET CourseID = '1110'
WHERE CourseID = 'CS1'

DELETE FROM COURSE 
WHERE CourseID = '1110'

--4.Create trigger for logging data on new student registration in Log table.

CREATE OR ALTER TRIGGER TR_STUDENT_IN_LOG
ON STUDENT
AFTER INSERT
AS
BEGIN
	INSERT INTO LOG VALUES('STUDENT INSERTED',GETDATE())
END

INSERT INTO STUDENT VALUES(32, 'AASTHA', 'A@GMAIL.COM', 9429923246, 'CSE', '2024-07-24', 2025, 9)

SELECT * FROM LOG

--5.Create trigger for auto-uppercasing faculty names.

CREATE OR ALTER TRIGGER TR_FAC_UPPER_NAME
ON FACULTY
AFTER UPDATE
AS
BEGIN
	UPDATE FACULTY
	SET FacultyName = UPPER(FacultyName)
	WHERE FacultyID IN (SELECT DISTINCT FacultyID FROM inserted)
END

SELECT * FROM FACULTY

--6.Create trigger for calculating faculty experience (Note: Add required column in faculty table)

ALTER TABLE FACULTY
ADD FacExperience INT

CREATE OR ALTER TRIGGER TR_FAC_EXP_CALCS
ON FACULTY
AFTER INSERT
AS
BEGIN
	UPDATE FACULTY
	SET FacExperience = YEAR(GETDATE()) - YEAR(FACULTY.FacultyJoiningDate)
	FROM FACULTY JOIN inserted
	ON FACULTY.FacultyID = inserted.FacultyID
END

SELECT * FROM FACULTY

---------------------------------Part – B-------------------------------

--7.Create trigger for auto-stamping enrollment dates.

CREATE OR ALTER TRIGGER TR_ENROLLMENT_DATE
ON STUDENT
AFTER INSERT
AS
BEGIN
	UPDATE STUDENT
	SET EnrollmentDate = GETDATE()
	WHERE StudentID IN (SELECT StudentID FROM inserted)
END

--8.Create trigger for logging data After course assignment - log course and faculty detail.

CREATE TABLE COURSE_ASSIGNMENT2(
	FacultyID INT,
	CourseID VARCHAR(10)
)

CREATE OR ALTER TRIGGER TR_COURSE_ASSIGN_LOG2
ON COURSE_ASSIGNMENT2
AFTER INSERT
AS
BEGIN
	INSERT INTO LOG(LogMessage, logDate)
	SELECT 
		'Faculty ' + f.FacultyName + 
		' (' + CAST(f.FacultyID AS VARCHAR) + ')' +
		' from ' + f.FacultyDepartment +
		' assigned to Course ' + c.CourseName + 
		' (' + c.CourseID + ')',
		GETDATE()
	FROM inserted i
	JOIN FACULTY f ON i.FacultyID = f.FacultyID
	JOIN COURSE c ON i.CourseID = c.CourseID
END

---------------------------------Part - C-------------------------------

--9.Create trigger for updating student phone and print the old and new phone number.

CREATE OR ALTER TRIGGER TR_STUDENT_PHONE_UPDATE
ON STUDENT
AFTER UPDATE
AS
BEGIN
	IF UPDATE(StuPhone)
	BEGIN
		SELECT 
			d.StudentID,
			'Old: ' + CAST(d.StuPhone AS VARCHAR) +
			' -> New: ' + CAST(i.StuPhone AS VARCHAR) AS Message
		FROM deleted d
		JOIN inserted i
		ON d.StudentID = i.StudentID
	END
END

--10.Create trigger for updating course credit log old and new credits in log table.

CREATE OR ALTER TRIGGER TR_COURSE_CREDIT_LOG
ON COURSE
AFTER UPDATE
AS
BEGIN
	IF UPDATE(CourseCredits)
	BEGIN
		INSERT INTO LOG(LogMessage, logDate)
		SELECT 
			'Course ' + i.CourseID + 
			' credit changed from ' + CAST(d.CourseCredits AS VARCHAR) +
			' to ' + CAST(i.CourseCredits AS VARCHAR),
			GETDATE()
		FROM deleted d
		JOIN inserted i
		ON d.CourseID = i.CourseID
	END
END
