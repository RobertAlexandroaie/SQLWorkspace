DECLARE
v_media NUMBER;
v_gen filme.gen%TYPE;
v_codf distributie.codf%TYPE;

CURSOR c_codf IS
SELECT MAX(AVG(pret)),codf
FROM distributie
GROUP BY codf
;

BEGIN
	
	OPEN c_codf;
	LOOP
		FETCH c_codf
		INTO v_media,v_codf;
		EXIT WHEN c_codf%NOTFOUND;
		
		SELECT gen
		INTO v_gen
		FROM filme
		WHERE codf=v_codf
		;
		
		DBMS_OUTPUT.PUT_LINE(v_gen);
	END LOOP;
	CLOSE c_codf;
END;
/


DECLARE

CURSOR c_act IS
SELECT coda,nume,cota
FROM actori
WHERE coda IN
	(
		SELECT coda
		FROM distributie
		WHERE CODF IN
			(
				SELECT codf
				FROM filme
				WHERE UPPER(gen) like 'B'
			)
	)
;

v_coda actori.coda%TYPE;
v_nume actori.nume%TYPE;
v_cota actori.cota%TYPE;

BEGIN
OPEN c_act;
	LOOP
		FETCH c_act
		INTO v_coda,v_nume,v_coda;
		EXIT WHEN c_act%NOTFOUND;
		
		UPDATE actori
		SET	cota=cota+1
		WHERE coda=v_coda
		;
		
		DBMS_OUTPUT.PUT_LINE(v_nume);
	END LOOP;
	CLOSE c_act;
END;
/
