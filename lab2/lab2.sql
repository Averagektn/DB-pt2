-- 11.	�������� �������������� � ���� ������ ���� �� ������ ��� ������ ���������� (������ ����� ������ ���������� ������� ��� ���� � ������ ������ ����� �� 31-� ������� (������������) ���� ����, ����� ���������� ������ ��������).
SELECT [sb_book]
	,[sb_start]
FROM [subscriptions]
WHERE YEAR([sb_start]) = (
		SELECT YEAR(MIN([sb_start]))
		FROM [subscriptions]
		);

-- 12.	�������� ������������� ������ (������) ��������, �������� � ���������� ������ ����� ����.
SELECT TOP 1 [sb_subscriber]
	,COUNT([sb_id]) AS [total]
FROM [subscriptions]
GROUP BY [sb_subscriber]
ORDER BY [total] DESC;

-- 15.	��������, ������� � ������� ����������� ���� ���� � ����������.
SELECT ROUND(AVG(CONVERT(FLOAT, [b_quantity])), 1) AS [average_books]
FROM [books];

-- 16.	�������� � ����, ������� � ������� ������� �������� ��� ���������������� � ���������� (�������� ����������� ������� �������� �� ������ ���� ��������� ��������� ����� �� ������� ����).
SELECT ROUND(AVG(CONVERT(FLOAT, DATEDIFF(day, [sb_start], GETDATE()))), 1) AS [avg_registration]
FROM [subscriptions];

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