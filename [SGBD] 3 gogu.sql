
<!-- saved from url=(0045)http://profs.info.uaic.ro/~miklos/L3/gogu.sql -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"></head><body><pre style="word-wrap: break-word; white-space: pre-wrap;">-- connect sys/******* as sysdba;

DROP USER u0 CASCADE;
CREATE USER u0 IDENTIFIED BY u0;
GRANT CONNECT, 
	RESOURCE TO u0; 
GRANT ALTER SYSTEM TO u0;
GRANT SELECT ON v_$session
	TO u0;
CREATE OR REPLACE TRIGGER mathew
	AFTER LOGON ON DATABASE
DECLARE
	v_stmt		VARCHAR2(100);
BEGIN
	FOR v_rec 
	IN
		(
		SELECT sid, serial#
		FROM v_$session
		WHERE username = 'U13'
		)
	LOOP
		v_stmt := 'ALTER SYSTEM KILL SESSION ' || Chr( 39 ) || Trim( To_Char( v_rec.sid )) || ',' || 
			Trim( To_Char( v_rec.serial# )) || Chr( 39 ) || ' IMMEDIATE';
		EXECUTE IMMEDIATE v_stmt;
	END LOOP;
END;
/
		
</pre></body></html>