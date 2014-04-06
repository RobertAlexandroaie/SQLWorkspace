-- cod care pastreaza, in plus pt.fiecare angajat 2 liste de inregistrari
-- 1. modificare mgr-ului angajatului si data la care s-a facut modificarea
-- 2. modificarea job-ului angajatului si data la care s-a facut modificarea
-- Obs.: Pt.simplitate nu am verificat la 1 ca noul mgr este un empno valid.
-- ar.fi complicat inutil codul
-- tipurile necesare pt.VARRAY-uri
-- se putea si cu record-uri, am preferat obiectele
-- un tip pt.inreg unei schimari de mgr
DROP TYPE mgr_list_item FORCE;
CREATE TYPE mgr_list_item AS OBJECT
(
mgr NUMBER(4),
fld_date DATE
);
/
-- crearea tipului de varay de mgr_list_item
DROP TYPE mgr_list_type FORCE;
CREATE TYPE mgr_list_type IS VARRAY(10) OF mgr_list_item;
/
-- similar mgr_list_item si mgr_list_type
DROP TYPE job_list_item FORCE;
CREATE TYPE job_list_item AS OBJECT
(
job CHAR(9),
fld_date DATE
);
/
DROP TYPE job_list_type FORCE;
CREATE OR REPLACE TYPE job_list_type AS VARRAY(10) OF job_list_item;
/
DROP TABLE dept CASCADE CONSTRAINTS
/
CREATE TABLE dept
(
deptno NUMBER(2) PRIMARY KEY,
dname CHAR(14) NOT NULL,
loc CHAR(13) NOT NULL
)
/
DROP TABLE emp CASCADE CONSTRAINTS
/
CREATE TABLE emp
(
empno NUMBER(4) PRIMARY KEY,
ename CHAR(10) NOT NULL,
job CHAR(9) NOT NULL,
mgr NUMBER(4),
hiredate DATE NOT NULL ,
sal NUMBER(7,2) NOT NULL,
comm NUMBER(7,2) NULL,deptno NUMBER(2) REFERENCES dept( deptno ),
-- se adauga cele doua varray-uri pt.istoricul mgr-ilor si job-urilor
mgr_list mgr_list_type,
job_list job_list_type
)
/
INSERT INTO dept VALUES
( 10, 'ACCOUNTING', 'NEW YORK' )
/
INSERT INTO dept VALUES
( 20, 'RESEARCH', 'DALLAS' )
/
INSERT INTO dept VALUES
( 30, 'SALES', 'CHICAGO' )
/
INSERT INTO dept VALUES
( 40, 'OPERATIONS', 'BOSTON' )
/
-- observati fol.c-torilor pt.v-array-uri si elem.lor in insert-uri
INSERT INTO emp VALUES
( 7369, 'SMITH', 'CLERK', 7902, TO_DATE( '17/12/1980', 'dd/mm/yyyy' ), 800, NULL , 20,
mgr_list_type( mgr_list_item( 7902, TO_DATE( '17/12/1980', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'CLERK', TO_DATE( '17/12/1980', 'dd/mm/yyyy' )))
)
/
INSERT INTO emp VALUES
( 7499, 'ALLEN', 'SALESMAN', 7698, TO_DATE( '20/2/1981', 'dd/mm/yyyy' ), 1600, 300, 30,
mgr_list_type( mgr_list_item( 7698, TO_DATE( '20/2/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'SALESMAN', TO_DATE( '20/2/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7521, 'WARD', 'SALESMAN', 7698, TO_DATE( '22/2/1981', 'dd/mm/yyyy' ), 1250, 500, 30,
mgr_list_type( mgr_list_item( 7698, TO_DATE( '22/2/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'SALESMAN', TO_DATE( '22/2/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7566, 'JONES', 'MANAGER', 7839, TO_DATE( '2/4/1981', 'dd/mm/yyyy' ), 2975, NULL, 20,
mgr_list_type( mgr_list_item( 7839, TO_DATE( '2/4/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'MANAGER', TO_DATE( '2/4/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7654, 'MARTIN', 'SALESMAN', 7698, TO_DATE( '28/9/1981', 'dd/mm/yyyy' ), 1250, 1400, 30,
mgr_list_type( mgr_list_item( 7698, TO_DATE( '28/9/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'SALESMAN', TO_DATE( '28/9/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7698, 'BLAKE', 'MANAGER', 7839, TO_DATE( '1/5/1981', 'dd/mm/yyyy' ), 2850, NULL, 30,
mgr_list_type( mgr_list_item( 7839, TO_DATE( '1/5/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'MANAGER', TO_DATE( '1/5/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7782, 'CLARK', 'MANAGER', 7839, TO_DATE( '9/6/1981', 'dd/mm/yyyy' ), 2450, NULL, 10,
mgr_list_type( mgr_list_item( 7839, TO_DATE( '9/6/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'MANAGER', TO_DATE( '9/6/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES( 7788, 'SCOTT', 'ANALYST', 7566, TO_DATE( '13/7/1987', 'dd/mm/yyyy' ), 3000, NULL, 20,
mgr_list_type( mgr_list_item( 7566, TO_DATE( '13/7/1987', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'ANALYST', TO_DATE( '13/7/1987', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7839, 'KING', 'PRESIDENT', NULL, TO_DATE( '17/11/1981', 'dd/mm/yyyy' ), 5000, NULL, 10,
NULL,
job_list_type( job_list_item( 'ANALYST', TO_DATE( '17/11/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7844, 'TURNER', 'SALESMAN', 7698, TO_DATE( '8/9/1981', 'dd/mm/yyyy' ), 1500, 0, 30,
mgr_list_type( mgr_list_item( 7698, TO_DATE( '8/9/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'SALESMAN', TO_DATE( '8/9/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7876, 'ADAMS', 'CLERK', 7788, TO_DATE( '13/7/1987', 'dd/mm/yyyy' ), 1100, NULL, 20,
mgr_list_type( mgr_list_item( 7788, TO_DATE( '13/7/1987', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'CLERK', TO_DATE( '13/7/1987', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7900, 'JAMES', 'CLERK', 7698, TO_DATE('3/12/1981', 'dd/mm/yyyy'), 950, NULL, 30,
mgr_list_type( mgr_list_item( 7698, TO_DATE( '3/12/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'CLERK', TO_DATE( '3/12/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7902, 'FORD', 'ANALYST', 7566, TO_DATE( '3/12/1981', 'dd/mm/yyyy' ), 3000, NULL, 20,
mgr_list_type( mgr_list_item( 7566, TO_DATE( '3/12/1981', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'ANALYST', TO_DATE( '3/12/1981', 'dd/mm/yyyy' ))))
/
INSERT INTO emp VALUES
( 7934, 'MILLER', 'CLERK', 7782, TO_DATE( '23/1/1982', 'dd/mm/yyyy' ), 1300, NULL, 10,
mgr_list_type( mgr_list_item( 7782, TO_DATE( '23/1/1982', 'dd/mm/yyyy' ))),
job_list_type( job_list_item( 'CLERK', TO_DATE( '23/1/1982', 'dd/mm/yyyy' ))))
/
DROP TABLE bonus
/
CREATE TABLE bonus
(
ename CHAR(10) NULL,
job CHAR(9) NULL,
sal NUMBER NOT NULL,
comm NUMBER
)
/
DROP TABLE salgrade;
CREATE TABLE salgrade
(
grade NUMBER(5),
losal NUMBER(7),
hisal NUMBER(7),
tax NUMBER(5, 2),
seniority NUMBER(2));
INSERT INTO salgrade VALUES( 1, 700, 1200, 0.10, 2 );INSERT INTO salgrade VALUES( 2, 1201, 1400, 0.15, 3 );
INSERT INTO salgrade VALUES( 3, 1401, 2000, 0.20, 4 );
INSERT INTO salgrade VALUES( 4, 2001, 3000, 0.35, 3 );
INSERT INTO salgrade VALUES( 5, 3001, 9999, 0.60, 0 );
ALTER TABLE emp ADD CONSTRAINT emp_mgr_fk FOREIGN KEY( mgr ) REFERENCES emp( empno );
-- pachet helper pentru implementarea trigger-elor asociate actualizarii 
-- tabelei emp
CREATE OR REPLACE PACKAGE trigg_pack1
AS
v_cNumofEmps NUMBER; -- nr.tuturor angajatilor
-- dimensiunile tabelelor asociative pt.actualizare mgr resp.job 
-- (cite linii in emp ar tb.afectate)
v_cMgrLen NUMBER;
v_cJobLen NUMBER;
PROCEDURE init;
FUNCTION get_mgr_tab_empno( ind IN INTEGER ) RETURN emp.empno%TYPE;
FUNCTION get_mgr_tab_mgr( ind IN NUMBER ) RETURN emp.empno%TYPE;
PROCEDURE insert_mgr_tab( p_empno emp.empno%TYPE, p_mgr emp.empno%TYPE );
FUNCTION get_job_tab_empno( ind IN INTEGER ) RETURN emp.empno%TYPE;
FUNCTION get_job_tab_job( ind IN NUMBER ) RETURN emp.job%TYPE;
PROCEDURE insert_job_tab( p_empno emp.empno%TYPE, p_job emp.job%TYPE );
-- pt.verificarea id-ului noului MGR (nu se introduce un circuit
PROCEDURE check_mgr( p_empno emp.empno%TYPE, p_mgr emp.mgr%TYPE );
END trigg_pack1;
/
CREATE OR REPLACE PACKAGE BODY trigg_pack1
AS
-- tabela asociativa pt.mgr si tipurile nesare
-- fiecarui indice i se asociaza o inreg: ( empno, id-ul noului mgr)
TYPE mgr_rec IS RECORD
(
empno emp.empno%TYPE,
mgr emp.mgr%TYPE
);
TYPE mgr_rec_tab IS TABLE OF mgr_rec INDEX BY BINARY_INTEGER;
v_mgr_rec_tab mgr_rec_tab;
-- tabela asociativa pt.job si tipurile nesare
-- ca mai sus
TYPE job_rec IS RECORD
(
empno emp.empno%TYPE,
job emp.job%TYPE
);
TYPE job_rec_tab IS TABLE OF job_rec INDEX BY BINARY_INTEGER;
v_job_rec_tab job_rec_tab;
PROCEDURE init
IS
BEGIN
v_cMgrLen := 0;
v_cJobLen := 0;SELECT COUNT(*)
INTO v_cNumofEmps
FROM emp;
END init;
-- returneaza din lista de ( empno, mgr ) empno-ul de pe poz.i
FUNCTION get_mgr_tab_empno( ind IN INTEGER ) RETURN emp.empno%TYPE
IS
BEGIN
RETURN v_mgr_rec_tab(ind).empno;
END get_mgr_tab_empno;
-- returneaza din lista de ( empno, mgr ) mgr-ul de pe poz.i
FUNCTION get_mgr_tab_mgr( ind IN NUMBER ) RETURN emp.empno%TYPE
IS
BEGIN
RETURN v_mgr_rec_tab(ind).mgr;
END get_mgr_tab_mgr;
-- adauga in lista de ( empno, new mgr ) o noua inregistrare
-- apelata in triggerul for each row bef_upd_row1 pt.modif.
-- mgr-ului unui angajat
PROCEDURE insert_mgr_tab( p_empno emp.empno%TYPE, p_mgr emp.empno%TYPE )
IS
v_mgr_rec mgr_rec;
BEGIN
v_mgr_rec.empno := p_empno;
v_mgr_rec.mgr := p_mgr;
v_cMgrLen := v_cMgrLen + 1;
v_mgr_rec_tab(v_cMgrLen) := v_mgr_rec;
END insert_mgr_tab;
-- aceleasi ca mai sus dar pt.joburi
FUNCTION get_job_tab_empno( ind IN INTEGER ) RETURN emp.empno%TYPE
IS
BEGIN
RETURN v_job_rec_tab(ind).empno;
END get_job_tab_empno;
FUNCTION get_job_tab_job( ind IN NUMBER ) RETURN emp.job%TYPE
IS
BEGIN
RETURN v_job_rec_tab(ind).job;
END get_job_tab_job;
PROCEDURE insert_job_tab( p_empno emp.empno%TYPE, p_job emp.job%TYPE )
IS
v_job_rec job_rec;
BEGIN
v_job_rec.empno := p_empno;
v_job_rec.job := p_job;
v_cJobLen := v_cJobLen + 1;
v_job_rec_tab(v_cJobLen) := v_job_rec;
END insert_job_tab;
-- nu este permis ca prin modificare mgr-ului unui empno
-- sa apara o relatie ciclica
PROCEDURE check_mgr( p_empno emp.empno%TYPE, p_mgr emp.mgr%TYPE )
IS
v_count NUMBER := 0;
BEGINFOR v_aux_rec IN
(
SELECT 1
FROM emp
CONNECT BY PRIOR mgr = empno
START WITH empno = p_empno
)
LOOP
v_count := v_count + 1;
IF v_count = v_cNumofEmps + 1
THEN
RAISE_APPLICATION_ERROR( -20020, 'Cyclical relation due to new mgr id' );
END IF;
END LOOP;
END check_mgr;
END trigg_pack1;
/
-- in continuare implementarea standard a trigger-elor
-- pt.tabele mutante pt.modificare mgr-ului sau a job-ului
CREATE OR REPLACE TRIGGER bef_upd_stmt1
BEFORE UPDATE OF mgr ON emp
BEGIN
trigg_pack1.init;
END;
/
CREATE OR REPLACE TRIGGER bef_upd_row1
BEFORE UPDATE OF mgr, job ON emp
FOR EACH ROW
DECLARE
v_aux_job_list job_list_type;
BEGIN
-- daca nu si-a schimbat mgr-ul
IF NVL( :OLD.mgr, -1 ) <> NVL( :NEW.mgr, -1 )
THEN
trigg_pack1.insert_mgr_tab( :OLD.empno, :NEW.mgr );
END IF;
-- e nevoie de memorare temporara pt.ca trebuie actualizata lista
-- de job-uri, deci SELECT pe o tabela mutanta
IF :OLD.job <> :NEW.job
THEN
trigg_pack1.insert_job_tab( :OLD.empno, :NEW.job );
END IF;
END;
/
CREATE OR REPLACE TRIGGER aft_upd_stmt2
AFTER UPDATE OF mgr, job ON emp
DECLARE
v_aux_empno emp.empno%TYPE;
v_aux_mgr emp.mgr%TYPE;
v_aux_job emp.job%TYPE;
v_aux_mgr_list mgr_list_type := mgr_list_type();
v_aux_job_list job_list_type := job_list_type();
v_counter NUMBER;
BEGIN
IF trigg_pack1.v_cMgrLen <> 0THEN
FOR i IN 1..trigg_pack1.v_cMgrLen
LOOP
v_aux_empno := trigg_pack1.get_mgr_tab_empno( i );
v_aux_mgr := trigg_pack1.get_mgr_tab_mgr( i );
trigg_pack1.check_mgr( v_aux_empno, v_aux_mgr );
SELECT mgr_list
INTO v_aux_mgr_list
FROM emp
WHERE empno = v_aux_empno;
v_counter := v_aux_mgr_list.LAST;
v_aux_mgr_list.EXTEND;
v_counter := v_counter + 1;
-- initializarea necesara
v_aux_mgr_list(v_counter) := mgr_list_item( NULL, NULL );
v_aux_mgr_list(v_counter).mgr := v_aux_mgr;
v_aux_mgr_list(v_counter).fld_date := SYSDATE;
UPDATE emp
SET mgr_list = v_aux_mgr_list
WHERE empno = v_aux_empno;
END LOOP;
END IF;
IF trigg_pack1.v_cJobLen <> 0
THEN
FOR i IN 1..trigg_pack1.v_cJobLen
LOOP
v_aux_empno := trigg_pack1.get_job_tab_empno( i );
v_aux_job := trigg_pack1.get_job_tab_job( i );
SELECT job_list
INTO v_aux_job_list
FROM emp
WHERE empno = v_aux_empno;
v_counter := v_aux_job_list.LAST;
v_aux_job_list.EXTEND;
v_counter := v_counter + 1;
v_aux_job_list( v_counter ) := job_list_item( NULL, NULL );
v_aux_job_list(v_counter).job := v_aux_job;
v_aux_job_list(v_counter).fld_date := SYSDATE;
UPDATE emp
SET job_list = v_aux_job_list
WHERE empno = v_aux_empno;
END LOOP;
END IF;
END;
/