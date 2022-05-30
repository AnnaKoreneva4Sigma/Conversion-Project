-- Procedure Basic Transformation
CREATE OR REPLACE EDITIONABLE PROCEDURE PROCEDURE1 (
   col1    IN VARCHAR2,
   col2     IN batch_history.COMPONENT_NM%TYPE,
   col3     Integer,
   col4     Date,
   col5     IN OUT TIMESTAMP)
   IS
  localVar0 NUMBER;
  localVar1 NUMBER := localVar0 + 45 / 13;
  localVar2 VARCHAR(100);
  localVar3 VARCHAR2(100) := 'local variable 3';
  localVar4 VARCHAR2(100) DEFAULT 'local variable 4';
  localVar5 VARCHAR2(100) NOT NULL := 'local variable 5';
  localVar6 VARCHAR2(100) NOT NULL DEFAULT 'local variable 6';
  localVar7 VARCHAR2(100) := localVar6;
  localVar8 VARCHAR2(100) := 'local variable 7';
  MY_CONST_VAR1 CONSTANT INTEGER(4) := 40;
  MY_CONST_VAR2 CONSTANT INTEGER(4) NOT NULL := 40;
  MY_CONST_VAR3 CONSTANT VARCHAR(50) DEFAULT 'const value';
  MY_CONST_VAR4 CONSTANT REAL NOT NULL DEFAULT 3.14159;
  MY_CONST_VAR5 CONSTANT REAL := MY_CONST_VAR4;
  MY_CONST_VAR5 CONSTANT VARCHAR2 := val1 || col1;
  MY_CONST_VAR6 CONSTANT VARCHAR2 (3)   := ';';
BEGIN
    localVar1 := 123;
    localVar1 := localVar1 + 45 / 13;
    localVar2 := 'val1' || val1;
    v_vendor_table(i) := Null;
    localVar8 :=  LTRIM(RTRIM(TO_CHAR(localVar8, '000'))) || CAST(41.522 AS CHAR(10)) || '.csv';
  IF jobid = 'PU_CLERK' THEN sal_raise := .09;
  ELSIF val1 || col1 = 'col1' THEN sal_raise := .08;
  ELSIF jobid = 'ST_CLERK' THEN sal_raise := .07;
  ELSE 
  sal_raise := 0;
  END IF;
    
   WHILE monthly_value <= 4000
    LOOP
       monthly_value := daily_value * 31;
    END LOOP;
END;

-- Procedure Transformation With Case Statement
CREATE OR REPLACE EDITIONABLE PROCEDURE PROCEDURE2 ()
IS
  localVar1 NUMBER;
  localVar2 VARCHAR(100);
BEGIN
CASE (localVar1)
WHEN 1 THEN
    localVar2 := 'one';
WHEN 2 THEN 
    localVar := 'two'; 
WHEN 3 THEN 
    lovalVar := 'three';
ELSE
    localVar := 'error';
END CASE;

CASE
WHEN localVar = 1 THEN
    localVar2 := 'one';
WHEN localVar = 2 THEN 
    localVar := 'two'; 
WHEN localVar = 3 THEN 
    lovalVar := 'three';
WHEN val1 || val1 = 'col1' THEN
    localVar1 := 'col1' || val1;
ELSE
    localVar := 'error';
END CASE;
END;


CREATE OR REPLACE PROCEDURE LOOPSTEST 
IS
BEGIN
   FOR i IN 1..3 LOOP
    IF i < 3 THEN
          j := 0;
    ELSE
      i := 2;
    END IF;
  END LOOP;

   FOR i IN 1..3 LOOP
    IF i < 3 THEN
          j := 0;
    ELSE
      i := 2;
    END IF;
  END LOOP;

  a := a+a;
  b := a;
  LOOP
    i := i + 1;
    j := 0;
    LOOP
      j := j + 1;
      s := s + i * j; -- Sum several products
      EXIT inner_loop WHEN (j > 5);
      EXIT outer_loop WHEN ((i * j) > 15);
    END LOOP;
    i := i + 1;
  END LOOP;


  WHILE true LOOP
    done := TRUE;
  END LOOP;
END;

-- Procedure Transformation With Case Expressions when it does not have a selector value.
CREATE OR REPLACE EDITIONABLE PROCEDURE PROCEDURE3 ()
IS
  localVar1 NUMBER;
  localVar2 VARCHAR(100);
BEGIN
    AVariable := CASE
    WHEN condition1 THEN thenAction1
    WHEN condition2 THEN thenAction2
    ELSE elseAction
    END;
END;

-- Procedure Transformation With Case Expressions when it has a selector value.
CREATE OR REPLACE EDITIONABLE PROCEDURE PROCEDURE4 ()
IS
  localVar1 NUMBER;
  localVar2 VARCHAR(100);
BEGIN
    AVariable := CASE BVariable
    WHEN comparison1 THEN thenAction1
    WHEN comparison2 THEN thenAction2
    ELSE elseAction
    END;
END;

--Procedure Transformation With Exit Statement
CREATE OR REPLACE PROCEDURE PROCEDURE1
IS
  i NUMBER := 0;
  j NUMBER := 0;
  k NUMBER := 0;
BEGIN
  <<loop_a>>
  LOOP
    i := i + 1;

    <<loop_b>>
    LOOP
      j := j + 1;

      <<loop_c>>
      LOOP
        k := k + j + i;
        EXIT;
      END LOOP loop_c;

      EXIT loop_b WHEN (j > 3 AND j < 10);
    END LOOP loop_b;

    EXIT WHEN (i > 3 OR (false OR true));
  END LOOP loop_a;
END;

--Procedure Transformation with Commit
CREATE OR REPLACE PROCEDURE PROC1
IS
    VAR1 NUMBER;
    WAGES NUMBER := 123;
BEGIN
    INSERT INTO TABLE1 VALUES('val1', 'val2');
    COMMIT;
    DELETE FROM TABLE1 WHERE order_id = 1;
    UPDATE table1 SET column1 = WAGES;
    SELECT * FROM TABLE01 UNION SELECT * FROM TABLE02;
    SELECT col1 FROM TABLE01 UNION ALL SELECT col1 FROM T2;
    SELECT col1 INTO VAR1 FROM (SELECT * FROM TABLE01 UNION SELECT col1, col2, col3 FROM TABLE02);
    --COMMENT1
    /*COMMENT2*/COMMIT/*COMMENT3*/;--COMMENT4
    --COMMENT5
END;

--Procedure without parameters
CREATE OR REPLACE PROCEDURE NO_PARAM
IS
BEGIN
    INSERT INTO TABLE1 VALUES('FOO');
END;

--Procedure with multiple operators and expressions
CREATE OR REPLACE PROCEDURE proc1(param1 in NUMBER, param2 in VARCHAR2) 
is 
var1 number; 
var2 varchar2(20);
BEGIN 
    var1 := 1 + 2 * 8 / 2;
    var2 := 'Hello' || param2;
    
    IF param1 <= 4000 THEN
      insert into table1(s) values ('cond1'); 

    ELSIF param1 > 4000 and param1 <= 7000 THEN
      insert into table1(s) values ('cond2'); 

    ELSIF param1 < 7000 or param1 >= 15000 THEN
      insert into table1(s) values ('cond3'); 

    ELSIF param2 = 'Hello world' THEN
      insert into table1(s) values ('cond3');
    
    ELSIF param2 != 'Hello world' THEN
      insert into table1(s) values ('cond4');
    
    ELSIF var2 <> 'Hello world' or var1 = 10 THEN
      insert into table1(s) values ('cond5');   
    
    ELSIF not (var2 = 'Hello world') THEN
      insert into table1(s) values ('cond5');  
      
   ELSE
      insert into table1(s) values ('cond6'); 

   END IF;
END; 

-- IN PREDICATE
create or replace procedure proc1 
is 
s varchar(20); 
begin 
if ('text') in ('hola', 'mundo') then 
    s := 'Cond1';

elsif 2 in (1, 2, 3, 4) then
    s := 'Cond2';
    
elsif 'text' in (1, 2, 3, 4) then
    s := 'Cond3';

elsif 'text' in ('text', 2, 3, 4) then
    s := 'Cond4';
    
elsif s in ('text', 3, 4) then
    s := 'Cond5';
    
elsif 'text' in ('text', s, 3, 4) then
    s := 'Cond6';

end if; 
 
end; 

--Transformation for implicit cursor
CREATE OR REPLACE PROCEDURE SP_SAMPLE AUTHID DEFINER IS
  stmt_no  POSITIVE;
BEGIN
  IF SQL%ROWCOUNT = 0 THEN
   EXIT ;
  END IF;
  IF SQL%ISOPEN THEN
   EXIT ;
  END IF;
  IF SQL%FOUND THEN
   EXIT ;
  END IF;
  IF SQL%NOTFOUND THEN
   EXIT ;
  END IF;
END;
/

-- Transformation for SQL FUNCTIONS
create or replace procedure functions_test(dateParam DATE, timestampParam TIMESTAMP)
is
	NUM_VALUE INTEGER := 100;
	-- A comment
	STRING_VALUE VARCHAR(20) := 'HELLO';
BEGIN
	STRING_VALUE := TO_CHAR(123);
	STRING_VALUE := TO_CHAR(datePARAM, 'dd-mm-yyyy', 'NLS_DATE_LANGUAGE = language');
	STRING_VALUE := TO_CHAR(timestampParam, 'dd-mm-yyyy HH', 'NLS_DATE_LANGUAGE = language');
	NUM_VALUE := TRUNC(NUM_VALUE);
	NUM_VALUE := TRUNC(NUM_VALUE, 3);
	DATEPARAM := TRUNC(DATEPARAM);
	DATEPARAM := TRUNC(DATEPARAM, 'YEAR');
	timestampParam := TRUNC(timestampParam);
	STRING_VALUE := CHR(456);
	STRING_VALUE := CHR(123 USING NCHAR_CS);
	NUM_VALUE := TO_NUMBER('567');
	NUM_VALUE := TO_NUMBER('2,00' DEFAULT 0 ON CONVERSION ERROR);
	NUM_VALUE := TO_NUMBER('-AusDollars100','L9G999D99', ' NLS_NUMERIC_CHARACTERS = '',.'' NLS_CURRENCY = ''AusDollars'' ');
	STRING_VALUE := TRIM(LEADING '0' FROM  '000123000');
	STRING_VALUE := TRIM(BOTH '0' FROM  '000123000');
END;

--Procedures with call specifications
CREATE OR REPLACE EDITIONABLE PROCEDURE PROC1 () AS LANGUAGE JAVA NAME 'java.lang.Thread.sleep(long)';

--Procedures with Exception handler and exception declaration
--Basic example with raise
CREATE OR REPLACE PROCEDURE HANDLERS_WITH_OTHERS_COMMENTS1 AUTHID DEFINER IS
  deadlock_detected EXCEPTION;
  deadlock_dex EXCEPTION;
  PRAGMA EXCEPTION_INIT(deadlock_detected, -60);
  PRAGMA EXCEPTION_INIT(deadlock_dex, -63);
BEGIN

  IF true THEN
    RAISE NO_DATA_FOUND;
  END IF;

EXCEPTION -- 67
    WHEN NO_DATA_FOUND/*    RAISE NO_DATA_FOUND;*/ THEN -- 67
        INSERT INTO MESSAGETABLE VALUES ('No data found');
    WHEN OTHERS THEN
        INSERT INTO MESSAGETABLE VALUES ('handler for others');
END;
/

--Example with block
CREATE OR REPLACE PROCEDURE HANDLERS_WITH_OTHERS_COMMENTS2 AUTHID DEFINER IS
  deadlock_detected EXCEPTION;
  deadlock_dex EXCEPTION;
  PRAGMA EXCEPTION_INIT(deadlock_detected, -60);
  PRAGMA EXCEPTION_INIT(deadlock_dex, -63);
BEGIN

  IF false THEN
    DBMS_OUTPUT.PUT_LINE('In first if');
    RAISE NO_DATA_FOUND;
  END IF;

  DECLARE
    deadlock_dex EXCEPTION;
    PRAGMA EXCEPTION_INIT(deadlock_dex, -62);
  BEGIN

    INSERT INTO MESSAGETABLE VALUES ('doing something in block');
    RAISE deadlock_dex;
  EXCEPTION
  WHEN deadlock_dex THEN
    INSERT INTO MESSAGETABLE VALUES ('deadlock_dex in block');
  END;


  IF true THEN
    INSERT INTO MESSAGETABLE VALUES ('In second if');
    RAISE NO_DATA_FOUND;
  END IF;

EXCEPTION -- 67
    WHEN NO_DATA_FOUND/*    RAISE NO_DATA_FOUND;*/ THEN -- 67
        INSERT INTO MESSAGETABLE VALUES ('No data found');
        RAISE;
    WHEN OTHERS THEN
        INSERT INTO MESSAGETABLE VALUES ('handler for others');
END;
/

--Example with block in block
CREATE OR REPLACE PROCEDURE HANDLERS_WITH_OTHERS_COMMENTS3 AUTHID DEFINER IS
  deadlock_detected EXCEPTION;
  deadlock_dex EXCEPTION;
  PRAGMA EXCEPTION_INIT(deadlock_detected, -60);
  PRAGMA EXCEPTION_INIT(deadlock_dex, -63);
BEGIN

  IF false THEN
    DBMS_OUTPUT.PUT_LINE('In first if');
    RAISE NO_DATA_FOUND;
  END IF;

  DECLARE
    deadlock_dex EXCEPTION;
    PRAGMA EXCEPTION_INIT(deadlock_dex, -62);
  BEGIN

    INSERT INTO MESSAGETABLE VALUES ('doing something in block');
      DECLARE
        deadlock_dex EXCEPTION;
        PRAGMA EXCEPTION_INIT(deadlock_dex, -61);
      BEGIN

        INSERT INTO MESSAGETABLE VALUES ('doing something in block in block');
        RAISE deadlock_dex;
      EXCEPTION
      WHEN deadlock_dex THEN
        INSERT INTO MESSAGETABLE VALUES ('deadlock_dex in block in block');
      END;

    RAISE deadlock_dex;
  EXCEPTION
  WHEN deadlock_dex THEN
    INSERT INTO MESSAGETABLE VALUES ('deadlock_dex in block');
  END;


  IF true THEN
    INSERT INTO MESSAGETABLE VALUES ('In second if');
    RAISE NO_DATA_FOUND;
  END IF;

EXCEPTION -- 67
    WHEN NO_DATA_FOUND/*    RAISE NO_DATA_FOUND;*/ THEN -- 67
        INSERT INTO MESSAGETABLE VALUES ('No data found');
        RAISE;
    WHEN OTHERS THEN
        INSERT INTO MESSAGETABLE VALUES ('handler for others');
END;
/

--Testing for raise_application_error
CREATE OR REPLACE procedure RAISE_APP_ERR_PROC is
lvReturn NUMBER DEFAULT 1;
parm BOOLEAN := TRUE;
EXC_NAME EXCEPTION;
PRAGMA EXCEPTION_INIT(EXC_NAME, -20010);
BEGIN

raise_application_error(-20010, SQLERRM);
raise_application_error(-20000, SQLERRM, parm);
raise_application_error(-20000, SQLERRM, TRUE);
raise_application_error(-20000, SQLERRM, FALSE);
raise_application_error(-20000, 'CUSTOM ERROR MESSAGE', TRUE);
raise_application_error(-20010, 'SECOND CUSTOM ERROR MESSAGE', TRUE);
raise_application_error(-20010, 'SECOND CUSTOM ERROR MESSAGE', FALSE);

IF lvReturn = 1 THEN
   raise_application_error(-20000, SQLERRM, FALSE);
END IF;

EXCEPTION
   WHEN EXC_NAME THEN
    INSERT INTO FTABLE VALUES ('exc_name trapped');
   WHEN OTHERS THEN
    INSERT INTO FTABLE VALUES ('others trapped');
END;

create or replace procedure TESTING_SOME_QUALIFIED_EXPRESSIONS as
  r_acct ACCOUNT1%ROWTYPE;
  var1 varchar(20);
BEGIN
  r_acct := get_accounts( 1 );
  var1 := get_accounts( 1 ).name;
  var1 := r_acct.name;
END;
/

create or replace procedure row_num_procedure_test as
BEGIN
SELECT *
	FROM row_num_test_table
	WHERE ROWNUM < 11
	ORDER BY column2;
  
SELECT *
  FROM (SELECT * FROM row_num_test_table WHERE ROWNUM < 2 ORDER BY column2 )
  WHERE ROWNUM < 11;
  
SELECT *
  FROM (SELECT * FROM row_num_test_table ORDER BY column2)
  WHERE ROWNUM < 11;
  
UPDATE row_num_test_table
    SET column1 = ROWNUM;
END;
/

CREATE OR REPLACE PROCEDURE Function_Inside_Procedure AS
    VAR1 INTEGER;
	FUNCTION FOO2 return integer;
    FUNCTION FOO2 RETURN INTEGER AS
    BEGIN
        RETURN 123;
    END;
BEGIN
    VAR1 := FOO2() + 456;
END;
/

CREATE OR REPLACE PROCEDURE PROCEDURE_WITH_LIKE AS
BEGIN
	IF 'ABC' LIKE '%A%' THEN
		NULL; -- a comment
	END IF;
  IF 'ABC' LIKE 'A%' THEN
      NULL;
  END IF;
  IF 'ABC' NOT LIKE 'D_%' THEN
      VAR1 := 'GHI';
  END IF;
  IF 'ABC' NOT LIKE 'D/%%' ESCAPE '/' THEN
      NULL;
  END IF;
END;
/

CREATE OR REPLACE PROCEDURE PROCEDURE_WITH_SOME_QUERIES AS
BEGIN
	EXECUTE IMMEDIATE 'ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."';
    EXECUTE IMMEDIATE 'ALTER SESSION SET nls_date_format = "DD-MM-YYYY"';
    EXECUTE IMMEDIATE 'ALTER TABLE SOMENAME ENABLE TABLE LOCK;';
END;
/

CREATE OR REPLACE PROCEDURE Null_Handling AS
    var1 integer := '';
    var2 varchar(20) := null;
BEGIN
	var1 := var1 + 456;
	var2 := var2 || var1;
	IF var1 IS NULL THEN
  -- comment above
		null;
	END IF;
  IF var1 IS NOT NULL THEN
		null; -- comment to the right
	END IF;
END;
/

CREATE OR REPLACE PROCEDURE SPECIAL_INTERPOLATION AS
    var2 varchar(20) := 'select * from TableFetch1 order by col1 offset ' || (2 + 2) || ' rows FETCH NEXT 2 ROWs with ties';
BEGIN
	NULL;
END;
/