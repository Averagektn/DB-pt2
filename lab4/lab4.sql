

--7.	������� ���������� ��� ���� ������� ��������� ����� � ��������������� 1.
DELETE
FROM [subscriptions]
WHERE [sb_book] = 1;

--8. ������� ��� �����, ����������� � ����� ���������.
DELETE
FROM [books]
WHERE [b_id] IN (
		SELECT [b_id]
		FROM [m2m_books_genres]
		JOIN [genres] ON [m2m_books_genres].[g_id] = [genres].[g_id]
		WHERE [genres].[g_name] = '��������'
		);

--9.	������� ���������� ��� ���� ������� ����, ������������ ����� 20-�� ����� ������ ������ ������ ����.
DELETE
FROM [subscriptions]
WHERE DAY([sb_start]) > 20;

--10.	�������� � ���� ������ ����� ���������, ������������, ���������.
MERGE INTO [genres] AS target
USING (
	VALUES ('��������')
		,('����������')
		,('�������')
	) AS source([g_name])
	ON target.[g_name] = source.[g_name]
WHEN NOT MATCHED
	THEN
		INSERT ([g_name])
		VALUES (source.[g_name]);

--13.	�������� ��� ����� �������, ������� � ����� ����� � [+]�, ���� � ���������� ���� ����� ��� ���� ����� ������, ��� ������� � ����� ����� � [-]� � ��������� ������.
UPDATE [authors]
SET [a_name] = CASE 
		WHEN [a_id] IN (
				SELECT [a_id]
				FROM [m2m_books_authors]
				JOIN [books] ON [m2m_books_authors].[b_id] = [books].[b_id]
				GROUP BY [a_id]
				HAVING SUM([b_quantity]) > 3
				)
			THEN CONCAT (
					[a_name]
					,' [+]'
					)
		ELSE CONCAT (
				[a_name]
				,' [-]'
				)
		END;

