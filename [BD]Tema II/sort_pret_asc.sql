DECLARE
	CURSOR PRET_CURS IS
	SELECT O.IDOB, O.TITLU, O.RATING, O.PRET, A.IDAUT, A.NUME, A.TARA
	FROM OBIECT_ARTA O, AUTOR A ORDER BY O.PRET
	WHERE (O.IDOB, A.IDAUT) IN
		(
			SELECT IDOB, IDAUT
			FROM POSTARE
		);

	v_IDO OBIECT_ARTA.IDOB%TYPE;
	v_TITLU OBIECT_ARTA.TITLU%TYPE;
	v_RATING OBIECT_ARTA.RATING%TYPE;
	v_PRET OBIECT_ARTA.PRET%TYPE;
	
	v_IDA AUTOR.IDAUT%TYPE;
	v_NUME AUTOR.NUME%TYPE;
	v_TARA AUTOR.TARA%TYPE;
	
BEGIN
	OPEN PRET_CURS;
	LOOP
		FETCH PRET_CURS INTO v_IDO, v_TITLU, v_RATING, v_PRET, v_IDA, v_NUME, v_TARA;
		EXIT WHEN PRET_CURS%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(v_TITLU||' '||v_PRET||' '||v_RATING||' '||v_NUME||' '||v_TARA);
		
	END LOOP;
CLOSE PRET_CURS;
END;

/