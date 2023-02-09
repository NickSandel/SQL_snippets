DECLARE 
@OverallTime TIME(0) = '02:51:00',
@WorkDone FLOAT = 2151,
@Total_Seconds FLOAT

SELECT @Total_Seconds = 
	DATEDIFF(second,0,cast(@OverallTime as datetime))

SELECT @Total_Seconds/@WorkDone AS [Average_Processing_Time_In_Seconds]