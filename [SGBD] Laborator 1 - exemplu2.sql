DECLARE
	v_last_name employees.last_name%TYPE;
BEGIN
	BEGIN
		SELECT last_name INTO v_last_name
		FROM employees WHERE employee_id = 999;
		DBMS_OUTPUT.PUT_LINE('Message 1');
	EXCEPTION
		WHEN TOO_MANY_ROWS THEN
			DBMS_OUTPUT.PUT_LINE('Message 2');
	END;
	
	DBMS_OUTPUT.PUT_LINE('Message 3');
	
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE('Message 4');
END;
/