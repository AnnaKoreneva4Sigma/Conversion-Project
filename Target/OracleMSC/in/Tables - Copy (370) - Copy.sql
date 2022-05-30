CREATE OR REPLACE TABLE MOBILIZESCHEMA.TABLE1 (
COL12 TIMESTAMP(5) DEFAULT CURRENT_TIMESTAMP :: TIMESTAMP(5) /*** MSC-WARNING - MSCEWI3006 - YOU MAY NEED TO SET TIMESTAMP OUTPUT FORMAT ('DD-MON-YY HH24.MI.SS.FF AM TZH:TZM') ***/,
UPDT_USER_ID VARCHAR(50) NOT NULL /*** MSC-WARNING - MSCEWI3041 - ENABLE/DISABLE CONSTRAINT STATE REMOVED FROM NOT NULL INLINE CONSTRAINT ***/,
/*** MSC-WARNING - MSCEWI1035 - CHECK STATEMENT NOT SUPPORTED ***/
/*	 CHECK (HIG_CODE_MAPPING_BP_PK_ID IS NOT NULL)*/
/*** MSC-WARNING - MSCEWI1035 - CHECK STATEMENT NOT SUPPORTED ***/
/*	 CHECK (REF_CD_TYP_NM IS NOT NULL)*/
/*** MSC-WARNING - MSCEWI1035 - CHECK STATEMENT NOT SUPPORTED ***/
/*	 CHECK (ECOS_REF_CD_BODY_PART IS NOT NULL)*/
PRIMARY KEY (HIG_CODE_MAPPING_BP_PK_ID) /*** MSC-WARNING - MSCEWI3037 - USING INDEX CONSTRAINT STATE REMOVED FROM THE CONSTRAINT ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR MobilizeSchema.BaseTable. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE MobilizeSchema.BaseTable (BaseId NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT 10 NOT NULL /*** MSC-WARNING - MSCEWI3041 - ENABLE/DISABLE CONSTRAINT STATE REMOVED FROM NOT NULL INLINE CONSTRAINT ***/,
COL1 CHAR(1),
COL2 VARCHAR(512) DEFAULT 'A Description' NOT NULL /*** MSC-WARNING - MSCEWI3041 - ENABLE/DISABLE CONSTRAINT STATE REMOVED FROM NOT NULL INLINE CONSTRAINT ***/,
COL3 VARCHAR(10),
COL4 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ NOT NULL /*** MSC-WARNING - MSCEWI3041 - ENABLE/DISABLE CONSTRAINT STATE REMOVED FROM NOT NULL INLINE CONSTRAINT ***/,
COL5 BINARY /*** MSC-WARNING - MSCEWI1036 - RAW DATA TYPE "" CONVERTED TO BINARY ***/,
COL6 DATE,
COL7 VARCHAR /*** MSC-WARNING - MSCEWI1036 - CLOB DATA TYPE "" CONVERTED TO VARCHAR ***/,
COL8 VARCHAR(18) /*** MSC-WARNING - MSCEWI1036 - ROWID DATA TYPE "" CONVERTED TO VARCHAR(18) ***/,
/*** MSC-WARNING - MSCEWI1045 - COLUMN NAME FROM IS A SNOWFLAKE RESERVED KEYWORD ***/
"from" NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
COL9 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
COL10 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
COL11 NUMBER (3) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
COL12 NUMBER (38, 1) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
--COL13 NUMBER(10,-2),
COL14 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ NOT NULL,
COL15 VARCHAR
-- ** MSC-WARNING - MSCEWI1024 - THE FOLLOWING CHECK CONSTRAINT WAS COMMENTED OUT **
--              CHECK(COL15 = '13')
                                 ,
/*** MSC-WARNING - MSCEWI1035 - CHECK STATEMENT NOT SUPPORTED ***/
/*    CHECK (COL14 IS NOT NULL)*/
COL16 VARCHAR /*** MSC-WARNING - MSCEWI1036 - LONG DATA TYPE "" CONVERTED TO VARCHAR ***/,
CONSTRAINT Constraint1BaseTable PRIMARY KEY (BaseId) /*** MSC-WARNING - MSCEWI3037 - USING INDEX CONSTRAINT STATE REMOVED FROM THE CONSTRAINT ***/);

CREATE OR REPLACE SEQUENCE MySchema.SampleTable_JOB_REFERENCE_ID
INCREMENT BY 1
START WITH 621
COMMENT = 'FOR TABLE-COLUMN MySchema.SampleTable.JOB_REFERENCE_ID';

CREATE OR REPLACE TABLE MySchema.SampleTable (
JOB_REFERENCE_ID NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT MySchema.SampleTable_JOB_REFERENCE_ID.NEXTVAL /*** MSC-WARNING - MSCEWI1048 - SEQUENCE -  GENERATED BY DEFAULT  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 621 CACHE 20 NOORDER NOCYCLE ***/  NOT NULL /*** MSC-WARNING - MSCEWI3041 - ENABLE/DISABLE CONSTRAINT STATE REMOVED FROM NOT NULL INLINE CONSTRAINT ***/
);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR ENABLESTATETABLE. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.ENABLESTATETABLE (
COLUMN1 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ NOT NULL ,
CONSTRAINT PK_COLUMN1 PRIMARY KEY (COLUMN1));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLITA. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- SYSDATE Transformation
CREATE OR REPLACE TABLE PUBLIC.TABLITA /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 (AUDT_INS_DT DATE DEFAULT trunc(CURRENT_DATE, 'DAY'),
AUDT_UPD_DT DATE DEFAULT trunc(CURRENT_DATE, 'DAY'));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLITA2. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Invalid Indentifiers must preserve ""
CREATE OR REPLACE TABLE PUBLIC.TABLITA2 (SHIP_ID VARCHAR(30),
"1ST_TNDR_DT" DATE,
"1ST_SCAC" VARCHAR(4),
"1ST_RESP" VARCHAR(2),
"1ST_RESP_DT" DATE,
"2ND_TNDR_DT" DATE,
"2ND_SCAC" CHAR(4),
"2ND_RESP" VARCHAR(2),
"2ND_RESP_DT" DATE,
"3RD_TNDR_DT" DATE,
"3RD_SCAC" CHAR(4),
"3RD_RESP" VARCHAR(2),
"3RD_RESP_DT" DATE);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLITA3. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- InlineContraint Transformation should remove constraint name when is not null
CREATE OR REPLACE TABLE PUBLIC.TABLITA3 (ID NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ NOT NULL /*** MSC-WARNING - MSCEWI1002 - REMOVED NEXT STATEMENT, NOT APPLICABLE IN SNOWFLAKE. CONSTRAINT MICROSOFT_NN_ID ***/,
OBJECTID NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
PROPERTY VARCHAR(64) NOT NULL /*** MSC-WARNING - MSCEWI1002 - REMOVED NEXT STATEMENT, NOT APPLICABLE IN SNOWFLAKE. CONSTRAINT MICROSOFT_NN_PROPERTY ***/,
VALUE VARCHAR(255),
LVALUE VARCHAR /*** MSC-WARNING - MSCEWI1036 - LONG DATA TYPE "" CONVERTED TO VARCHAR ***/,
VERSION NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT (0) NOT NULL /*** MSC-WARNING - MSCEWI1002 - REMOVED NEXT STATEMENT, NOT APPLICABLE IN SNOWFLAKE. CONSTRAINT MICROSOFT_NN_VERSION ***/,
CONSTRAINT MICROSOFT_PK_DTPROPERTIES PRIMARY KEY (ID, PROPERTY) /*** MSC-WARNING - MSCEWI3037 - USING INDEX CONSTRAINT STATE REMOVED FROM THE CONSTRAINT ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR t1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- CREATE SEPARATOR /
CREATE OR REPLACE TABLE PUBLIC.t1 (col1 number (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR t2. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.t2 (col2 number (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR t3. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.t3 (col3 number (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR t4. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.t4 (col4 number (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLITA4. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLITA4 (
COLUMN1 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
COLUMN2 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
/*** MSC-WARNING - MSCEWI3040 - GENERATED ALWAYS STATEMENT REMOVED FROM THE COLUMN DEFINITION ***/
/*** MSC-WARNING - MSCEWI3040 - VIRTUAL KEYWORD REMOVED FROM THE COLUMN DEFINITION ***/
COLUMN3 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ AS (COLUMN1 * COLUMN2),
COLUMN4 FLOAT /*** MSC-WARNING - MSCEWI1036 - NUMBER DATA TYPE "BINARY_FLOAT" CONVERTED TO FLOAT ***/,
COLUMN5 FLOAT /*** MSC-WARNING - MSCEWI1036 - NUMBER DATA TYPE "BINARY_DOUBLE" CONVERTED TO FLOAT ***/,
COLUMN6 VARIANT /*** MSC-WARNING - MSCEWI1055 - REFERENCED CUSTOM TYPE 'USERDEFINEDTYPE.SOMENAME' NOT FOUND ***/,
COLUMN7 VARCHAR(200) DEFAULT CURRENT_SESSION());

--** MSC-WARNING - MSCEWI1063 - ADDED STATEMENTS BECAUSE 'TABLITA4' USED A CUSTOM TYPE **
CREATE OR REPLACE VIEW PUBLIC.TABLITA4_view AS
SELECT
COLUMN1,
COLUMN2,
COLUMN4,
COLUMN5,
COLUMN6 /*** MSC-ERROR - MSCEWI1064 - REFERENCED CUSTOM TYPE 'USERDEFINEDTYPE.SOMENAME' IN QUERY NOT FOUND ***/,
COLUMN7
FROM PUBLIC.TABLITA4;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Default trunc and current_timestamp functions with varchar datatype transformation
-- Users transformation to Current_User
CREATE OR REPLACE TABLE PUBLIC.TABLE1 (COL1 VARCHAR(255) DEFAULT TO_VARCHAR(CURRENT_DATE, 'YYYY-MM-DD'),
COL2 VARCHAR(50) DEFAULT TO_VARCHAR( CURRENT_TIMESTAMP, 'YYYY-MM-DD HH:MI:SS'),
COL3 VARCHAR(40) DEFAULT CURRENT_USER);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR SNOWCONVERT.INTERVALS. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- INTERVAL Date transformations
CREATE OR REPLACE TABLE SNOWCONVERT.INTERVALS (
INTERVAL_YEAR_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "YEAR(2)" CONVERTED TO VARCHAR ***/,
INTERVAL_MONTH_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "MONTH(2)" CONVERTED TO VARCHAR ***/,
INTERVAL_YEAR2MONTH_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "YEAR(2) TO MONTH" CONVERTED TO VARCHAR ***/,
INTERVAL_DAY_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "DAY(2)" CONVERTED TO VARCHAR ***/,
INTERVAL_DAY2HOUR_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "DAY(2) TO HOUR" CONVERTED TO VARCHAR ***/,
INTERVAL_DAY2MINUTE_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "DAY(2) TO MINUTE" CONVERTED TO VARCHAR ***/,
INTERVAL_DAY2SECOND_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "DAY(2) TO SECOND(6)" CONVERTED TO VARCHAR ***/,
INTERVAL_HOUR_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "HOUR(2)" CONVERTED TO VARCHAR ***/,
INTERVAL_HOUR2MINUTE_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "HOUR(2) TO MINUTE" CONVERTED TO VARCHAR ***/,
INTERVAL_HOUR2SECOND_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "HOUR(2) TO SECOND(6)" CONVERTED TO VARCHAR ***/,
INTERVAL_MINUTE_TYPE VARCHAR(20) /*** MSC-WARNING - MSCEWI1036 - INTERVAL DATA TYPE "MINUTE(2)" CONVERTED TO VARCHAR ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR CHECK_CONSTRAINT. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- CHECK constraints tranformations
CREATE OR REPLACE TABLE PUBLIC.CHECK_CONSTRAINT (COLLUMN1 VARCHAR(255),
COLUMN2 VARCHAR(20) DEFAULT 'A Description' NOT NULL
-- ** MSC-WARNING - MSCEWI1024 - THE FOLLOWING CHECK CONSTRAINT WAS COMMENTED OUT **
--                                                     CHECK(COLUMN2 IS NOT NULL )
                                                                                ,
COLUMN3 VARCHAR(20) NOT NULL,
COLUMN4 VARCHAR(20)
/*** MSC-WARNING - MSCEWI1035 - CHECK STATEMENT NOT SUPPORTED ***/
/*  CHECK(COLUMN3 IS NOT NULL )*/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- TIMESTAMP time zone transformations
CREATE OR REPLACE TABLE PUBLIC.TABLE1 (
COL1 TIMESTAMP_LTZ(6),
COL2 TIMESTAMP_TZ(6),
COL3 TIMESTAMP_NTZ(6));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- TIMESTAMP default values casts
CREATE OR REPLACE TABLE PUBLIC.TABLE1 (
COL0 TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP :: TIMESTAMP(6),
COL1 TIMESTAMP(6) DEFAULT CURRENT_TIMESTAMP :: TIMESTAMP(6),
COL2 TIMESTAMP_LTZ(6) DEFAULT '1900-01-01 12:00:00' :: TIMESTAMP_LTZ(6),
COL3 TIMESTAMP_TZ(6) DEFAULT '1900-01-01 12:00:00' :: TIMESTAMP_TZ(6),
COL4 TIMESTAMP_NTZ(6) DEFAULT '1900-01-01 12:00:00' :: TIMESTAMP_NTZ(6),
COL5 TIMESTAMP(6) DEFAULT TO_TIMESTAMP('01/01/1900 12:00:00.000000 AM', 'MM/DD/YYYY HH:MI:SS.FF6 AM') :: TIMESTAMP(6));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- MONTHS_BETWEEN function transformation
CREATE OR REPLACE TABLE PUBLIC.TABLE1 (
COL0 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT /*** MSC-WARNING - MSCEWI1020 - CUSTOM UDF 'MONTHS_BETWEEN_UDF' INSERTED. ***/
 MONTHS_BETWEEN_UDF (TO_DATE ('2003/01/01', 'yyyy/mm/dd'), TO_DATE ('2003/03/14', 'yyyy/mm/dd') ));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- INSTR function transformation
CREATE OR REPLACE TABLE PUBLIC.TABLE1 (
COL0 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT REGEXP_INSTR('CORPORATE FLOOR','OR', -3, 2) /*** MSC-WARNING - MSCEWI3079 - INSTR FUNCTION WAS CONVERTED TO REGEXP_INSTR. THE SECOND ARGUMENT MAY REQUIRE CHANGES ***/ /*** MSC-ERROR - MSCEWI3020 - NEGATIVE VALUES NOT SUPPORTED FOR FUNCTION ***/,
COL1 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT POSITION('OR', 'CORPORATE FLOOR', 3),
COL2 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT POSITION('OR', 'CORPORATE FLOOR'),
COL3 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT REGEXP_INSTR('CORPORATE FLOOR','OR', 3, 2) /*** MSC-WARNING - MSCEWI3079 - INSTR FUNCTION WAS CONVERTED TO REGEXP_INSTR. THE SECOND ARGUMENT MAY REQUIRE CHANGES ***/,
COL4 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/ DEFAULT REGEXP_INSTR('CORPORATE FLOOR','OR', 3, 2) /*** MSC-WARNING - MSCEWI3079 - INSTR FUNCTION WAS CONVERTED TO REGEXP_INSTR. THE SECOND ARGUMENT MAY REQUIRE CHANGES ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLITA01. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLITA01 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 ( COLUMN1 VARCHAR(10));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLITA02. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLITA02 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 ( COLUMN1 VARCHAR(10));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLITA03. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLITA03 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 ( COLUMN1 VARCHAR(10));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR LittleTable. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.LittleTable (
Col1 BINARY /*** MSC-WARNING - MSCEWI1036 - BLOB DATA TYPE "" CONVERTED TO BINARY ***/,
Col3 BINARY /*** MSC-WARNING - MSCEWI1036 - BFILE DATA TYPE "" CONVERTED TO BINARY ***/,
Col4 VARCHAR /*** MSC-WARNING - MSCEWI1036 - NCLOB DATA TYPE "" CONVERTED TO VARCHAR ***/,
Col5 VARCHAR /*** MSC-WARNING - MSCEWI1036 - CLOB DATA TYPE "" CONVERTED TO VARCHAR ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLE1 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 (
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--   COL1 XMLTYPE
               );

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE2. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLE2 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 (
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--   COL1 XMLTYPE
               );

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE3. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLE3 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 (
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--   COL1 XMLTYPE
               );

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE4. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLE4 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 (
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--   COL1 XMLTYPE
               );

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE5. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLE5 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 (
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--   COL1 XMLTYPE
               );

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE6. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLE6 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 (
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--   COL1 XMLTYPE
               );

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLE1 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 ( COL1 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE2. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE TABLE PUBLIC.TABLE2 /*** MSC-WARNING - MSCEWI3024 - TABLE PROPERTIES REMOVED BECAUSE SNOWFLAKE DOES NOT REQUIRE THEM. ***/
 ( COL1 NUMBER (38,19) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR T. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Should remove default from Col1.
CREATE OR REPLACE TABLE PUBLIC.T (
Col1 BINARY /*** MSC-WARNING - MSCEWI1036 - BLOB DATA TYPE "" CONVERTED TO BINARY ***/,
Col5 VARCHAR /*** MSC-WARNING - MSCEWI1036 - CLOB DATA TYPE "" CONVERTED TO VARCHAR ***/ DEFAULT TO_VARCHAR(' - '));

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR datatypeDemo. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Table for datatype support verification.
CREATE OR REPLACE TABLE PUBLIC.datatypeDemo (
col1 FLOAT /*** MSC-WARNING - MSCEWI1036 - NUMBER DATA TYPE "BINARY_DOUBLE" CONVERTED TO FLOAT ***/,
col2 FLOAT /*** MSC-WARNING - MSCEWI1036 - NUMBER DATA TYPE "BINARY_FLOAT" CONVERTED TO FLOAT ***/,
-- col3 CHARACTER VARYING,
col4 DEC,
col5 FLOAT,
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
---- col6 NATIONAL CHARACTER VARYING,
--col7 SYS.AnyData
                ,
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--col8 SYS.AnyDataSet
                   ,
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--col9 SYS.AnyType
                ,
-- ** MSC-ERROR - MSCEWI1028 - TYPE NOT SUPPORTED **
--col10 URIType
             ,
col11 VARCHAR(18) /*** MSC-WARNING - MSCEWI1036 - UROWID DATA TYPE "" CONVERTED TO VARCHAR(18) ***/);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TABLE_WITH_CREATE_INDEX. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Table with create index that was causing runtime exception 
CREATE OR REPLACE TABLE PUBLIC.TABLE_WITH_CREATE_INDEX (COL1 TIMESTAMP (6),
CONSTRAINT CONS1 PRIMARY KEY (COL1) );

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR COM_LAND.SYSDATE_DEFAULT_TEST_TABLE_1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Table for sysdate default with 1 unsupported datatype (VARCHAR)
CREATE OR REPLACE TABLE COM_LAND.SYSDATE_DEFAULT_TEST_TABLE_1 (CHQ_TRAN_NO_1 NUMBER (16,0) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
CHANGED_BY_1 DATE DEFAULT CURRENT_DATE /*** MSC-WARNING - MSCEWI1044 - CONVERTED FROM VARCHAR2 TO DATE FOR CURRENT_DATE DEFAULT ***/,
ENTERED_BY_1 TIMESTAMP_LTZ DEFAULT CURRENT_DATE);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR COM_LAND.SYSDATE_DEFAULT_TEST_TABLE_2. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Table for sysdate default with 1 unsupported datatype (NUMBER)
CREATE OR REPLACE TABLE COM_LAND.SYSDATE_DEFAULT_TEST_TABLE_2 (CHQ_TRAN_NO_2 NUMBER (16,0) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
CHANGED_BY_2 DATE DEFAULT CURRENT_DATE /*** MSC-WARNING - MSCEWI1044 - CONVERTED FROM NUMBER TO DATE FOR CURRENT_DATE DEFAULT ***/,
ENTERED_BY_2 TIMESTAMP_LTZ DEFAULT CURRENT_DATE);

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR COM_LAND.SYSDATE_DEFAULT_TEST_TABLE_3. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Table for sysdate default with all supported datatypes
CREATE OR REPLACE TABLE COM_LAND.SYSDATE_DEFAULT_TEST_TABLE_3 (CHQ_TRAN_NO_3 NUMBER (16,0) /*** MSC-WARNING - MSCEWI1066 - NUMBER TYPE COLUMN MAY NOT BEHAVE SIMILARLY IN SNOWFLAKE ***/,
CHANGED_BY_3 DATE DEFAULT CURRENT_DATE,
ENTERED_BY_3 TIMESTAMP_TZ DEFAULT CURRENT_DATE);