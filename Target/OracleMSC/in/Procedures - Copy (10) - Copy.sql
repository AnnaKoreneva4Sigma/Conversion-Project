/*** MSC-WARNING - MSCEWI3056 - SNOWFLAKE DOESN'T SUPPORT VERSIONING OF OBJECTS. DEVELOPERS SHOULD CONSIDER ALTERNATE APPROACHES FOR CODE VERSIONING. ***/
-- Procedure Basic Transformation
CREATE OR REPLACE PROCEDURE PUBLIC.PROCEDURE1 (col1 STRING, col2 VARIANT /*** MSC-WARNING - MSCEWI1036 -  DATA TYPE "batch_history.COMPONENT_NM" CONVERTED TO VARIANT ***/, col3 FLOAT, col4     Date, col5 TIMESTAMP)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   var concatValue = (arg) => IS_NULL(arg) ? "" : arg;
   // END REGION

   let LOCALVAR0;
   let LOCALVAR1 = LOCALVAR0 + 45 / 13;
   let LOCALVAR2;
   let LOCALVAR3 = `local variable 3`;
   let LOCALVAR4 = `local variable 4`;
   let LOCALVAR5 = `local variable 5`;
   let LOCALVAR6 = `local variable 6`;
   let LOCALVAR7 = LOCALVAR6;
   let LOCALVAR8 = `local variable 7`;
   const MY_CONST_VAR1 = 40;
   const MY_CONST_VAR2 = 40;
   const MY_CONST_VAR3 = `const value`;
   const MY_CONST_VAR4 = 3.14159;
   const MY_CONST_VAR5 = MY_CONST_VAR4;
   const MY_CONST_VAR5 = `${concatValue(VAL1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT val1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}${concatValue(COL1)}`;
   const MY_CONST_VAR6 = `;`;
   LOCALVAR1 = 123;
   LOCALVAR1 = LOCALVAR1 + 45 / 13;
   // ** MSC-WARNING - MSCEWI1038 - THIS STATEMENT MAY BE A DYNAMIC SQL THAT COULD NOT BE RECOGNIZED AND CONVERTED **
   LOCALVAR2 = `val1${concatValue(VAL1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT val1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}`;
   null /* v_vendor_table(i) */ /* ** MSC-ERROR - MSCEWI1043 - TRANSLATION FOR EXPRESSION 'v_vendor_table(i)' IS NOT SUPPORTED YET ** */ = undefined;
   // ** MSC-WARNING - MSCEWI1038 - THIS STATEMENT MAY BE A DYNAMIC SQL THAT COULD NOT BE RECOGNIZED AND CONVERTED **
   LOCALVAR8 = `${concatValue((EXEC(`SELECT  LTRIM(RTRIM(TO_CHAR(?, '000')))`,[LOCALVAR8]))[0])}${concatValue((EXEC(`SELECT CAST( 41.522 AS CHAR(10))`))[0])}.csv`;
   if (JOBID /* ** MSC-WARNING - MSCEWI1053 - OBJECT jobid MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == `PU_CLERK`) {
      SAL_RAISE = 0.09;
   } else if (`${concatValue(VAL1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT val1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}${concatValue(COL1)}` == `col1`) {
      SAL_RAISE = 0.08;
   } else if (JOBID /* ** MSC-WARNING - MSCEWI1053 - OBJECT jobid MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == `ST_CLERK`) {
      SAL_RAISE = 0.07;
   } else {
      SAL_RAISE = 0;
   }
   while ( MONTHLY_VALUE /* ** MSC-WARNING - MSCEWI1053 - OBJECT monthly_value MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ <= 4000 ) {
      MONTHLY_VALUE = DAILY_VALUE /* ** MSC-WARNING - MSCEWI1053 - OBJECT daily_value MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ * 31;
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR PROCEDURE2. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
/*** MSC-WARNING - MSCEWI3056 - SNOWFLAKE DOESN'T SUPPORT VERSIONING OF OBJECTS. DEVELOPERS SHOULD CONSIDER ALTERNATE APPROACHES FOR CODE VERSIONING. ***/

-- Procedure Transformation With Case Statement
CREATE OR REPLACE PROCEDURE PUBLIC.PROCEDURE2 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   var concatValue = (arg) => IS_NULL(arg) ? "" : arg;
   // END REGION

   let LOCALVAR1;
   let LOCALVAR2;
   switch(LOCALVAR1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT localVar1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */) {
      case 1:LOCALVAR2 = `one`;
      break;
      case 2:LOCALVAR = `two`;
      break;
      case 3:LOVALVAR = `three`;
      break;
      default:LOCALVAR = `error`;
      break;
   }
   if (LOCALVAR /* ** MSC-WARNING - MSCEWI1053 - OBJECT localVar MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == 1) {
      LOCALVAR2 = `one`;
   } else if (LOCALVAR /* ** MSC-WARNING - MSCEWI1053 - OBJECT localVar MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == 2) {
      LOCALVAR = `two`;
   } else if (LOCALVAR /* ** MSC-WARNING - MSCEWI1053 - OBJECT localVar MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == 3) {
      LOVALVAR = `three`;
   } else if (`${concatValue(VAL1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT val1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}${concatValue(VAL1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT val1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}` == `col1`) {
      // ** MSC-WARNING - MSCEWI1038 - THIS STATEMENT MAY BE A DYNAMIC SQL THAT COULD NOT BE RECOGNIZED AND CONVERTED **
      LOCALVAR1 = `col1${concatValue(VAL1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT val1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}`;
   } else {
      LOCALVAR = `error`;
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR LOOPSTEST. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE PROCEDURE PUBLIC.LOOPSTEST ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   for(let I = 1;I < 3;I++) {
      if (I /* ** MSC-WARNING - MSCEWI1053 - OBJECT i MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ < 3) {
         J = 0;
      } else {
         I = 2;
      }
   }
   for(let I = 1;I < 3;I++) {
      if (I /* ** MSC-WARNING - MSCEWI1053 - OBJECT i MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ < 3) {
         J = 0;
      } else {
         I = 2;
      }
   }
   A = A /* ** MSC-WARNING - MSCEWI1053 - OBJECT a MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + A /* ** MSC-WARNING - MSCEWI1053 - OBJECT a MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */;
   B = A /* ** MSC-WARNING - MSCEWI1053 - OBJECT a MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */;
   while ( true ) {
      I = I /* ** MSC-WARNING - MSCEWI1053 - OBJECT i MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + 1;
      J = 0;
      while ( true ) {
         J = J /* ** MSC-WARNING - MSCEWI1053 - OBJECT j MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + 1;
         S = S /* ** MSC-WARNING - MSCEWI1053 - OBJECT s MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + I /* ** MSC-WARNING - MSCEWI1053 - OBJECT i MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ * J /* ** MSC-WARNING - MSCEWI1053 - OBJECT j MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */;
         /* ** MSC-ERROR - MSCEWI3075 - LABELS IN STATEMENTS ARE NOT SUPPORTED. ** */
         /*       EXIT inner_loop WHEN (j > 5) */
         ;
         /* ** MSC-ERROR - MSCEWI3075 - LABELS IN STATEMENTS ARE NOT SUPPORTED. ** */
         /*       EXIT outer_loop WHEN ((i * j) > 15) */
         ;
      }
      I = I /* ** MSC-WARNING - MSCEWI1053 - OBJECT i MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + 1;
   }
   while ( true ) {
      DONE = true;
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR PROCEDURE3. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
/*** MSC-WARNING - MSCEWI3056 - SNOWFLAKE DOESN'T SUPPORT VERSIONING OF OBJECTS. DEVELOPERS SHOULD CONSIDER ALTERNATE APPROACHES FOR CODE VERSIONING. ***/

-- Procedure Transformation With Case Expressions when it does not have a selector value.
CREATE OR REPLACE PROCEDURE PUBLIC.PROCEDURE3 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let LOCALVAR1;
   let LOCALVAR2;
   AVARIABLE = CONDITION1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT condition1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ && THENACTION1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT thenAction1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ || (CONDITION2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT condition2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ && THENACTION2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT thenAction2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ || ELSEACTION /* ** MSC-WARNING - MSCEWI1053 - OBJECT elseAction MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */);
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR PROCEDURE4. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
/*** MSC-WARNING - MSCEWI3056 - SNOWFLAKE DOESN'T SUPPORT VERSIONING OF OBJECTS. DEVELOPERS SHOULD CONSIDER ALTERNATE APPROACHES FOR CODE VERSIONING. ***/

-- Procedure Transformation With Case Expressions when it has a selector value.
CREATE OR REPLACE PROCEDURE PUBLIC.PROCEDURE4 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let LOCALVAR1;
   let LOCALVAR2;
   AVARIABLE = BVARIABLE /* ** MSC-WARNING - MSCEWI1053 - OBJECT BVariable MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == COMPARISON1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT comparison1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ && THENACTION1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT thenAction1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ || (BVARIABLE /* ** MSC-WARNING - MSCEWI1053 - OBJECT BVariable MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == COMPARISON2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT comparison2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ && THENACTION2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT thenAction2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ || ELSEACTION /* ** MSC-WARNING - MSCEWI1053 - OBJECT elseAction MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */);
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR PROCEDURE1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Procedure Transformation With Exit Statement
CREATE OR REPLACE PROCEDURE PUBLIC.PROCEDURE1 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let I = 0;
   let J = 0;
   let K = 0;
   while ( true ) {
      I = I /* ** MSC-WARNING - MSCEWI1053 - OBJECT i MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + 1;
      while ( true ) {
         J = J /* ** MSC-WARNING - MSCEWI1053 - OBJECT j MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + 1;
         while ( true ) {
            K = K /* ** MSC-WARNING - MSCEWI1053 - OBJECT k MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + J /* ** MSC-WARNING - MSCEWI1053 - OBJECT j MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + I /* ** MSC-WARNING - MSCEWI1053 - OBJECT i MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */;
            break;
         }
         /* ** MSC-ERROR - MSCEWI3075 - LABELS IN STATEMENTS ARE NOT SUPPORTED. ** */
         /* 
               EXIT loop_b WHEN (j > 3 AND j < 10) */
         ;
      }
      if (I /* ** MSC-WARNING - MSCEWI1053 - OBJECT i MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ > 3 || (false || true)) {
         break;
      }
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR PROC1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Procedure Transformation with Commit
CREATE OR REPLACE PROCEDURE PUBLIC.PROC1 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let VAR1;
   let WAGES = 123;
   EXEC(`INSERT INTO PUBLIC.TABLE1 VALUES('val1', 'val2')`);
   EXEC(`COMMIT;`);
   EXEC(`DELETE FROM PUBLIC.TABLE1 WHERE order_id = 1`);
   // ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
   EXEC(`UPDATE table1 SET column1 = ?`,[WAGES /* ** MSC-WARNING - MSCEWI1053 - OBJECT WAGES MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */]);
   EXEC(`SELECT * FROM PUBLIC.TABLE01 UNION SELECT * FROM PUBLIC.TABLE02`);
   EXEC(`SELECT col1 FROM PUBLIC.TABLE01 UNION ALL SELECT col1 FROM PUBLIC.T2`);
   [VAR1] = EXEC(`SELECT col1 FROM (SELECT * FROM PUBLIC.TABLE01 UNION SELECT col1, col2, col3 FROM PUBLIC.TABLE02)`);
   EXEC(`--COMMENT1
    /*COMMENT2*/
COMMIT/*COMMENT3*/;--COMMENT4`);
   //COMMENT5
   ;
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR NO_PARAM. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Procedure without parameters
CREATE OR REPLACE PROCEDURE PUBLIC.NO_PARAM ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   EXEC(`INSERT INTO PUBLIC.TABLE1 VALUES('FOO')`);
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR proc1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Procedure with multiple operators and expressions
CREATE OR REPLACE PROCEDURE PUBLIC.proc1 (param1 FLOAT, param2 STRING)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   var concatValue = (arg) => IS_NULL(arg) ? "" : arg;
   // END REGION

   let VAR1;
   let VAR2;
   VAR1 = 1 + 2 * 8 / 2;
   // ** MSC-WARNING - MSCEWI1038 - THIS STATEMENT MAY BE A DYNAMIC SQL THAT COULD NOT BE RECOGNIZED AND CONVERTED **
   VAR2 = `Hello${concatValue(PARAM2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT param2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}`;
   if (PARAM1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT param1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ <= 4000) {
      EXEC(`insert into PUBLIC.table1(s) values ('cond1')`);
   } else if (PARAM1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT param1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ > 4000 && PARAM1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT param1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ <= 7000) {
      EXEC(`insert into PUBLIC.table1(s) values ('cond2')`);
   } else if (PARAM1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT param1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ < 7000 || PARAM1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT param1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ >= 15000) {
      EXEC(`insert into PUBLIC.table1(s) values ('cond3')`);
   } else if (PARAM2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT param2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == `Hello world`) {
      EXEC(`insert into PUBLIC.table1(s) values ('cond3')`);
   } else if (PARAM2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT param2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ != `Hello world`) {
      EXEC(`insert into PUBLIC.table1(s) values ('cond4')`);
   } else if (VAR2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT var2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ != `Hello world` || VAR1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT var1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == 10) {
      EXEC(`insert into PUBLIC.table1(s) values ('cond5')`);
   } else if (!(VAR2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT var2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == `Hello world`)) {
      EXEC(`insert into PUBLIC.table1(s) values ('cond5')`);
   } else {
      EXEC(`insert into PUBLIC.table1(s) values ('cond6')`);
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR proc1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- IN PREDICATE
CREATE OR REPLACE PROCEDURE PUBLIC.proc1 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let S;
   if ([`hola`,`mundo`].includes(`text`)) {
      S = `Cond1`;
   } else if ([1,2,3,4].includes(2)) {
      S = `Cond2`;
   } else if ([1,2,3,4].includes(`text`)) {
      S = `Cond3`;
   } else if ([`text`,2,3,4].includes(`text`)) {
      S = `Cond4`;
   } else if ([`text`,3,4].includes(S /* ** MSC-WARNING - MSCEWI1053 - OBJECT s MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)) {
      S = `Cond5`;
   } else if ([`text`,S /* ** MSC-WARNING - MSCEWI1053 - OBJECT s MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */,3,4].includes(`text`)) {
      S = `Cond6`;
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR SP_SAMPLE. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Transformation for implicit cursor
CREATE OR REPLACE PROCEDURE PUBLIC.SP_SAMPLE ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let STMT_NO = new POSITIVE();
   if (SQL.ROWCOUNT /*** MSC-WARNING - MSCEWI3021 - SQL IMPLICIT CURSOR VALUES MAY DIFFER ***/ == 0) {
      break;
   }
   if (SQL.ISOPEN /*** MSC-WARNING - MSCEWI3021 - SQL IMPLICIT CURSOR VALUES MAY DIFFER ***/) {
      break;
   }
   if (SQL.FOUND /*** MSC-WARNING - MSCEWI3021 - SQL IMPLICIT CURSOR VALUES MAY DIFFER ***/) {
      break;
   }
   if (SQL.NOTFOUND /*** MSC-WARNING - MSCEWI3021 - SQL IMPLICIT CURSOR VALUES MAY DIFFER ***/) {
      break;
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR functions_test. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

-- Transformation for SQL FUNCTIONS
CREATE OR REPLACE PROCEDURE PUBLIC.functions_test (dateParam DATE, timestampParam TIMESTAMP)
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let NUM_VALUE = 100;
   // A comment
   let STRING_VALUE = `HELLO`;
   STRING_VALUE = (EXEC(`SELECT TO_CHAR(123)`))[0];
   STRING_VALUE = (EXEC(`SELECT /*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR ?. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
 /*** MSC-ERROR - MSCEWI3013 - NLS PARAMETER 'NLS_DATE_LANGUAGE = language' NOT SUPPORTED ***/
 TO_CHAR(?, 'dd-mm-yyyy')`,[DATEPARAM /* ** MSC-WARNING - MSCEWI1053 - OBJECT datePARAM MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */]))[0];
   STRING_VALUE = (EXEC(`SELECT /*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR ?. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
 /*** MSC-ERROR - MSCEWI3013 - NLS PARAMETER 'NLS_DATE_LANGUAGE = language' NOT SUPPORTED ***/
 TO_CHAR(?, 'dd-mm-yyyy HH')`,[TIMESTAMPPARAM /* ** MSC-WARNING - MSCEWI1053 - OBJECT timestampParam MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */]))[0];
   NUM_VALUE = (EXEC(`SELECT TRUNC_UDF(?) /*** MSC-WARNING - MSCEWI1020 - CUSTOM UDF 'TRUNC_UDF' INSERTED. ***/`,[NUM_VALUE /* ** MSC-WARNING - MSCEWI1053 - OBJECT NUM_VALUE MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */]))[0];
   NUM_VALUE = (EXEC(`SELECT TRUNC_UDF(?, 3) /*** MSC-WARNING - MSCEWI1020 - CUSTOM UDF 'TRUNC_UDF' INSERTED. ***/`,[NUM_VALUE /* ** MSC-WARNING - MSCEWI1053 - OBJECT NUM_VALUE MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */]))[0];
   DATEPARAM = (EXEC(`SELECT TRUNC_UDF(?) /*** MSC-WARNING - MSCEWI1020 - CUSTOM UDF 'TRUNC_UDF' INSERTED. ***/`,[DATEPARAM /* ** MSC-WARNING - MSCEWI1053 - OBJECT DATEPARAM MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */]))[0];
   DATEPARAM = (EXEC(`SELECT TRUNC_UDF(?, 'YEAR') /*** MSC-WARNING - MSCEWI1020 - CUSTOM UDF 'TRUNC_UDF' INSERTED. ***/`,[DATEPARAM /* ** MSC-WARNING - MSCEWI1053 - OBJECT DATEPARAM MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */]))[0];
   TIMESTAMPPARAM = (EXEC(`SELECT TRUNC_UDF(?) /*** MSC-WARNING - MSCEWI1020 - CUSTOM UDF 'TRUNC_UDF' INSERTED. ***/`,[TIMESTAMPPARAM /* ** MSC-WARNING - MSCEWI1053 - OBJECT timestampParam MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */]))[0];
   STRING_VALUE = (EXEC(`SELECT CHR(456)`))[0];
   STRING_VALUE = (EXEC(`SELECT CHR(123) /*** MSC-WARNING - MSCEWI3019 - SNOWFLAKE DOES NOT SUPPORT USING NCHAR_CS STATEMENT ***/`))[0];
   NUM_VALUE = (EXEC(`SELECT TO_NUMBER('567')`))[0];
   NUM_VALUE = (EXEC(`SELECT /*** MSC-ERROR - MSCEWI3029 - DEFAULT ON CONVERSION ERROR NOT SUPPORTED ***/
 TO_NUMBER('2,00')`))[0];
   NUM_VALUE = (EXEC(`SELECT /*** MSC-ERROR - MSCEWI3032 - PARAMETER WITH FORMAT 'L9G999D99' NOT SUPPORTED ***/
 /*** MSC-ERROR - MSCEWI3013 - NLS PARAMETER ' NLS_NUMERIC_CHARACTERS = '',.'' NLS_CURRENCY = ''AusDollars'' ' NOT SUPPORTED ***/
 PUBLIC.TO_NUMBER_UDF('TO_NUMBER(''-AusDollars100'',''L9G999D99'', '' NLS_NUMERIC_CHARACTERS = '''',.'''' NLS_CURRENCY = ''''AusDollars'''' '')')`))[0];
   STRING_VALUE = (EXEC(`SELECT LTRIM(  '000123000', '0')`))[0];
   STRING_VALUE = (EXEC(`SELECT TRIM(  '000123000', '0')`))[0];
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR PROC1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
/*** MSC-WARNING - MSCEWI3056 - SNOWFLAKE DOESN'T SUPPORT VERSIONING OF OBJECTS. DEVELOPERS SHOULD CONSIDER ALTERNATE APPROACHES FOR CODE VERSIONING. ***/

--Procedures with call specifications
CREATE OR REPLACE PROCEDURE PUBLIC.PROC1 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   /* ** MSC-ERROR - MSCEWI3012 - CALL TO AN EXTERNAL JAVA PROGRAM IS NOT SUPPORTED ** */
   /* LANGUAGE JAVA NAME 'java.lang.Thread.sleep(long)' */
   ;
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR HANDLERS_WITH_OTHERS_COMMENTS1. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Procedures with Exception handler and exception declaration
--Basic example with raise
CREATE OR REPLACE PROCEDURE PUBLIC.HANDLERS_WITH_OTHERS_COMMENTS1 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
   /*   deadlock_detected EXCEPTION */
   ;
   /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
   /*   deadlock_dex EXCEPTION */
   ;
   /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
   /*   PRAGMA EXCEPTION_INIT(deadlock_detected, -60) */
   ;
   /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
   /*   PRAGMA EXCEPTION_INIT(deadlock_dex, -63) */
   ;
   try {
      if (true) {
         RAISE(100,`NO_DATA_FOUND`,`Single row SELECT returned no rows or your program referenced a deleted element in a nested table or an uninitialized element in an associative array (index-by table).`);
      }
   } catch(error) {
      // 67
      switch(error.name) {
         // 67
         case `NO_DATA_FOUND`: /*    RAISE NO_DATA_FOUND;*/ {
            EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('No data found')`);
            break;
         }
         default: {
            EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('handler for others')`);
            break;
         }
      }
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR HANDLERS_WITH_OTHERS_COMMENTS2. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Example with block
CREATE OR REPLACE PROCEDURE PUBLIC.HANDLERS_WITH_OTHERS_COMMENTS2 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
   /*   deadlock_detected EXCEPTION */
   ;
   /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
   /*   deadlock_dex EXCEPTION */
   ;
   /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
   /*   PRAGMA EXCEPTION_INIT(deadlock_detected, -60) */
   ;
   /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
   /*   PRAGMA EXCEPTION_INIT(deadlock_dex, -63) */
   ;
   try {
      if (false) {
         EXEC(`CALL
DBMS_OUTPUT.PUT_LINE('In first if')`);
         RAISE(100,`NO_DATA_FOUND`,`Single row SELECT returned no rows or your program referenced a deleted element in a nested table or an uninitialized element in an associative array (index-by table).`);
      }
      {
         /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
         /*     deadlock_dex EXCEPTION */
         ;
         /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
         /*     PRAGMA EXCEPTION_INIT(deadlock_dex, -62) */
         ;
         try {
            EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('doing something in block')`);
            RAISE(62,`DEADLOCK_DEX`,`DEADLOCK_DEX`);
         } catch(error) {
            switch(error.name) {
               case `DEADLOCK_DEX`: {
                  EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('deadlock_dex in block')`);
                  break;
               }
               default: {
                  throw error;
                  break;
               }
            }
         }
      }
      if (true) {
         EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('In second if')`);
         RAISE(100,`NO_DATA_FOUND`,`Single row SELECT returned no rows or your program referenced a deleted element in a nested table or an uninitialized element in an associative array (index-by table).`);
      }
   } catch(error) {
      // 67
      switch(error.name) {
         // 67
         case `NO_DATA_FOUND`: /*    RAISE NO_DATA_FOUND;*/ {
            EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('No data found')`);
            throw error;
            break;
         }
         default: {
            EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('handler for others')`);
            break;
         }
      }
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR HANDLERS_WITH_OTHERS_COMMENTS3. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Example with block in block
CREATE OR REPLACE PROCEDURE PUBLIC.HANDLERS_WITH_OTHERS_COMMENTS3 ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
   /*   deadlock_detected EXCEPTION */
   ;
   /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
   /*   deadlock_dex EXCEPTION */
   ;
   /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
   /*   PRAGMA EXCEPTION_INIT(deadlock_detected, -60) */
   ;
   /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
   /*   PRAGMA EXCEPTION_INIT(deadlock_dex, -63) */
   ;
   try {
      if (false) {
         EXEC(`CALL
DBMS_OUTPUT.PUT_LINE('In first if')`);
         RAISE(100,`NO_DATA_FOUND`,`Single row SELECT returned no rows or your program referenced a deleted element in a nested table or an uninitialized element in an associative array (index-by table).`);
      }
      {
         /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
         /*     deadlock_dex EXCEPTION */
         ;
         /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
         /*     PRAGMA EXCEPTION_INIT(deadlock_dex, -62) */
         ;
         try {
            EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('doing something in block')`);
            {
               /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
               /*         deadlock_dex EXCEPTION */
               ;
               /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
               /*         PRAGMA EXCEPTION_INIT(deadlock_dex, -61) */
               ;
               try {
                  EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('doing something in block in block')`);
                  RAISE(61,`DEADLOCK_DEX`,`DEADLOCK_DEX`);
               } catch(error) {
                  switch(error.name) {
                     case `DEADLOCK_DEX`: {
                        EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('deadlock_dex in block in block')`);
                        break;
                     }
                     default: {
                        throw error;
                        break;
                     }
                  }
               }
            }
            RAISE(62,`DEADLOCK_DEX`,`DEADLOCK_DEX`);
         } catch(error) {
            switch(error.name) {
               case `DEADLOCK_DEX`: {
                  EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('deadlock_dex in block')`);
                  break;
               }
               default: {
                  throw error;
                  break;
               }
            }
         }
      }
      if (true) {
         EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('In second if')`);
         RAISE(100,`NO_DATA_FOUND`,`Single row SELECT returned no rows or your program referenced a deleted element in a nested table or an uninitialized element in an associative array (index-by table).`);
      }
   } catch(error) {
      // 67
      switch(error.name) {
         // 67
         case `NO_DATA_FOUND`: /*    RAISE NO_DATA_FOUND;*/ {
            EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('No data found')`);
            throw error;
            break;
         }
         default: {
            EXEC(`INSERT INTO PUBLIC.MESSAGETABLE VALUES ('handler for others')`);
            break;
         }
      }
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR RAISE_APP_ERR_PROC. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/

--Testing for raise_application_error
CREATE OR REPLACE PROCEDURE PUBLIC.RAISE_APP_ERR_PROC ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let LVRETURN = 1;
   let PARM = true;
   /* ** MSC-WARNING - MSCEWI3052 - EXCEPTION DECLARATION IS HANDLED BY RAISE FUNCTION ** */
   /* EXC_NAME EXCEPTION */
   ;
   /* ** MSC-WARNING - MSCEWI3051 - PRAGMA EXCEPTION_INIT IS NOT SUPPORTED. ERROR CODE IS ASSIGNED IN RAISE CALL ** */
   /* PRAGMA EXCEPTION_INIT(EXC_NAME, -20010) */
   ;
   try {
      RAISE(-20010,`EXC_NAME`,SQLERRM);
      // ** MSC-WARNING - MSCEWI3066 - ADD TO STACK OF ERRORS IS NOT SUPPORTED, BOOLEAN ARGUMENT parm WAS REMOVED. **
      RAISE(-20000,SQLERRM);
      // ** MSC-WARNING - MSCEWI3066 - ADD TO STACK OF ERRORS IS NOT SUPPORTED, BOOLEAN ARGUMENT TRUE WAS REMOVED. **
      RAISE(-20000,SQLERRM);
      RAISE(-20000,SQLERRM);
      // ** MSC-WARNING - MSCEWI3066 - ADD TO STACK OF ERRORS IS NOT SUPPORTED, BOOLEAN ARGUMENT TRUE WAS REMOVED. **
      RAISE(-20000,`CUSTOM ERROR MESSAGE`);
      // ** MSC-WARNING - MSCEWI3066 - ADD TO STACK OF ERRORS IS NOT SUPPORTED, BOOLEAN ARGUMENT TRUE WAS REMOVED. **
      RAISE(-20010,`EXC_NAME`,`SECOND CUSTOM ERROR MESSAGE`);
      RAISE(-20010,`EXC_NAME`,`SECOND CUSTOM ERROR MESSAGE`);
      if (LVRETURN /* ** MSC-WARNING - MSCEWI1053 - OBJECT lvReturn MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ == 1) {
         RAISE(-20000,SQLERRM);
      }
   } catch(error) {
      switch(error.name) {
         case `EXC_NAME`: {
            EXEC(`INSERT INTO PUBLIC.FTABLE VALUES ('exc_name trapped')`);
            break;
         }
         default: {
            EXEC(`INSERT INTO PUBLIC.FTABLE VALUES ('others trapped')`);
            break;
         }
      }
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR TESTING_SOME_QUALIFIED_EXPRESSIONS. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE PROCEDURE PUBLIC.TESTING_SOME_QUALIFIED_EXPRESSIONS ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   var ROWTYPE = (stmt,binds = [],obj = new Object()) => {
      EXEC(`SELECT * FROM (${stmt}) LIMIT 0`,binds);
      for(let i = 1;i <= _RS.getColumnCount();i++)obj[_ROWS.getColumnName(i)] = null;
      return obj;
   };
   // END REGION

   let R_ACCT = ROWTYPE(`PUBLIC.ACCOUNT1`) /*** MSC-WARNING - MSCEWI3077 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR ACCOUNT1 ROWTYPE ATTRIBUTE. TABLE ROWTYPE IS ASSUMED. ***/;
   let VAR1;
   R_ACCT = (EXEC(`SELECT /*** MSC-WARNING - MSCEWI1049 - get_accounts FUNCTION WAS NOT RECOGNIZED BY SNOWCONVERT ***/
 PUBLIC.get_accounts_UDF('get_accounts( 1 )')`))[0];
   VAR1 = (EXEC(`SELECT /*** MSC-WARNING - MSCEWI1049 - get_accounts FUNCTION WAS NOT RECOGNIZED BY SNOWCONVERT ***/
 PUBLIC.get_accounts_UDF('get_accounts( 1 )')`))[0].NAME;
   VAR1 = //  ** MSC-WARNING - MSCEWI1053 - OBJECT r_acct.name MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** 
 R_ACCT.NAME;
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR row_num_procedure_test. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE PROCEDURE PUBLIC.row_num_procedure_test ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   EXEC(`SELECT *
	FROM PUBLIC.row_num_test_table
	WHERE /*** MSC-ERROR - MSCEWI3027 - ROWNUM NOT SUPPORTED ***/
 PUBLIC.ROWNUM_UDF('ROWNUM') < 11
	ORDER BY column2`);
   EXEC(`SELECT *
  FROM (SELECT * FROM PUBLIC.row_num_test_table WHERE /*** MSC-ERROR - MSCEWI3027 - ROWNUM NOT SUPPORTED ***/
 PUBLIC.ROWNUM_UDF('ROWNUM') < 2 ORDER BY column2)
  WHERE /*** MSC-ERROR - MSCEWI3027 - ROWNUM NOT SUPPORTED ***/
 PUBLIC.ROWNUM_UDF('ROWNUM') < 11`);
   EXEC(`SELECT *
  FROM (SELECT * FROM PUBLIC.row_num_test_table ORDER BY column2)
  WHERE /*** MSC-ERROR - MSCEWI3027 - ROWNUM NOT SUPPORTED ***/
 PUBLIC.ROWNUM_UDF('ROWNUM') < 11`);
   EXEC(`UPDATE row_num_test_table
    SET column1 = /*** MSC-ERROR - MSCEWI3027 - ROWNUM NOT SUPPORTED ***/
 PUBLIC.ROWNUM_UDF('ROWNUM')`);
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR Function_Inside_Procedure. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE PROCEDURE PUBLIC.Function_Inside_Procedure ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   let VAR1;
   /* ** MSC-ERROR - MSCEWI3057 - TRANSLATION FOR NESTED PROCEDURE OR FUNCTION IS NOT SUPPORTED YET ** */
   /* 	FUNCTION FOO2 return integer; */
   ;
   /* ** MSC-ERROR - MSCEWI3057 - TRANSLATION FOR NESTED PROCEDURE OR FUNCTION IS NOT SUPPORTED YET ** */
   /*     FUNCTION FOO2 RETURN INTEGER AS
       BEGIN
           RETURN 123;
       END; */
   ;
   VAR1 = (EXEC(`SELECT /*** MSC-WARNING - MSCEWI1049 - FOO2 FUNCTION WAS NOT RECOGNIZED BY SNOWCONVERT ***/
 PUBLIC.FOO2_UDF('FOO2()')`))[0] + 456;
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR PROCEDURE_WITH_LIKE. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE PROCEDURE PUBLIC.PROCEDURE_WITH_LIKE ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   function LIKE(expr,pattern,esc,cs) {
      function fixPattern(pattern,esc) {
         const specials = '/.*+?|(){}[]\\'.split('');
         var newPattern = "";
         var fix = (c) => specials.includes(c) ? '\\' + c : c;
         for(var i = 0;i < pattern.length;i++) {
            var c = pattern[i];
            if (c === esc) {
               newPattern += pattern[i + 1]
               i++
            } else if (c === '%') {
               newPattern += ".*?"
            } else if (c === '_') {
               newPattern += "."
            } else if (c === '[' || ']') {
               newPattern += c
            } else newPattern += fix(c)
         }
         return newPattern;
      }
      return new RegExp(`^${fixPattern(pattern,esc)}$`,cs ? '' : 'i').exec(expr) != null;
   }
   // END REGION

   if (LIKE(`ABC`,`%A%`)) {
      null; // a comment
   }
   if (LIKE(`ABC`,`A%`)) {
      null;
   }
   if (!LIKE(`ABC`,`D_%`)) {
      VAR1 = `GHI`;
   }
   if (!LIKE(`ABC`,`D/%%`,`/`)) {
      null;
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR PROCEDURE_WITH_SOME_QUERIES. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE PROCEDURE PUBLIC.PROCEDURE_WITH_SOME_QUERIES ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   // END REGION

   /*EXEC(`-- ** MSC-ERROR - MSCEWI3062 - NUMERIC CHARACTERS CANNOT BE ALTERED IN SNOWFLAKE. THE DECIMAL SEPARATOR IN SNOWFLAKE IS THE DOT CHARACTER. ***/
   /*--ALTER SESSION SET NLS_NUMERIC_CHARACTERS = ",."`)*/
   ;
   EXEC(`ALTER SESSION SET /*** MSC-WARNING - MSCEWI3058 - NLS_DATE_FORMAT SESSION PARAMETER DOES NOT ENFORCE THE INPUT FORMAT IN ORACLE ***/
 DATE_INPUT_FORMAT = "DD-MM-YYYY" DATE_OUTPUT_FORMAT = "DD-MM-YYYY"`);
   /*EXEC(`-- ** MSC-ERROR - MSCEWI3046 - ALTER TABLE SYNTAX NOT APPLICABLE IN SNOWFLAKE ***/
   /*--ALTER TABLE PUBLIC.SOMENAME ENABLE TABLE LOCK`)*/
   ;
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR Null_Handling. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE PROCEDURE PUBLIC.Null_Handling ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   var concatValue = (arg) => IS_NULL(arg) ? "" : arg;
   // END REGION

   let VAR1 = undefined;
   let VAR2 = undefined;
   VAR1 = VAR1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT var1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */ + 456;
   // ** MSC-WARNING - MSCEWI1038 - THIS STATEMENT MAY BE A DYNAMIC SQL THAT COULD NOT BE RECOGNIZED AND CONVERTED **
   VAR2 = `${concatValue(VAR2 /* ** MSC-WARNING - MSCEWI1053 - OBJECT var2 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}${concatValue(VAR1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT var1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)}`;
   if (IS_NULL(VAR1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT var1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)) {
      // comment above
      null;
   }
   if (!IS_NULL(VAR1 /* ** MSC-WARNING - MSCEWI1053 - OBJECT var1 MAY NOT WORK PROPERLY, ITS DATATYPE WAS NOT RECOGNIZED ** */)) {
      null; // comment to the right
   }
$$;

/*** MSC-WARNING - MSCEWI1039 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR SPECIAL_INTERPOLATION. CHECK IF THE NAME IS INVALID OR DUPLICATED. ***/
CREATE OR REPLACE PROCEDURE PUBLIC.SPECIAL_INTERPOLATION ()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS CALLER
AS
$$
   // REGION SnowConvert Helpers Code
   var formatDate = (arg) => (new Date(arg - (arg.getTimezoneOffset() * 60000))).toISOString().slice(0,-1);
   var fixBind = function (arg) {
      arg = arg instanceof Date ? formatDate(arg) : IS_NULL(arg) ? null : arg;
      return arg;
   };
   var SQL = {
      FOUND : false,
      NOTFOUND : false,
      ROWCOUNT : 0,
      ISOPEN : false
   };
   var _RS, _ROWS, SQLERRM = "normal, successful completion", SQLCODE = 0;
   var getObj = (_rs) => Object.assign(new Object(),_rs);
   var getRow = (_rs) => (values = Object.values(_rs)) && (values = values.splice(-1 * _rs.getColumnCount())) && values;
   var fetch = (_RS,_ROWS,fmode) => _RS.getRowCount() && _ROWS.next() && (fmode ? getObj : getRow)(_ROWS) || (fmode ? new Object() : []);
   var EXEC = function (stmt,binds,opts) {
      try {
         binds = !(arguments[1] instanceof Array) && ((opts = arguments[1]) && []) || (binds || []);
         opts = opts || new Object();
         binds = binds ? binds.map(fixBind) : binds;
         _RS = snowflake.createStatement({
               sqlText : stmt,
               binds : binds
            });
         _ROWS = _RS.execute();
         if (opts.sql !== 0) {
            var isSelect = stmt.toUpperCase().trimStart().startsWith("SELECT");
            var affectedRows = isSelect ? _RS.getRowCount() : _RS.getNumRowsAffected();
            SQL.FOUND = affectedRows != 0;
            SQL.NOTFOUND = affectedRows == 0;
            SQL.ROWCOUNT = affectedRows;
         }
         if (opts.row === 2) {
            return _ROWS;
         }
         var INTO = function (opts) {
            if (opts.vars == 1 && _RS.getColumnCount() == 1 && _ROWS.next()) {
               return _ROWS.getColumnValue(1);
            }
            if (opts.rec instanceof Object && _ROWS.next()) {
               var recordKeys = Object.keys(opts.rec);
               Object.assign(opts.rec,Object.fromEntries(new Map(getRow(_ROWS).map((element,Index) => [recordKeys[Index],element]))))
               return opts.rec;
            }
            return fetch(_RS,_ROWS,opts.row);
         };
         var BULK_INTO_COLLECTION = function (into) {
            for(let i = 0;i < _RS.getRowCount();i++) {
               FETCH_INTO_COLLECTIONS(into,fetch(_RS,_ROWS,opts.row));
            }
            return into;
         };
         if (_ROWS.getRowCount() > 0) {
            return _ROWS.getRowCount() == 1 ? INTO(opts) : BULK_INTO_COLLECTION(opts);
         }
      } catch(error) {
         RAISE(error.code,error.name,error.message)
      }
   };
   var RAISE = function (code,name,message) {
      message === undefined && ([name,message] = [message,name])
      var error = new Error(message);
      error.name = name
      SQLERRM = `${(SQLCODE = (error.code = code))}: ${message}`
      throw error;
   };
   var FETCH_INTO_COLLECTIONS = function (collections,fetchValues) {
      for(let i = 0;i < collections.length;i++) {
         collections[i].push(fetchValues[i]);
      }
   };
   var IS_NULL = (arg) => !(arg || arg === 0);
   var concatValue = (arg) => IS_NULL(arg) ? "" : arg;
   // END REGION

   let VAR2 = `select * from PUBLIC.TableFetch1
QUALIFY RANK() OVER ( order by col1) - ${concatValue(2 + 2)} <= 2
LIMIT NULL OFFSET ${concatValue(2 + 2)}`;
   null;
$$;