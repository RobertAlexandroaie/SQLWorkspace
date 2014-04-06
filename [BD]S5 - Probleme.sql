/*
Rezolvati urmatoarele exercitii preluate din tutorialul Oracle-4: 



1. Display the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum, and Average, respectively.  Round your results to the decimal position.
*/

SELECT ROUND(MAX(SAL),1) AS "Maximum", ROUND(MIN(SAL),1) AS "Minimum", ROUND(SUM(SAL),1) AS "Sum", ROUND(AVG(NVL(SAL,0)),1) AS "Average"
FROM EMP;

/*
2. Display the minimum, maximum, sum, and average salary for each job type. 
*/

SELECT JOB, MIN(SAL) "MIN", MAX(SAL) "MAX", SUM(SAL) "SUM", AVG(SAL) "AVG"
FROM EMP
GROUP BY JOB;

/*
3. Write a query to display the number of people with the same job.
*/

SELECT COUNT(JOB),JOB
--     COUNT(*)
FROM EMP
GROUP BY JOB;

/*
4. Determine the number of managers without listing them. Label the column Number of Managers. 
*/

SELECT COUNT(DISTINCT MGR) "MANAGERS"
FROM EMP;

 /*
 5. Write a query that will display the difference between the highest and lowest salaries. Label the column DIFFERENCE.
*/

SELECT (MAX(SAL)-MIN(SAL)) "DIFFERENCE"
FROM EMP;

 /*
 6. Display the manager number and the salary of the lowest paid employee for that manager. Exclude anyone where the manager id is not known. Exclude any groups where the minimum salary is less than $1000. Sort the output in descending order of salary. 
*/

SELECT M.EMPNO, MIN(E.SAL)
FROM EMP "M", EMP "E"
WHERE E.MGR(+)=M.EMPNO
GROUP BY M.EMPNO
HAVING MIN(E.SAL)>=1000
ORDER BY MIN(E.SAL) DESC;

 /*
 7. Write a query to display the department name, location name, number of employees, and the average salary for all employees in that department. Label the columns dname, loc, Number of People, and Salary, respectively. 
*/

SELECT D.DNAME "DNAME", D.LOC "LOC", COUNT(E.ENAME) "NUMBER OF PEOPLE", AVG(E.SAL) "SALARY"
FROM EMP E, DEPT D
WHERE D.DEPTNO=E.DEPTNO
GROUP BY D.DNAME, D.LOC;
 
 /*
 8. Create a query that will display the total number of employees and of that total  the number who were hired in 1980, 1981, 1982, and 1983, label the columns appropriately. 
*/

SELECT COUNT(EMPNO) "TOTAL", 
	   COUNT(DECODE(TO_CHAR(HIREDATE,'YYYY'),'1980',HIREDATE)) "YEAR 1980",
	   COUNT(DECODE(TO_CHAR(HIREDATE,'YYYY'),'1981',HIREDATE)) "YEAR 1981",
	   COUNT(DECODE(TO_CHAR(HIREDATE,'YYYY'),'1982',HIREDATE)) "YEAR 1982",
	   COUNT(DECODE(TO_CHAR(HIREDATE,'YYYY'),'1983',HIREDATE)) "YEAR 1983"
FROM EMP;



 /*
 9. Create a matrix query to display the job, the salary for that job based upon department number and the total salary for that job for all departments, giving each column an appropriate label.
*/

SELECT 
	SUM(DECODE(DEPTNO,10,SAL)) "D10",
	SUM(DECODE(DEPTNO,20,SAL)) "D20",
	SUM(DECODE(DEPTNO,30,SAL)) "D30",
	SUM(SAL)
FROM EMP
GROUP BY JOB;