CREATE OR REPLACE PACKAGE BODY emp_pack
AS
	TYPE t_rp_emp IS RECORD
	(
		coda	angajati.coda%TYPE,
		sal		angajati.salariu%TYPE,
		codd	angajati.codd%TYPE
	);
	TYPE emp_list_type IS TABLE OF t_rp_emp INDEX BY BINARY_INTEGER;
	vp_emp_list emp_list_type;
	
	vp_upper_limit NUMBER := 0;
	
	PROCEDURE Init
	IS
	/* set the whole thing to zero */
	BEGIN
		vp_upper_limit := 0;
	END;
	
	PROCEDURE Add_to_List( p_coda NUMBER, p_sal NUMBER, p_codd NUMBER )
	IS
		v_rec_aux t_rp_emp;
	BEGIN
		vp_upper_limit := vp_upper_limit + 1;
		v_rec_aux.coda	:= p_coda;
		v_rec_aux.sal	:= p_sal;
		v_rec_aux.codd	:= p_codd;
		vp_emp_list(vp_upper_limit) := v_rec_aux;
	END;
	
	PROCEDURE Get_from_List( 
	/* fetch the values from index by table at index position */
		p_ind NUMBER, p_coda OUT NUMBER, p_sal OUT NUMBER, p_codd OUT NUMBER )
	IS
	BEGIN
		p_coda	:= vp_emp_list(p_ind).coda;
		p_sal	:= vp_emp_list(p_ind).sal;
		p_codd	:= vp_emp_list(p_ind).codd;
	END;
	
	FUNCTION Get_Number_of RETURN NUMBER
	/* returns the actual number of elements stored in the index by table */
	IS
	BEGIN
		RETURN vp_upper_limit;
	END;
	
	FUNCTION Code_in( p_coda NUMBER ) RETURN BOOLEAN
	/* checks to see if coda was already deleted */
	IS
		v_last NUMBER;
	BEGIN
		v_last := Get_Number_of;
		FOR i IN 1 .. v_last
		LOOP
			IF p_coda = vp_emp_list(i).coda
			THEN
				RETURN True;
			END IF;
		END LOOP;
		RETURN False;
	END;
END emp_pack;
/