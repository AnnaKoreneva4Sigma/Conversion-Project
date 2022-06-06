CREATE OR REPLACE PACKAGE emp_mgmt AS
PROCEDURE remove_emp (employee_id NUMBER );
END emp_mgmt;

CREATE OR REPLACE PACKAGE BODY emp_mgmt AS 
PROCEDURE remove_emp (employee_id NUMBER) IS 
   BEGIN 
      DELETE FROM employees 
      WHERE employees.employee_id = remove_emp.employee_id; 
      tot_emps = tot_emps - 1; 
   END; 
END emp_mgmt; 