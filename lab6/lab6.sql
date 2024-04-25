-- 1. ������� �������� �������, ���������� �� ���� ������������� �������� � ������������ ������ ��������������� ����, 
-- ������� �� ��� �������� � ������ � ����������.
CREATE FUNCTION [GetReturnedBooksBySubscriber] (@subscriber_id INT)
RETURNS TABLE
AS
RETURN (
		SELECT [sb_book] AS [returned_book_id]
		FROM [subscriptions]
		WHERE [sb_subscriber] = @subscriber_id
			AND [sb_is_active] = 'N'
		);
GO

-- 3. ������� �������� �������, ���������� �� ���� ������������� �������� � ������������ 1, ���� � �������� �� ����� ������ ����� ������ 
-- ����, � 0 � ��������� ������.
CREATE FUNCTION [CheckReaderBooksCount] (@reader_id INT)
RETURNS BIT
AS
BEGIN
	DECLARE @book_count INT

	SELECT @book_count = COUNT([sb_id])
	FROM [subscriptions]
	WHERE [sb_subscriber] = @reader_id
		AND [sb_is_active] = 'Y'

	IF @book_count < 10
		RETURN 1

	RETURN 0
END;
GO

-- 4. ������� �������� �������, ���������� �� ���� ��� ������� ����� � ������������ 1, ���� ����� ������ ����� ��� ��� �����, � 0 � 
-- ��������� ������.
CREATE FUNCTION [CheckBookPublicationYear] (@publication_year INT)
RETURNS BIT
AS
BEGIN
	DECLARE @current_year INT

	SET @current_year = YEAR(GETDATE())

	IF (@current_year - @publication_year) < 100
		RETURN 1

	RETURN 0
END
GO

-- 5. ������� �������� ���������, ����������� ��� ���� ���� DATE (���� ����� ����) ���� ������� ��������� ������� �� �������� ������� ����.
CREATE PROCEDURE [UpdateDateFields] @table_name NVARCHAR(128)
AS
BEGIN
	DECLARE @sql NVARCHAR(MAX)

	SET @sql = 'UPDATE ' + QUOTENAME(@table_name) + ' SET '

	SELECT @sql = @sql + QUOTENAME([c].[name]) + ' = GETDATE(), '
	FROM [sys].[columns] AS [c]
	INNER JOIN [sys].[types] AS [t] ON [c].[user_type_id] = [t].[user_type_id]
	WHERE OBJECT_NAME(c.object_id) = @table_name
		AND [t].[name] = 'DATE'

	SET @sql = LEFT(@sql, LEN(@sql) - 1)

	EXEC sp_executesql @sql
END
GO

-- 9. ������� �������� ���������, ������������� ��������� � ����������� ���-���� ������� �arrears�, � ������� ������ ���� ������������ 
-- �������������� � ����� ���������, � ������� �� ��� ��� ��������� �� ����� ���� �� ���� �����, �� ������� ���� �������� ����������� � 
-- ������� ������������ ������� ����.
CREATE PROCEDURE CreateArrearsTable
AS
BEGIN
	IF OBJECT_ID('arrears', 'U') IS NOT NULL
	BEGIN
		DROP TABLE [arrears]
	END

	CREATE TABLE [arrears] (
		[arr_id] INT
		,[arr_name] NVARCHAR(150)
		)

	DECLARE @current_date DATE

	SET @current_date = GETDATE()

	INSERT INTO [arrears] (
		[arr_id]
		,[arr_name]
		)
	SELECT DISTINCT [subscribers].[s_id]
		,[subscribers].[s_name]
	FROM [subscriptions]
	INNER JOIN [subscribers] ON [subscribers].[s_id] = [subscriptions].[sb_subscriber]
	INNER JOIN [books] ON [books].[b_id] = [subscriptions].[sb_book]
	WHERE [subscriptions].[sb_finish] < @current_date
		AND [subscriptions].[sb_is_active] = 'Y'
END