/*** MSC-WARNING - MSCEWI1050 - MISSING DEPENDENT OBJECT "atable" ***/
--Comments to be preserved
CREATE OR REPLACE VIEW PUBLIC.TestView (TestViewParamenter1, TestViewParamenter2)
AS
SELECT expression1, expression2
   FROM PUBLIC.atable;

/*** MSC-WARNING - MSCEWI1050 - MISSING DEPENDENT OBJECT "atable" ***/

--Comments to be preserved
CREATE OR REPLACE VIEW PUBLIC.TestView2 (TestViewParamenter1, TestViewParamenter2, TestViewParamenter3, TestViewParamenter4)
AS
SELECT expression1, expression2, expression3, expression4
   FROM PUBLIC.atable;

CREATE OR REPLACE VIEW PUBLIC.VIEW1
AS
SELECT
*
FROM PUBLIC.TABLE1;

-- ALGO should be used on TABLE1 Like ALGO.TABLE1
CREATE OR REPLACE VIEW ALGO.VIEW2
AS
SELECT
*
FROM ALGO.TABLE1;

/*** MSC-WARNING - MSCEWI1050 - MISSING DEPENDENT OBJECT "wwv_flow_months_mon_temp" ***/

-- It should remove quotes from the Schemas used in the From Elements.
CREATE OR REPLACE VIEW APEX_040200.WWV_FLOW_MONTHS_MON (MONTH_DISPLAY, MONTH_VALUE)
AS
select
MONTH_DISPLAY,
MONTH_VALUE
from APEX_040200.wwv_flow_months_mon_temp
where month_value < 13;


-- Testing Select transformation Oracle allows any order between hierarchical_query_clause, order by and having.
-- hierarchical_query_clause then having then order by
CREATE OR REPLACE VIEW PUBLIC.VIEW01
AS
SELECT DISTINCT
A.*
FROM PUBLIC.TABLITA A
WHERE A.X = A.C
GROUP BY A.C
HAVING X = 1
/*** MSC-ERROR - MSCEWI3065 - NOCYCLE property in a hierarchical clause is not supported in Snowflake ***/
CONNECT BY A.C = 0 START WITH A.B = 1;


-- hierarchical_query_clause then order by then having
CREATE OR REPLACE VIEW PUBLIC.VIEW02
AS
SELECT DISTINCT
A.*
FROM PUBLIC.TABLITA A
WHERE A.X = A.C
GROUP BY A.C
HAVING X = 1
START WITH A.B = 1 /*** MSC-ERROR - MSCEWI3065 - NOCYCLE property in a hierarchical clause is not supported in Snowflake ***/
 CONNECT BY A.C = 0;

-- having then hierarchival_query_clause then group by
CREATE OR REPLACE VIEW PUBLIC.VIEW03
AS
SELECT DISTINCT
A.*
FROM PUBLIC.TABLITA A
WHERE A.X = A.C
GROUP BY A.C
HAVING X = 1
/*** MSC-ERROR - MSCEWI3065 - NOCYCLE property in a hierarchical clause is not supported in Snowflake ***/
CONNECT BY A.C = 0 START WITH A.B = 1;

/*** MSC-WARNING - MSCEWI1050 - MISSING DEPENDENT OBJECT "SCHEMA02.TABLE01" ***/

-- table schema should not be replaced by the view schema
CREATE OR REPLACE VIEW SCHEMA01.VIEW04
AS
SELECT
SALARY
FROM SCHEMA02.TABLE01;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR VIEW1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- create view with identifiers with special characters 
CREATE OR REPLACE VIEW PUBLIC.VIEW1 ("username#", lastname, "$alary")
AS
SELECT s."USERNAME#", s.lastname, s."$ALARY", s."ATTR#" "HINT#" FROM PUBLIC.TABLE1 s;