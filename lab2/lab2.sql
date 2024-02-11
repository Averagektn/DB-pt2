-- 1.	�������� ��� ���������� �� �������.
SELECT *
FROM [authors]

-- 2.	�������� ��� ���������� � ������.
SELECT *
FROM [genres]

-- 7.	��������, ������� ��������� ����� ����� � ����������.
SELECT COUNT(DISTINCT [sb_subscriber])
FROM [subscriptions];

-- 12.	�������� ������������� ������ (������) ��������, �������� � ���������� ������ ����� ����.
SELECT TOP 1 [sb_subscriber]
	,COUNT([sb_id]) AS [total]
FROM [subscriptions]
GROUP BY [sb_subscriber]
ORDER BY [total] DESC;

-- 17.	��������, ������� ���� ���� ���������� � �� ���������� � ���������� (���� ������ ����������� ��������� ���������� ���� sb_is_active (�.�. �Y� � �N�), � ����� �������� �������� �Y� � �N� ������ ���� ������������� � �Returned� � �Not returned�).
SELECT COUNT(CASE 
			WHEN [sb_is_active] = 'Y'
				THEN 1
			END) AS 'Not returned'
	,COUNT(CASE 
			WHEN [sb_is_active] = 'N'
				THEN 1
			END) AS 'Returned'
FROM [subscriptions]

-- 17.	��������, ������� ���� ���� ���������� � �� ���������� � ���������� (���� ������ ����������� ��������� ���������� ���� sb_is_active (�.�. �Y� � �N�), � ����� �������� �������� �Y� � �N� ������ ���� ������������� � �Returned� � �Not returned�).
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