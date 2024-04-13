-- 1.	������� �������������, ����������� �������� ������ ��������� � ����������� ����������� � ������� �������� �� ����� ����, 
-- �� ������������ ������ ����� ���������, �� ������� ������� �������������, �.�. �� ����� � �������� ���� ���� �� ���� �����, 
-- ������� �� ������ ��� ������� �� ����������� ������� ����.
CREATE VIEW [debtors]
AS
SELECT [sb_subscriber] AS [deb_subscriber]
	,COUNT([sb_subscriber]) AS [deb_books_count]
FROM [subscriptions]
WHERE [sb_finish] < GETDATE()
	AND [sb_is_active] = 'Y'
GROUP BY [sb_subscriber]
GO

-- 5. ������� �������������, ������������ ��� ���������� �� ������� subscriptions, ���������� ���� �� ����� sb_start � sb_finish 
-- � ������ �����-��-�� �ͻ, ��� ��ͻ � ���� ������ � ���� ������ ������� �������� (�.�. ������������, �������� � �.�.)
CREATE VIEW [humanized_subscriptions]
AS
SELECT [sb_id] AS [hs_id]
	,[sb_subscriber] AS [hs_subscriber]
	,[sb_book] AS [hs_book]
	,CONVERT(VARCHAR(16), [sb_start], 120) + ' ' + CASE 
		WHEN DATEPART(WEEKDAY, [sb_start]) = 1
			THEN '�����������'
		WHEN DATEPART(WEEKDAY, [sb_start]) = 2
			THEN '�����������'
		WHEN DATEPART(WEEKDAY, [sb_start]) = 3
			THEN '�������'
		WHEN DATEPART(WEEKDAY, [sb_start]) = 4
			THEN '�����'
		WHEN DATEPART(WEEKDAY, [sb_start]) = 5
			THEN '�������'
		WHEN DATEPART(WEEKDAY, [sb_start]) = 6
			THEN '�������'
		WHEN DATEPART(WEEKDAY, [sb_start]) = 7
			THEN '�������'
		ELSE ''
		END AS [hs_start]
	,CONVERT(VARCHAR(16), [sb_finish], 120) + ' ' + CASE 
		WHEN DATEPART(WEEKDAY, [sb_finish]) = 1
			THEN '�����������'
		WHEN DATEPART(WEEKDAY, [sb_finish]) = 2
			THEN '�����������'
		WHEN DATEPART(WEEKDAY, [sb_finish]) = 3
			THEN '�������'
		WHEN DATEPART(WEEKDAY, [sb_finish]) = 4
			THEN '�����'
		WHEN DATEPART(WEEKDAY, [sb_finish]) = 5
			THEN '�������'
		WHEN DATEPART(WEEKDAY, [sb_finish]) = 6
			THEN '�������'
		WHEN DATEPART(WEEKDAY, [sb_finish]) = 7
			THEN '�������'
		ELSE ''
		END AS [hs_finish]
	,[sb_is_active] AS [hs_is_active]
FROM [subscriptions]
GO

-- 14. ������� �������, �� ����������� ������ ����� ��������, � �������� �� ����� ��������� ���� � ����� ����, ��� �������, ��� ��������� 
-- �����, ���������� �� �������� ���� �������� ��� ����, ���������� ����� ������ ������.
CREATE TRIGGER [check_subscriber_books_count_and_return_date] ON [subscriptions]
AFTER INSERT
AS
BEGIN
	DECLARE @SubscriberId INT
		,@TotalReturnDate DATETIME

	SELECT @SubscriberId = [sb_subscriber]
	FROM INSERTED

	SELECT @TotalReturnDate = SUM(DATEDIFF(DAY, [sb_start], [sb_finish]))
	FROM subscriptions
	WHERE sb_subscriber = @SubscriberId
		AND sb_is_active = 'Y'

	IF (
			(
				SELECT COUNT([sb_id])
				FROM subscriptions
				WHERE [sb_subscriber] = @SubscriberId
					AND sb_is_active = 'Y'
				) >= 5
			AND @TotalReturnDate < 30
			)
	BEGIN
		RAISERROR (
				'It is not possible to give a book to a reader because he or she has five or more books in his or her possession, provided that the cumulative time remaining until the return of all books issued to him or her is less than one month.'
				,16
				,1
				)

		ROLLBACK TRANSACTION
	END
END
GO

-- 15. ������� �������, ����������� ����������� � ���������� ������ ����� �������, ��� ������� �� �������� ������� �������� ����� ����, 
-- ����, ������ - (�����), ' (��������) � �������� (�� ����������� ��� � ����� ������ ������ �������).
CREATE TRIGGER [check_author_name] ON [authors]
FOR INSERT
	,UPDATE
AS
BEGIN
	IF EXISTS (
			SELECT [a_id]
			FROM INSERTED
			WHERE [a_name] NOT LIKE '%[^a-zA-Z0-9'' -]%'
				OR [a_name] LIKE '%  %'
			)
	BEGIN
		RAISERROR (
				'Invalid author name. Author names should only contain letters, digits, hyphens, apostrophes, and spaces, with no two consecutive spaces.'
				,16
				,1
				)

		ROLLBACK TRANSACTION
	END
END
GO

-- 17. ������� �������, �������� ���� ������ ����� �� �������, ���� ��������� � INSERT- ��� UPDATE-������� ���� ������ ����� ������ 
-- ������� �� ������� � �����.
CREATE TRIGGER [update_issue_date] ON [subscriptions]
AFTER INSERT
	,UPDATE
AS
BEGIN
	IF EXISTS (
			SELECT [sb_id]
			FROM INSERTED
			WHERE DATEDIFF(MONTH, [sb_start], GETDATE()) >= 6
			)
	BEGIN
		UPDATE [subscriptions]
		SET [sb_start] = GETDATE()
		WHERE [sb_id] IN (
				SELECT [sb_id]
				FROM INSERTED
				WHERE DATEDIFF(MONTH, [sb_start], GETDATE()) >= 6
				)
	END
END;
