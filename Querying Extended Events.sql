SELECT
  xed.value('@timestamp', 'datetime') as Creation_Date,
  xed.query('.') AS Extend_Event
FROM
(
  SELECT CAST([target_data] AS XML) AS Target_Data
  FROM sys.dm_xe_session_targets AS xt
  INNER JOIN sys.dm_xe_sessions AS xs
  ON xs.address = xt.event_session_address
  WHERE xs.name = N'Deadlock tracing'
  AND xt.target_name = N'ring_buffer'
) AS XML_Data
CROSS APPLY Target_Data.nodes('RingBufferTarget/event[@name="xml_deadlock_report"]') AS XEventData(xed)
ORDER BY Creation_Date DESC


--Job 'Automated Group Work' : Step 1, 'Run grouping based off Cust_Key' : Began Executing 2016-01-11 12:20:24
--'Multiple Manual Groups In Set', 'Group Note present', 'vCode Level 3 not matching'

--Controller no lock change looks to have worked after 40 minutes of running.
--There were logged deadlocks against trans_periodic updates but these do not show up in either the controller log file or the group work one. I think it would be best if the periodic running pieces of the work were wrapped in an update so the normal controller will not try and run those pieces of work.