--This is a script to demonstrate linking aggregations of separate metrics using CTEs so it doesn't have to be crow-barred into one query or use intermediate temp tables or anything else. Get the 2 datasets in a CTE then join them and output the data

--I really like this syntax for demo scripts it makes the whole script easy to re-run without having to worry about current state of this script
DROP TABLE IF EXISTS #Group
DROP TABLE IF EXISTS #Candidate
DROP TABLE IF EXISTS #MetricOneData
DROP TABLE IF EXISTS #MetricTwoData

--Temporary tables can't have foreign keys so I haven't defined them for this demo - you likely would if these were real tables
--I like using temp tables for demos as you can run them on any demo DB without having to worry about leaving a mess behind or conflicting with real objects
CREATE TABLE #Group (ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, GroupName NVARCHAR(50))
CREATE TABLE #Candidate (ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, Group_ID INT NOT NULL, CandidateName NVARCHAR(100))
CREATE TABLE #MetricOneData (ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, Candidate_ID INT NOT NULL, Metric INT)
CREATE TABLE #MetricTwoData (ID INT NOT NULL IDENTITY(1,1) PRIMARY KEY, Candidate_ID INT NOT NULL, Metric INT)

INSERT INTO #Group (GroupName)
VALUES
(N'Foo fighters'),
(N'The Beatles'),
(N'Queen')

INSERT INTO #Candidate (Group_ID, CandidateName)
VALUES
(1, 'Dave Grohl'),
(2, 'Paul McCartney'),
(2, 'Ringo Starr'),
(2, 'John Lennon'),
(3, 'Freddie Mercury'),
(3, 'Brian May')

INSERT INTO #MetricOneData (Candidate_ID, Metric)
VALUES
(1, 1),
(1, 1000),
(2, -3),
(2, -3489),
(2, 47894),
(3, 1),
(3, 9866),
(4, 1),
(4, -48),
(5, 1),
(5, 543),
(6, 1),
(6, 487)

--To save making new metrics just flip table one values to the other side of the number line
INSERT INTO #MetricTwoData (Candidate_ID, Metric)
SELECT Candidate_ID, Metric * -1 FROM #MetricOneData

;WITH 
metricOneAgg AS (
	SELECT Group_ID, COUNT(*) AS [AggCount], SUM(m1.Metric) AS [SumMetric]
	FROM #Candidate c 
	JOIN #MetricOneData m1 ON c.ID = m1.Candidate_ID
	GROUP BY c.Group_ID),
metricTwoAgg AS (
	SELECT Group_ID, COUNT(*) AS [AggCount], SUM(m2.Metric) AS [SumMetric]
	FROM #Candidate c 
	JOIN #MetricTwoData m2 ON c.ID = m2.Candidate_ID
	GROUP BY c.Group_ID)

SELECT g.GroupName, m1Agg.AggCount AS [M1AggCount], m2Agg.AggCount AS [M2AggCount], m1Agg.SumMetric, m2Agg.SumMetric
FROM metricOneAgg m1Agg
JOIN metricTwoAgg m2Agg ON m2Agg.Group_ID = m1Agg.Group_ID
JOIN #Group g ON m1Agg.Group_ID = g.ID
ORDER BY g.GroupName