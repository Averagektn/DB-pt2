--16.	ѕоказать всех читателей, не вернувших книги, и количество невозвращЄнных книг по каждому такому читателю.
SELECT [s_id]
	,[s_name]
	,COUNT([sb_id])
FROM [subscribers]
JOIN [subscriptions] ON [s_id] = [sb_subscriber]
WHERE [sb_is_active] = 'Y'
GROUP BY [s_id]
	,[s_name];

--17.	ѕоказать читаемость жанров, т.е. все жанры и то количество раз, которое книги этих жанров были вз€ты читател€ми.
SELECT [genres].[g_id]
	,[g_name]
	,COUNT([sb_book]) AS [amount]
FROM [genres]
LEFT JOIN [m2m_books_genres] ON [genres].[g_id] = [m2m_books_genres].[g_id]
LEFT JOIN [books] ON [books].[b_id] = [m2m_books_genres].b_id
LEFT JOIN [subscriptions] ON [books].[b_id] = [sb_book]
GROUP BY [g_name]
	,[genres].[g_id];

--19.	ѕоказать среднюю читаемость жанров, т.е. среднее значение от того, сколько раз читатели брали книги каждого жанра.
SELECT AVG(CAST([amount] AS FLOAT))
FROM (
	SELECT COUNT([sb_book]) AS [amount]
	FROM [genres]
	LEFT JOIN [m2m_books_genres] ON [genres].[g_id] = [m2m_books_genres].[g_id]
	LEFT JOIN [books] ON [books].[b_id] = [m2m_books_genres].b_id
	LEFT JOIN [subscriptions] ON [books].[b_id] = [sb_book]
	GROUP BY [genres].[g_id]
	) AS [data];

--20.	ѕоказать медиану читаемости жанров, т.е. медианное значение от того, сколько раз читатели брали книги каждого жанра.
SELECT DISTINCT PERCENTILE_CONT(0.5) WITHIN
GROUP (
		ORDER BY [amount]
		) OVER () AS [Median]
FROM (
	SELECT COUNT([sb_book]) AS [amount]
	FROM [genres]
	LEFT JOIN [m2m_books_genres] ON [genres].[g_id] = [m2m_books_genres].[g_id]
	LEFT JOIN [books] ON [books].[b_id] = [m2m_books_genres].b_id
	LEFT JOIN [subscriptions] ON [books].[b_id] = [sb_book]
	GROUP BY [genres].[g_id]
	) AS [data];

--23.	ѕоказать читател€, последним вз€вшего в библиотеке книгу.
SELECT TOP 1 [s_name]
	,[sb_subscriber]
	,[sb_start]
FROM [subscribers]
JOIN [subscriptions] ON [s_id] = [sb_subscriber]
ORDER BY [sb_start] DESC;