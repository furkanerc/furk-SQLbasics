





-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- SELECT Query ---------------------------------------------------
-------------------------------------------------------------------------------------------------------------------


-- * means ALL

USE my_database


SELECT * FROM ipi_Opportunities_Data -- 4,133

SELECT New_Account_No, Opportunity_ID FROM ipi_Opportunities_Data





--EXAMPLE 1 -- 1 conidition: =
SELECT * FROM ipi_Opportunities_Data WHERE Product_Category = 'Services' --1,269


--EXAMPLE 2 -- 2 conidition: AND
SELECT * FROM ipi_Opportunities_Data  WHERE	Product_Category = 'Services' AND Opportunity_Stage = 'Stage - 2' --205

--EXAMPLE 1 -- 2 conidition: LIKE
SELECT * FROM ipi_Opportunities_Data  WHERE Opportunity_ID LIKE '%QA%' --16




-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- WHERE CLAUSE with SubQueries -----------------------------------
-------------------------------------------------------------------------------------------------------------------


SELECT * FROM ipi_Opportunities_Data
SELECT * FROM ipi_account_lookup
SELECT * FROM ipi_Calendar_lookup


--EXAMPLE 1 - 1 condition from another table

SELECT * FROM ipi_Opportunities_Data WHERE New_Account_No IN (SELECT New_Account_No	FROM ipi_account_lookup WHERE Industry = 'Banking')  --174




------------------------------------------


SELECT * FROM ipi_Opportunities_Data
SELECT * FROM ipi_Calendar_lookup
SELECT * FROM ipi_account_lookup


--------------------------------------------------------------------
SELECT * FROM ipi_Opportunities_Data WHERE New_Account_No IN (SELECT New_Account_No FROM ipi_account_lookup WHERE Sector = 'Banking')
----------------------------------------------------------------------



SELECT * FROM ipi_Opportunities_Data WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM ipi_Calendar_lookup WHERE Fiscal_Year = 'FY20')



-- 2 condition

SELECT * FROM ipi_Opportunities_Data WHERE Est_Completion_Month_ID IN (SELECT DISTINCT Month_ID FROM ipi_Calendar_lookup WHERE Fiscal_Year = 'FY20') AND Product_Category = 'Services'





--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------


SELECT * FROM ipi_Opportunities_Data

--------------------------------------------------------------------------------------------------------
SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category,
Opportunity_Stage, Est_Opportunity_Value FROM ipi_Opportunities_Data

--EXAMPLE 1 : 1 IIF CONDITION - SAME COLUMN NAME

SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, IIF(Product_Category = 'Labour', 'Labourrr', Product_Category) AS Product_Category,
Opportunity_Stage, Est_Opportunity_Value FROM ipi_Opportunities_Data

--EXAMPLE 2 : MULTIPLE IIF STATEMENT WITH A NEW COLUMN

SELECT * FROM
    (
	SELECT *,
	IIF(New_Opportunity_Name LIKE '%Phase - 1%', 'Phase 1',
	IIF(New_Opportunity_Name LIKE '%Phase - 2%', 'Phase 2',
	IIF(New_Opportunity_Name LIKE '%Phase - 3%', 'Phase 3',
	IIF(New_Opportunity_Name LIKE '%Phase - 4%', 'Phase 4',
	IIF(New_Opportunity_Name LIKE '%Phase - 5%', 'Phase 5', 'Need Info')))))AS Phases
	FROM ipi_Opportunities_Data
	) a
	WHERE Phases = 'Need Info'


--EXAMPLE 1: CASE 
	--change labour to workforce--

SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, 
	CASE	
		WHEN Product_Category = 'Labour' THEN 'Workforce'
		ELSE Product_Category
		END AS Product_Category

,Opportunity_Stage, Est_Opportunity_Value FROM ipi_Opportunities_Data


SELECT *, 
	
	CASE	
		WHEN New_Opportunity_Name LIKE '%Phase - 1%' THEN 'Phase 1'
		WHEN New_Opportunity_Name LIKE '%Phase - 2%' THEN 'Phase 2'
		WHEN New_Opportunity_Name LIKE '%Phase - 3%' THEN 'Phase 3'
		WHEN New_Opportunity_Name LIKE '%Phase - 4%' THEN 'Phase 4'
		WHEN New_Opportunity_Name LIKE '%Phase - 5%' THEN 'Phase 5'
	ELSE 'Need Mapping' 
	END AS Opps_Phases	
	
	
	FROM ipi_Opportunities_Data

	




-------------------------------------------------------------------------------------------------------------------
---------------------------------------- UPDATE / REPLACE / INSERT INTO / DELETE-----------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM ipi_account_lookup

--EXAMPLE 1: RENAMING A COLUMN

SELECT *, 

	
	IIF(Sector = 'Capital Markets/Securities', 'Capital Market', Sector) AS Sector2

FROM ipi_account_lookup




SELECT*,

CASE
	WHEN Sector = 'Capital Markets/Securities' THEN 'Capital Market'
	ELSE Sector
	END AS Sector2

	FROM ipi_account_lookup

UPDATE ipi_account_lookup

SET Sector = IIF(Sector = 'Capital Markets/Securities', 'Capital Market', Sector) 

SELECT *, 
REPLACE (Account_Segment, 'PS' , 'Public Sector') AS Account_Segment2
FROM ipi_account_lookup


UPDATE ipi_account_lookup
SET Account_Segment = REPLACE (Account_Segment, 'PS' , 'Public Sector') 


--INSERT INTO--


'123412452', 'New_Account_Name', 'Banking', 'Banking', NULL, NULL, NULL, 'FURKAN'

INSERT INTO ipi_account_lookup
SELECT '123412452', 'New Account Name', 'Banking', 'Banking', NULL, NULL, NULL, 'Furkan'




SELECT * FROM ipi_account_lookup WHERE Industry = 'Banking' AND Sector = 'Banking'


INSERT INTO ipi_account_lookup
SELECT '12412431', 'New Account Name', 'Test Industry', NULL, NULL, NULL, NULL, 'Selim'

SELECT * FROM ipi_account_lookup WHERE Industry_Manager = 'Furkan'

--DELETING DATA--
DELETE FROM ipi_account_lookup WHERE Industry_Manager = 'Furkan'



-------------------------------------------------------------------------------------------------------------------
-------------------------------------------------- Main Aggregate Functions in SQL---------------------------------
-------------------------------------------------------------------------------------------------------------------

SELECT * FROM ipi_Opportunities_Data


----SUM----

SELECT Product_Category, SUM(Est_Opportunity_Value) AS SUM_Est_Opportunity_Value FROM ipi_Opportunities_Data
WHERE Opportunity_Stage = 'Stage - 2'
GROUP BY Product_Category


CREATE TABLE furkan






-------------------------------------------------------------------------------------------------------------------
---------------------------------------- LEFT/FULL/CROSS join Statements in SQL------------------------------------
-------------------------------------------------------------------------------------------------------------------


SELECT * FROM ipi_Opportunities_Data
SELECT * FROM ipi_account_lookup 

-- Exm 1: LEFT JOIN

-- 1. We need to SELECT the columns we need from the 2 or more tables we are going to JOIN
-- 2. Need to identify the column(s) that are identical in each table so we can JOIN them
-- 3. Need to specify on top which columns we need from each table




--------------------------

SELECT a.*, b.New_Account_Name, b.Industry
FROM
	(
	SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value
	FROM ipi_Opportunities_Data
	) a -- 4,133

	LEFT JOIN
	(
	SELECT New_Account_No, New_Account_Name, Industry FROM ipi_account_lookup
	) b -- 1,145
	ON a.New_Account_No = b.New_Account_No

	-- 4,133


SELECT DISTINCT New_Account_No FROM ipi_Opportunities_Data --1,139
SELECT DISTINCT New_Account_No FROM ipi_account_lookup -- 1,445


--6 satýr yada account left join ile diger tabloya gecmedi cünkü 6 account fazlasý var ipi_account_lookup tablosunun.
-- 6 satýrý bulmak icin NOT IN komutunu kullan!!

SELECT * FROM ipi_account_lookup WHERE New_Account_No NOT IN(SELECT DISTINCT New_Account_No FROM ipi_Opportunities_Data)
--DELETE ROW
DELETE FROM ipi_account_lookup WHERE Industry_Manager = 'Yiannis' 


-- left join kýsa yol--

(SELECT * FROM ipi_Opportunities_Data) 
(SELECT * FROM ipi_account_lookup) 


(SELECT * FROM ipi_Opportunities_Data) a
(SELECT * FROM ipi_account_lookup) b

	SELECT a.*, b.New_Account_Name, b.Industry FROM ipi_Opportunities_Data a
LEFT JOIN ipi_account_lookup b
ON a.New_Account_No = b.New_Account_No






SELECT  ISNULL(a.New_Account_No, b.New_Account_No) AS New_Account_No,
		ISNULL(a.Opportunity_ID, 'NO INFO') AS Opportunity_ID,
 a.New_Opportunity_Name, a.Est_Completion_Month_ID, a.Product_Category, a.Opportunity_Stage, a.Est_Opportunity_Value,
 b.New_Account_Name, b.Industry


FROM
	(
	SELECT * --New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value
    FROM ipi_Opportunities_Data
	) a -- 4,133

	FULL JOIN
	(
	SELECT New_Account_No, New_Account_Name, Industry FROM ipi_account_lookup
	) b -- 1,145
	ON a.New_Account_No = b.New_Account_No
	
	
	
	
	------------------------------------------------------
SELECT --ISNULL(a.New_Account_No, b.New_Account_No) AS New_Account_No,
	   --ISNULL(a.Opportunity_ID, 'No opportunities') AS Opportunity_ID,
a.New_Opportunity_Name, a.Est_Completion_Month_ID, a.Product_Category, a.Opportunity_Stage, a.Est_Opportunity_Value ,
b.New_Account_Name, b.Industry
FROM
	(
	SELECT New_Account_No, Opportunity_ID, New_Opportunity_Name, Est_Completion_Month_ID, Product_Category, Opportunity_Stage, Est_Opportunity_Value FROM ipi_Opportunities_Data
	) a -- 4,133

	FULL JOIN
	(
	SELECT New_Account_No, New_Account_Name, Industry FROM ipi_account_lookup
	) b -- 1,145
	ON a.New_Account_No = b.New_Account_No






