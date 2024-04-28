

-- 1.	������� �������� ���������, �������:
-- a.	��������� ������ ����� ��� ��������� �����;
-- b.	�������� ����������� ��������, ���� � �������� ������ ���� �� ���� �������� ������� ����������� ������� � ���� ������������ 
-- �������� ���������� ����� ������� �m2m_books_genres� (�.�. � ����� ����� ��� ��� ����� ����).
CREATE PROCEDURE [AddGenresToBooks]
AS
BEGIN
	SET NOCOUNT ON;

	BEGIN TRY
		BEGIN TRANSACTION;

		DECLARE @book_id INT;
		DECLARE @genre_id INT;
		DECLARE @genre_count INT = 2;

		DECLARE [book_cursor] CURSOR
		FOR
		SELECT [b].[b_id]
		FROM [books] [b];

		OPEN [book_cursor];

		FETCH NEXT
		FROM [book_cursor]
		INTO @book_id;

		WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE [genre_cursor] CURSOR
			FOR
			SELECT TOP (@genre_count) [g].[g_id]
			FROM [genres] [g]
			WHERE NOT EXISTS (
					SELECT 1
					FROM [m2m_books_genres] [bg]
					WHERE [bg].[b_id] = @book_id
						AND [bg].[g_id] = [g].[g_id]
					)
			ORDER BY NEWID();

			OPEN [genre_cursor];

			FETCH NEXT
			FROM [genre_cursor]
			INTO @genre_id;

			WHILE @@FETCH_STATUS = 0
			BEGIN
				INSERT INTO [m2m_books_genres] (
					[b_id]
					,[g_id]
					)
				VALUES (
					@book_id
					,@genre_id
					);

				FETCH NEXT
				FROM [genre_cursor]
				INTO @genre_id;
			END;

			CLOSE [genre_cursor];

			DEALLOCATE [genre_cursor];

			FETCH NEXT
			FROM [book_cursor]
			INTO @book_id;
		END;

		CLOSE [book_cursor];

		DEALLOCATE [book_cursor];

		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRANSACTION;

		THROW;
	END CATCH;
END;
GO

-- 2.	������� �������� ���������, �������:
-- a.	����������� �������� ���� �b_quantity� ��� ���� ���� � ��� ����;
-- b.	�������� ����������� ��������, ���� �� ����� ���������� �������� ������� ���������� ����������� ���� �������� �������� 50.
CREATE PROCEDURE [IncreaseBookQuantity]
AS
BEGIN
	BEGIN TRANSACTION;

	UPDATE [books]
	SET [b_quantity] = [b_quantity] * 2;

	DECLARE @average_quantity INT;

	SELECT @average_quantity = AVG([b_quantity])
	FROM [books];

	IF @average_quantity > 50
	BEGIN
		ROLLBACK;

		RAISERROR (
				'Average quantity exceeds 50. Transaction rolled back.'
				,16
				,1
				);

		RETURN;
	END

	COMMIT;
END
GO

-- 3.	�������� �������, �������, ������ ������������ �����������, ������������ �� ��������� ������:
-- a.	������ ������ ������ ������� ���������� �������� �� ���� � ������������ � ���������� ���� � �� �������� �� �������� �� ���������� 
-- ������� �subscriptions� (�� ����� �� ����������);
SET IMPLICIT_TRANSACTIONS ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN TRANSACTION;

SELECT COUNT([s].[sb_id]) AS [issued_books_count]
FROM [subscriptions] [s]
WHERE [s].[sb_is_active] = 'Y';

COMMIT;

-- b.	������ ������ ������ ������������� �������� ���� �sb_is_active� ������� subscriptions � �Y� �� �N� � �������� � �� �������� �� 
-- ������� ������� (�� ����� ��� ����������).
SET IMPLICIT_TRANSACTIONS ON;

BEGIN TRANSACTION;

UPDATE [subscriptions]
SET [sb_is_active] = CASE 
		WHEN [sb_is_active] = 'Y'
			THEN 'N'
		ELSE 'Y'
		END;

COMMIT;

-- 5.	�������� ���, � ������� ������, ������������� �������� ���� �sb_is_active� ������� �subscriptions� � �Y� �� �N� � ��������, 
-- ����� ����� ������������ ����� �� �������� ���������� � ������ ������������� �������� �������� ���������� � ������� ������������.
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

BEGIN TRANSACTION;

BEGIN TRY
	UPDATE [subscriptions]
	SET [sb_is_active] = CASE 
			WHEN [sb_is_active] = 'Y'
				THEN 'N'
			ELSE 'Y'
			END;

	COMMIT;
END TRY

BEGIN CATCH
	ROLLBACK;
END CATCH;
GO

-- 7.	������� �������� �������, ����������� �������������� �������� � ������, ���� ����������� ��� ������� (���������: ��� ������ ����� 
-- ������� ������ ��� MS SQL Server):
-- a.	����� ����������������� ���������� ��������;
-- b.	������� �������� �� ��������� ����������.
CREATE FUNCTION ThrownFromNestedAutocommit ()
RETURNS INT
AS
BEGIN
	IF (
			@@TRANCOUNT > 2
			AND @@OPTIONS & 2 = 2
			)
	BEGIN
		RETURN 1 / 0;
	END;

	RETURN @@TRANCOUNT;
END;
GO


