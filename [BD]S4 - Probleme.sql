/*
1. Write a query to display the name, department number, and department name for all employees.
*/

SELECT E.ENAME, E.DEPTNO, D.DNAME 
FROM EMP E, DEPT D 
WHERE E.DEPTNO=D.DEPTNO;

/*
2. Write a query to display the employee name, department name, and location of all 
 employees who earn a commission. 
*/

SELECT E.ENAME, D.DNAME, D.LOC 
FROM EMP E, DEPT D 
WHERE E.DEPTNO=D.DEPTNO AND (E.COMM IS NOT NULL OR E.COMM!=0);

/*
3. Display the employee name and department name for all employees who have an A in their name.
*/

SELECT E.ENAME, D.DNAME 
FROM EMP E, DEPT D
WHERE UPPER(E.ENAME) LIKE '%A%' AND E.DEPTNO=D.DEPTNO;

/*
4. Write a query to display the name, job, department  number, and department name for all employees who work in DALLAS. 
*/

SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND UPPER(TRIM(D.LOC))='DALLAS';

/*
5. Display the employee name and employee number along with their manager’s name and manager number. Label the columns Employee, Emp#, Manager, and Mgr#, respectively. 
*/

SELECT E.ENAME AS "EMPLOYEE", E.EMPNO AS "EMP#", M.ENAME AS "MANAGER", E.MGR AS "MGR#"
FROM EMP E, EMP M
WHERE E.MGR=M.EMPNO ;

/*
6. Modify the statement above to display all employees including King, who has no manager. 
*/

SELECT E.ENAME AS "EMPLOYEE", E.EMPNO AS "EMP#", M.ENAME AS "MANAGER", E.MGR AS "MGR#"
FROM EMP E, EMP M
WHERE E.MGR=M.EMPNO(+);

/*
7. Create a query that will display the employee name, department number, and all the employees that work in the same department as (are colleagues of) a given employee. Give each column an appropriate label.
*/

SELECT E.ENAME AS "NAME", E.DEPTNO AS "DEPT. NR.", C.ENAME AS "COLLEAGUES"
FROM EMP E, EMP C
WHERE E.DEPTNO=C.DEPTNO AND NOT E.ENAME=C.ENAME;

/*
8. Show the structure of the SALGRADE table. Create a  query that will display the name, job, department name, salary, and grade for all employees.
*/

DESCRIBE SALGRADE;
SELECT E.ENAME, E.JOB, D.DNAME, E.SAL, S.GRADE 
FROM EMP E, SALGRADE S, DEPT D
WHERE E.SAL<S.HISAL AND E.SAL>S.LOSAL AND E.DEPTNO=D.DEPTNO;

/*
9. Create a query to display the name and hire date of any employee hired after employee Blake.
*/

SELECT E.ENAME, E.HIREDATE 
FROM EMP E, EMP B
WHERE B.ENAME='BLAKE' AND E.HIREDATE>B.HIREDATE;

/*
10. Display all employees’ names and hire dates along with their manager’s name and hire date for all employees who were hired before their managers. Label the columns Employee, Emp Hiredate, Manager, and Mgr Hiredate, respectively.
*/

SELECT E.ENAME AS "EMPLOYEE", E.HIREDATE AS "EMP HIREDATE", M.ENAME AS "MANAGER", M.HIREDATE AS "MGR HIREDATE"
FROM EMP E, EMP M
WHERE E.MGR=M.EMPNO AND E.HIREDATE<M.HIREDATE;

/*
11. Create a query that displays the employees name and the amount of the salaries of the employees are indicated through asterisks (*). Each asterisk signifies a hundred dollars. Sort the data in descending order of salary. Label the column EMPLOYEE_AND_THEIR_SALARIES.
 */

SELECT ENAME, LPAD("_",(SAL/100)+1,"*")
FROM EMP
ORDER BY SAL DESC; 

/*
1. Pentru interogarile de la setul 1 exercitiile 1, 2, 5, 7 formulati expresiile echivalente în algebra relationala.
*/

--Proiectie - SELECT - pi mare -> argument = from
--							   -> indici tabela;
--Selectie  - WHERE - sigma
-- notatii curs

--1.
--PI ENAME,DEPTNO,DNAME (EMP*DEPT);

--2.
--


/*
2. Formulati în algebra relationala interogarea care extrage numele angajatului care are cel mai 
mare salariu. Transformati apoi expresia în echivalentul sau SQL.
*/
