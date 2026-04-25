-----------------------------------Part – A-------------------------------------

--1.Create a cursor Course_Cursor to fetch all rows from COURSE table and display them.

GO
DECLARE @CourseID VARCHAR(20),
        @CourseName VARCHAR(50),
        @CourseCredits INT,
        @CourseDepartment VARCHAR(100),
        @CourseSemester INT
DECLARE Course_Cursor CURSOR
FOR 
	SELECT * FROM COURSE
OPEN Course_Cursor
FETCH NEXT FROM Course_Cursor 
INTO @CourseID, @CourseName, @CourseCredits, @CourseDepartment, @CourseSemester
WHILE @@FETCH_STATUS = 0
BEGIN
	PRINT @CourseID + ' ' + @CourseName + ' ' + CAST(@CourseCredits AS VARCHAR(20)) + ' ' +  @CourseDepartment + ' ' + CAST(@CourseSemester AS VARCHAR(20))

	FETCH NEXT FROM Course_Cursor INTO @CourseID, @CourseName, @CourseCredits, @CourseDepartment, @CourseSemester
END
CLOSE Course_Cursor
DEALLOCATE Course_Cursor
GO

--2.Create a cursor Student_Cursor_Fetch to fetch records in form of StudentID_StudentName (Example: 1_Raj Patel).

GO
DECLARE @StuID VARCHAR(20),
        @StuName VARCHAR(20)
DECLARE Student_Cursor_Fetch CURSOR
FOR 
    SELECT StudentID, StuName
    FROM STUDENT
OPEN Student_Cursor_Fetch
FETCH NEXT FROM Student_Cursor_Fetch
INTO @StuID, @StuName
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @StuID + '_' + @StuName

    FETCH NEXT FROM Student_Cursor_Fetch
    INTO @StuID, @StuName
END
CLOSE Student_Cursor_Fetch
DEALLOCATE Student_Cursor_Fetch
GO

--3.Create a cursor to find and display all courses with Credits greater than 3.

GO
DECLARE @CourseName AS VARCHAR(100),
        @CourseCredit AS VARCHAR(20)
DECLARE Course_credit CURSOR
FOR
    SELECT * FROM COURSE
    WHERE CourseCredits > 3
OPEN Course_credit
FETCH NEXT FROM Course_credit
INTO @CourseName, @CourseCredit
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @CourseName + ' ' + @CourseCredit

    FETCH NEXT FROM Course_credit
    INTO @CourseName, @CourseCredit
END
CLOSE Course_credit
DEALLOCATE Course_credit
GO

--4.Create a cursor to display all students who enrolled in year 2021 or later.

GO
DECLARE @StuName VARCHAR(50),
        @StuEnrollYear VARCHAR(20)
DECLARE Cursor_Stu_By_Year CURSOR
FOR 
    SELECT StuName, StuEnrollmentYear
    FROM STUDENT
    WHERE StuEnrollmentYear >= '2021'
OPEN Cursor_Stu_By_Year
FETCH NEXT FROM Cursor_Stu_By_Year
INTO @StuName, @StuEnrollYear
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @StuNAME + ' ' + @StuEnrollYear

    FETCH NEXT FROM Cursor_Stu_By_Year
    INTO @StuName, @StuEnrollYear
END
CLOSE Cursor_Stu_By_Year
DEALLOCATE Cursor_Stu_By_Year
GO

--5.Create a cursor Course_CursorUpdate that retrieves all courses and increases Credits by 1 for courses with Credits less than 4.

GO
DECLARE @CourseName VARCHAR(50),
        @CourseCredit VARCHAR(20)
DECLARE Course_CursorUpdate CURSOR
FOR    
    SELECT CourseName, CourseCredits FROM COURSE
    WHERE CourseCredits > 4
OPEN Course_CursorUpdate
FETCH NEXT FROM Course_CursorUpdate
INTO @CourseName, @CourseCredit
WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE COURSE
    SET CourseCredits += 1

    FETCH NEXT FROM Course_CursorUpdate
    INTO @CourseName, @CourseCredit
END
CLOSE Course_CursorUpdate
DEALLOCATE Course_CursorUpdate
GO

--6.Create a Cursor to fetch Student Name with Course Name (Example: Raj Patel is enrolled in Database Management System)

GO
DECLARE @StuName VARCHAR(100),
        @CourseName VARCHAR(100)
DECLARE StudentWithCourse CURSOR
FOR
    SELECT 
        STUDENT.StuName,
        COURSE.CourseName
    FROM STUDENT JOIN ENROLLMENT
    ON STUDENT.StudentID = ENROLLMENT.StudentID
    JOIN COURSE
    ON COURSE.CourseID = ENROLLMENT.CourseID
OPEN StudentWithCourse
FETCH NEXT FROM StudentWithCourse 
INTO @StuName, @CourseName
WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT @StuName + ' ' + 'IS' + ' ' + 'ENROLLED IN' + ' ' + @CourseName

    FETCH NEXT FROM StudentWithCourse 
    INTO @StuName, @CourseName
END
CLOSE StudentWithCourse
DEALLOCATE StudentWithCourse
GO

--7.Create a cursor to insert data into new table if student belong to ‘CSE’ department. (create new table CSEStudent with relevant columns)

CREATE TABLE CseStudent(
    StudentID INT,
    StuName VARCHAR(100),
    StuDepartment VARCHAR(100)
)

GO
DECLARE @StuID INT,
        @StuName VARCHAR(100),
        @DEPT VARCHAR(100)
DECLARE InsertStudentInNewTable CURSOR
FOR
    SELECT StudentID, StuName, StuDepartment
    FROM STUDENT
    WHERE StuDepartment = 'CSE'
OPEN InsertStudentInNewTable
FETCH NEXT FROM InsertStudentInNewTable 
INTO @StuID, @StuName, @DEPT
WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO CseStudent (StudentID, StuName, StuDepartment)
    VALUES (@StuID, '@StuName', '@DEPT')

    FETCH NEXT FROM InsertStudentInNewTable 
    INTO @StuID, @StuName, @DEPT
END
CLOSE InsertStudentInNewTable
DEALLOCATE InsertStudentInNewTable
GO

-----------------------------------Part – B-------------------------------------

--8.Create a cursor to update all NULL grades to 'F' for enrollments with Status 'Completed'

GO
DECLARE @GRADE VARCHAR(5),
        @EnrStatus VARCHAR(100)
DECLARE UpdateGrades CURSOR
FOR
    SELECT Grade, EnrollmentStatus
    FROM ENROLLMENT
    WHERE Grade IS NULL AND EnrollmentStatus = 'Completed'
OPEN UpdateGrades
FETCH NEXT FROM UpdateGrades
INTO @GRADE, @EnrStatus
WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE ENROLLMENT
    SET Grade = 'F'
    WHERE Grade IS NULL AND EnrollmentStatus = 'Completed'

    FETCH NEXT FROM UpdateGrades
    INTO @GRADE, @EnrStatus
END
CLOSE UpdateGrades
DEALLOCATE UpdateGrades
GO

--9.Cursor to show Faculty with Course they teach (EX: Dr. Sheth teaches Data structure)

GO
DECLARE @FacName VARCHAR(100), 
        @CName VARCHAR(100)
DECLARE FacultyWithCourse CURSOR
FOR 
    SELECT FACULTY.FacultyName,
           COURSE.CourseName
    FROM FACULTY JOIN COURSE_ASSIGNMENT
    ON FACULTY.FacultyID = COURSE_ASSIGNMENT.FacultyID
    JOIN COURSE
    ON COURSE.CourseID = COURSE_ASSIGNMENT.CourseID
OPEN FacultyWithCourse
FETCH NEXT FROM FacultyWithCourse
INTO @FacName, @CName
WHILE @@FETCH_STATUS = 0
BEGIN 
    PRINT @FacName + ' ' + 'TEACHES' + ' ' + @CName

    FETCH NEXT FROM FacultyWithCourse
    INTO @FacName, @CName
END
CLOSE FacultyWithCourse
DEALLOCATE FacultyWithCourse
GO

-----------------------------------Part – C-------------------------------------

--10.Cursor to calculate total credits per student (Example: Raj Patel has total credits = 15)

GO
DECLARE @StuID INT,
        @StuName VARCHAR(100)
DECLARE CreditsPerStudents CURSOR
FOR 
    SELECT StudentID, StuName
    FROM STUDENT
OPEN CreditsPerStudents
FETCH NEXT FROM CreditsPerStudents
INTO @StuID, @StuName
WHILE @@FETCH_STATUS = 0
BEGIN
    DECLARE @TOTAL_CREDITS INT
    SET @TOTAL_CREDITS = 0

    SELECT @TOTAL_CREDITS = SUM(COURSE.CourseCredits)
    FROM ENROLLMENT JOIN COURSE
    ON ENROLLMENT.CourseID = COURSE.CourseID
    WHERE ENROLLMENT.StudentID = @StuID

     PRINT @StuName + ' has total credits = ' + CAST(ISNULL(@TOTAL_CREDITS,0) AS VARCHAR(10));

    FETCH NEXT FROM CreditsPerStudents
    INTO @StuID, @StuName
END
CLOSE CreditsPerStudents
DEALLOCATE CreditsPerStudents
GO
