CREATE OR REPLACE TRIGGER 
Trii
BEFORE DELETE ON angajati
BEGIN
	emp_pack.init;
END;
/

CREATE OR REPLACE TRIGGER
Cetirii
AFTER DELETE ON angajati
FOR EACH ROW
BEGIN
	emp_pack.Add_to_List( :OLD.coda, :OLD.salariu, :OLD.codd );
/*
	It doesn't make sense to call :NEW in a for DELETE trigger
*/
END;
/

CREATE OR REPLACE TRIGGER
Piati
AFTER DELETE ON angajati
DECLARE
	CURSOR c_emp( p_coda NUMBER, p_codd NUMBER )
	IS
	SELECT *
		FROM angajati
		WHERE codd = p_codd AND coda != p_coda;
	v_rowtemp 			c_emp%ROWTYPE;
	v_counter			NUMBER;
	v_nof				NUMBER;
	v_coda				angajati.coda%TYPE;
	v_salariu			angajati.salariu%TYPE;
	v_codd				angajati.codd%TYPE;
/* These are for Me
   to keep the current employee */
	v_initial_coda		angajati.coda%TYPE;
	v_initial_salariu	angajati.salariu%TYPE;
	v_initial_codd		angajati.codd%TYPE;
BEGIN
/* Now let's clean up */
	v_counter 	:= emp_pack.get_number_of;
	
	dbms_output.put_line( 'v_counter is ' ||  v_counter );
	
/* We're talking about status quo ante */
	FOR i IN 1 .. v_counter
	LOOP
		emp_pack.Get_from_List( i, v_initial_coda, v_initial_salariu, v_initial_codd );
		v_nof := 0;
		FOR j IN i + 1 ..  v_counter
		LOOP
			emp_pack.Get_from_List( j, v_coda, v_salariu, v_codd );
			IF v_codd = v_initial_codd AND v_initial_salariu < v_salariu
			THEN
				v_nof := v_nof + 1;
				IF v_nof > 1
				THEN
					RAISE_APPLICATION_ERROR( -20100, 'You blew it' );
				END IF;
			END IF;
/* If we're still here we didn't die yet 
    Remember, we're refering to status quo ante */
			FOR v_rowtemp IN c_emp( v_initial_coda, v_initial_codd )
			LOOP
				IF ((v_initial_codd = v_rowtemp.codd) AND NOT (emp_pack.Code_in( v_rowtemp.coda )) AND
					(v_initial_salariu < v_rowtemp.salariu))
				THEN
					v_nof := v_nof + 1;
					IF v_nof > 1
					THEN
						RAISE_APPLICATION_ERROR( -20100, 'You blew it' );
					END IF;
				END IF;
			END LOOP;
		END LOOP;
	END LOOP;
END;
/
	