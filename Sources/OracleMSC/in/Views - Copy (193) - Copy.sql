--Comments to be preserved
CREATE OR REPLACE FORCE EDITIONABLE VIEW TestView(TestViewParamenter1, TestViewParamenter2) AS
SELECT expression1, expression2 
   FROM atable;

--Comments to be preserved
CREATE OR REPLACE FORCE EDITIONABLE VIEW "TestView2" ("TestViewParamenter1", "TestViewParamenter2", "TestViewParamenter3", "TestViewParamenter4") AS
SELECT expression1, expression2, expression3, expression4
   FROM atable;


CREATE OR REPLACE FORCE EDITIONABLE VIEW VIEW1
AS
SELECT
*
FROM TABLE1;

-- ALGO should be used on TABLE1 Like ALGO.TABLE1
CREATE OR REPLACE FORCE EDITIONABLE VIEW ALGO.VIEW2
AS
SELECT
*
FROM TABLE1;

-- It should remove quotes from the Schemas used in the From Elements.
CREATE OR REPLACE FORCE NONEDITIONABLE VIEW "APEX_040200"."WWV_FLOW_MONTHS_MON" ("MONTH_DISPLAY", "MONTH_VALUE") AS
select "MONTH_DISPLAY","MONTH_VALUE" from wwv_flow_months_mon_temp where month_value < 13;


-- Testing Select transformation Oracle allows any order between hierarchical_query_clause, order by and having.
-- hierarchical_query_clause then having then order by
CREATE OR REPLACE FORCE NONEDITIONABLE VIEW VIEW01 AS
SELECT UNIQUE A.* FROM TABLITA A WHERE A.X = A.C CONNECT BY NOCYCLE A.C = 0 START WITH A.B = 1 HAVING X = 1 GROUP BY A.C;


-- hierarchical_query_clause then order by then having
CREATE OR REPLACE FORCE NONEDITIONABLE VIEW VIEW02 AS
SELECT UNIQUE A.* FROM TABLITA A WHERE A.X = A.C START WITH A.B = 1 CONNECT BY NOCYCLE A.C = 0 GROUP BY A.C HAVING X = 1;

-- having then hierarchival_query_clause then group by
CREATE OR REPLACE FORCE NONEDITIONABLE VIEW VIEW03 AS
SELECT UNIQUE A.* FROM TABLITA A WHERE A.X = A.C HAVING X = 1 GROUP BY A.C CONNECT BY NOCYCLE A.C = 0 START WITH A.B = 1;

-- table schema should not be replaced by the view schema
CREATE OR REPLACE FORCE EDITIONABLE VIEW "SCHEMA01"."VIEW04" AS
SELECT "SALARY" FROM SCHEMA02.TABLE01;

-- create view with identifiers with special characters 
CREATE OR REPLACE FORCE EDITIONABLE VIEW VIEW1("username#", lastname, "$alary") AS
SELECT s.username#, s.lastname, s.$alary, s.attr# hint# FROM TABLE1 s;