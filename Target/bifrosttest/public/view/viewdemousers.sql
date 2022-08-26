create or replace view BIFROSTTEST.PUBLIC.VIEWDEMOUSERS(
	FIRSTNAME,
	LASTNAME,
	PHONENUMBER,
	EMAIL,
	REGISTRATIONDATE
) as
SELECT
 FirstName,
 LastName,
 PhoneNumber,
 Email,
 RegistrationDate
      FROM
 PUBLIC.DEMOUSERS
      WHERE RegistrationDate <= CURRENT_DATE
-- /** MSC-WARNING - MSCEWI2045 - VIEW WITH OPTION NOT SUPPORTED IN SNOWFLAKE **/
--                                             WITH CHECK OPTION
                                                              ;
