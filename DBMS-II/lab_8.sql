------------------------------Part – A---------------------------------

--1.Handle Divide by Zero Error and Print message like: Error occurs that is - Divide by zero error.

BEGIN TRY
	DECLARE @NUM1 INT = 10
	DECLARE @NUM2 INT = 0
	DECLARE @RESULT INT

	SET @RESULT = @NUM1 / @NUM2
	PRINT 'RESULT = ' + CAST(@RESULT AS VARCHAR)
END TRY

BEGIN CATCH
	PRINT 'Error occurs that is - Divide by zero error.'
END CATCH

--2.Try to convert string to integer and handle the error using try…catch block.

BEGIN TRY
	DECLARE @NUM INT
	SET @NUM = CAST('ABC' AS INT)

	PRINT 'NUMBER = ' + CAST(@NUM AS VARCHAR)
END TRY

BEGIN CATCH
	PRINT 'ERROR: CANNOT CONVERT STRING TO INTEGER.'
END CATCH

--3.Create a procedure that prints the sum of two numbers: take both numbers as integer & handle exception with all error functions if any one enters string value in numbers otherwise print result.

CREATE OR ALTER PROCEDURE PR_SUM_OF_TwoNumbers
	@NUM1 VARCHAR(20),	
	@NUM2 VARCHAR(20)
AS
BEGIN
	BEGIN TRY
		DECLARE @A INT
		DECLARE @B INT
		DECLARE @SUM INT

		SET @A = CAST(@NUM1 AS INT)
		SET @B = CAST(@NUM2 AS INT)

		SET @SUM = @A + @B

		PRINT 'SUM = ' + CAST(@SUM AS VARCHAR)						 
	END TRY

	BEGIN CATCH
		PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE()
		PRINT 'ERROR NUMBER: ' + ERROR_NUMBER()
		PRINT 'ERROR SEVERITY: ' + ERROR_SEVERITY()
		PRINT 'ERROR STATE: ' + ERROR_STATE()
	END CATCH
END

EXEC PR_SUM_OF_TwoNumbers '10','5'
EXEC PR_SUM_OF_TwoNumbers '10', 'ABC'

--4.Handle a Primary Key Violation while inserting data into student table and print the error details such as the error message, error number, severity, and state.

SELECT * FROM STUDENT

BEGIN TRY
	INSERT INTO STUDENT
	VALUES(8, 'Vrii', 'V@GMAIL.COM', '9999999999', 'CSE', '2026-03-10', 2026, 8.5)
END TRY

BEGIN CATCH
	PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE()
	PRINT 'ERROR NUMBER: ' + ERROR_NUMBER()
	PRINT 'ERROR SEVERITY: ' + ERROR_SEVERITY()
	PRINT 'ERROR STATE: ' + ERROR_STATE()
END CATCH

--5.Throw custom exception using stored procedure which accepts StudentID as input & that throws Error like no StudentID is available in database.
--6.Handle a Foreign Key Violation while inserting data into Enrollment table and print appropriate error message.

------------------------------Part – B---------------------------------

--7.Handle Invalid Date Format
--8.Procedure to Update faculty’s Email with Error Handling.
--9.Throw custom exception that throws error if the data is invalid.

------------------------------Part – C---------------------------------

--10.Write a script that checks if a faculty’s salary is NULL. If it is, use RAISERROR to show a message with a severity of 16. (Note: Do not use any table)