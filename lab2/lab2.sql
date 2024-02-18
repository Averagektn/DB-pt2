-- 11.	Показать идентификаторы и даты выдачи книг за первый год работы библиотеки (первым годом работы библиотеки считать все даты с первой выдачи книги по 31-е декабря (включительно) того года, когда библиотека начала работать).
SELECT [sb_book]
	,[sb_start]
FROM [subscriptions]
WHERE YEAR([sb_start]) = (
		SELECT YEAR(MIN([sb_start]))
		FROM [subscriptions]
		);

-- 12.	Показать идентификатор одного (любого) читателя, взявшего в библиотеке больше всего книг.
SELECT TOP 1 [sb_subscriber]
	,COUNT([sb_id]) AS [total]
FROM [subscriptions]
GROUP BY [sb_subscriber]
ORDER BY [total] DESC;

-- 15.	Показать, сколько в среднем экземпляров книг есть в библиотеке.
SELECT ROUND(AVG(CONVERT(FLOAT, [b_quantity])), 1) AS [average_books]
FROM [books];

-- 16.	Показать в днях, сколько в среднем времени читатели уже зарегистрированы в библиотеке (временем регистрации считать диапазон от первой даты получения читателем книги до текущей даты).
SELECT ROUND(AVG(CONVERT(FLOAT, DATEDIFF(day, [sb_start], GETDATE()))), 1) AS [avg_registration]
FROM [subscriptions];

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