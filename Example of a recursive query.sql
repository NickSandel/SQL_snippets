CREATE TABLE #GroupTest (ID INT NOT NULL IDENTITY(1,1), Value1 INT, Value2 INT, Text VARCHAR(10));

INSERT INTO #GroupTest (Value1, Value2, Text) VALUES
(487185, 451122, 'Link'),
(451122, 41429, 'Linked'),
(487185, 409484, 'Itself'),
(41429, 1234, 'Younger');

WITH links AS (
	SELECT Value2, MAX(Value1) [Value]
	FROM #GroupTest g
	GROUP BY Value2
	UNION ALL
	SELECT g.Value2, l.Value [Value]
	FROM #GroupTest g
	JOIN links l ON g.Value1 = l.Value2
)
SELECT Value2, MAX(Value)
FROM links
GROUP BY Value2