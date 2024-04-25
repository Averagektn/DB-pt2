-- 1. —оздать хранимую функцию, получающую на вход идентификатор читател€ и возвращающую список идентификаторов книг, 
-- которые он уже прочитал и вернул в библиотеку.
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

-- 3. —оздать хранимую функцию, получающую на вход идентификатор читател€ и возвращающую 1, если у читател€ на руках сейчас менее дес€ти 
-- книг, и 0 в противном случае.
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

-- 4. —оздать хранимую функцию, получающую на вход год издани€ книги и возвращающую 1, если книга издана менее ста лет назад, и 0 в 
-- противном случае.
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

-- 5. —оздать хранимую процедуру, обновл€ющую все пол€ типа DATE (если такие есть) всех записей указанной таблицы на значение текущей даты.
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

-- 9. —оздать хранимую процедуру, автоматически создающую и наполн€ющую дан-ными таблицу Ђarrearsї, в которой должны быть представлены 
-- идентификаторы и имена читателей, у которых до сих пор находитс€ на руках хот€ бы одна книга, по которой дата возврата установлена в 
-- прошлом относительно текущей даты.
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