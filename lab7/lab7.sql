

-- 1.	Создать хранимую процедуру, которая:
-- a.	добавляет каждой книге два случайных жанра;
-- b.	отменяет совершённые действия, если в процессе работы хотя бы одна операция вставки завершилась ошибкой в силу дублирования 
-- значения первичного ключа таблицы «m2m_books_genres» (т.е. у такой книги уже был такой жанр).
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

-- 2.	Создать хранимую процедуру, которая:
-- a.	увеличивает значение поля «b_quantity» для всех книг в два раза;
-- b.	отменяет совершённое действие, если по итогу выполнения операции среднее количество экземпляров книг превысит значение 50.
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

-- 3.	Написать запросы, которые, будучи выполненными параллельно, обеспечивали бы следующий эффект:
-- a.	первый запрос должен считать количество выданных на руки и возвращённых в библиотеку книг и не зависеть от запросов на обновление 
-- таблицы «subscriptions» (не ждать их завершения);
SET IMPLICIT_TRANSACTIONS ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

BEGIN TRANSACTION;

SELECT COUNT([s].[sb_id]) AS [issued_books_count]
FROM [subscriptions] [s]
WHERE [s].[sb_is_active] = 'Y';

COMMIT;

-- b.	второй запрос должен инвертировать значения поля «sb_is_active» таблицы subscriptions с «Y» на «N» и наоборот и не зависеть от 
-- первого запроса (не ждать его завершения).
SET IMPLICIT_TRANSACTIONS ON;

BEGIN TRANSACTION;

UPDATE [subscriptions]
SET [sb_is_active] = CASE 
		WHEN [sb_is_active] = 'Y'
			THEN 'N'
		ELSE 'Y'
		END;

COMMIT;

-- 5.	Написать код, в котором запрос, инвертирующий значения поля «sb_is_active» таблицы «subscriptions» с «Y» на «N» и наоборот, 
-- будет иметь максимальные шансы на успешное завершение в случае возникновения ситуации взаимной блокировки с другими транзакциями.
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

-- 7.	Создать хранимую функцию, порождающую исключительную ситуацию в случае, если выполняются оба условия (подсказка: эта задача имеет 
-- решение только для MS SQL Server):
-- a.	режим автоподтверждения транзакций выключен;
-- b.	функция запущена из вложенной транзакции.
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


