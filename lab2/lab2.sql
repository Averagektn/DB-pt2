-- 1.	Показать всю информацию об авторах.
SELECT *
FROM [authors]

-- 2.	Показать всю информацию о жанрах.
SELECT *
FROM [genres]

-- 7.	Показать, сколько читателей брало книги в библиотеке.
SELECT COUNT(DISTINCT [sb_subscriber])
FROM [subscriptions];

-- 12.	Показать идентификатор одного (любого) читателя, взявшего в библиотеке больше всего книг.
SELECT TOP 1 [sb_subscriber]
	,COUNT([sb_id]) AS [total]
FROM [subscriptions]
GROUP BY [sb_subscriber]
ORDER BY [total] DESC;

-- 17.	Показать, сколько книг было возвращено и не возвращено в библиотеку (СУБД должна оперировать исходными значениями поля sb_is_active (т.е. «Y» и «N»), а после подсчёта значения «Y» и «N» должны быть преобразованы в «Returned» и «Not returned»).
SELECT COUNT(CASE 
			WHEN [sb_is_active] = 'Y'
				THEN 1
			END) AS 'Not returned'
	,COUNT(CASE 
			WHEN [sb_is_active] = 'N'
				THEN 1
			END) AS 'Returned'
FROM [subscriptions]

-- 17.	Показать, сколько книг было возвращено и не возвращено в библиотеку (СУБД должна оперировать исходными значениями поля sb_is_active (т.е. «Y» и «N»), а после подсчёта значения «Y» и «N» должны быть преобразованы в «Returned» и «Not returned»).
SELECT (
		CASE 
			WHEN [sb_is_active] = 'Y'
				THEN 'Not returned'
			ELSE 'Returned'
			END
		) AS [status]
	,COUNT([sb_id]) AS [books]
FROM [subscriptions]
GROUP BY (
		CASE 
			WHEN [sb_is_active] = 'Y'
				THEN 'Not returned'
			ELSE 'Returned'
			END
		)
ORDER BY [status] DESC