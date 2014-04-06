/*
Rezolvati urmatoarele exercitii 
– preluate din tutorialul Oracle-5: 
*/

--1. Write a query to display the employee name and hire date for all employees in the same department as Blake. Exclude Blake. 

SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO =
	(	
		SELECT DEPTNO 
		FROM EMP
		WHERE UPPER(ENAME) LIKE '%BLAKE%'
	)
	AND UPPER(ENAME) NOT LIKE '%BLAKE%'
;


--2. Create a query to display the employee number and name for all employees who earn more than the average salary. Sort the results in descending order of salary. 


SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL >
	(
		SELECT AVG(SAL)
		FROM EMP
	)
ORDER BY SAL DESC;

--3. Write a query that will display the employee number and name for all employees who work in a department with any employee whose name contains a T.

SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN
	(
		SELECT DEPTNO
		FROM EMP
		WHERE UPPER(ENAME) LIKE '%T%'
	)
;

--4. Display the employee name, department number, and job title for all employees whose department location is Dallas. 

SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO = 
	(
		SELECT DEPTNO
		FROM DEPT 
		WHERE UPPER(LOC) LIKE '%DALLAS%'
	)
;

--5. Display the employee name and salary of all employees who report to King. 

SELECT ENAME, SAL
FROM EMP 
WHERE NVL(MGR,0) = 
	(
		SELECT EMPNO
		FROM EMP
		WHERE UPPER(ENAME) LIKE '%KING%'
	)
;

--6. Display the department number, name, and job for all employees in the Sales department. 

SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE JOB IN
	(
		SELECT JOB
		FROM EMP
		WHERE UPPER(JOB) LIKE '%SALES%'
	)
;

--7. Display the employee number, name, and salary for all employees who earn more than the average salary and who work in a department with any employee with a T in their name. 

SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL >
	(
		SELECT AVG(SAL)
		FROM EMP 
		WHERE DEPTNO IN
			(
				SELECT DEPTNO
				FROM EMP
				WHERE UPPER(ENAME) LIKE '%T%'
			)
	)
;
--8. Write a query to display the name, department number, and salary of any employee whose department number and salary matches both the department number and salary of any employee who earns a commission. 

SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE (DEPTNO, SAL) IN
	(
		SELECT DEPTNO,SAL
		FROM EMP
		WHERE NVL(COMM,0) > 0
	)
;
--9. Display the name, department name, and salary of any employee whose salary and commission matches both the salary and commission of any employee located in Dallas. 

SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E, DEPT D
WHERE (E.SAL, NVL(E.COMM,0)) IN
	(
		SELECT SAL,NVL(COMM,0)
		FROM EMP 
		WHERE DEPTNO IN
			(
				SELECT DEPTNO
				FROM DEPT 
				WHERE UPPER(LOC) LIKE '%DALLAS%'
			)
	)
	AND E.DEPTNO=D.DEPTNO
;

--10. Create a query to display the name, hire date, and salary for all employees who have both the same salary and commission as Scott. 

SELECT ENAME, HIREDATE, SAL
FROM EMP
WHERE (SAL, NVL(COMM,0)) IN
	(
		SELECT SAL,NVL(COMM,0)
		FROM EMP
		WHERE UPPER(ENAME) LIKE '%SCOTT%'
	)
	AND UPPER(ENAME) NOT LIKE '%SCOTT%'
;
--11. Create a query to display the employees that earn a salary that is higher than the salary of any of the CLERKS. Sort the results on salary from highest to lowest. 

SELECT ENAME
FROM EMP
WHERE SAL > ANY
	(
		SELECT SAL
		FROM EMP
		WHERE UPPER(JOB) LIKE '%CLERK%'
	)
ORDER BY SAL DESC
;


--– preluate din tutorialul Oracle-6: 

--1. Write a query to display the top three earners in the EMP table. Display their names and salaries. 

SELECT ENAME, SAL
FROM 
	(
		SELECT ENAME, SAL
		FROM EMP
		ORDER BY SAL DESC
	)
WHERE ROWNUM<4;

--2. Find all employees who are not a supervisor.  
--a. Do this using the EXISTS operator first. 

SELECT E.ENAME
FROM EMP E
WHERE NOT EXISTS 
	(
		SELECT D.MGR
		FROM EMP D
		WHERE D.MGR=E.EMPNO
	)
;
--b. Can this be done using the IN operator? Why, or why not? 

SELECT ENAME
FROM EMP 
WHERE EMPNO NOT IN
	(
		SELECT MGR
		FROM EMP 
		WHERE MGR IS NOT NULL
	)
;
--3. Write a query to find all employees who make more than the average salary in their department. Display employee number, salary, department number, and the average salary for the department. Sort by average salary. 

SELECT E.EMPNO, E.SAL, E.DEPTNO, A.MEDIA
FROM EMP E, 
	(
		SELECT AVG(SAL) AS "MEDIA" ,DEPTNO
		FROM EMP
		GROUP BY DEPTNO
	) A --<- ALIAS
WHERE E.DEPTNO = A.DEPTNO AND E.SAL>A.MEDIA
ORDER BY A.MEDIA DESC
;
--4. Write a query to display employees who earn less than half the average salary in their department. 



--5. Write a query to display employees who have one or more co-workers in their department with later hiredates but higher salaries. 
