
/*
1. Write a query to display the current date. Label the column Date.
*/
SELECT SYSDATE AS "Date" FROM DUAL;

/*
2. Display the employee’s name, hire date, and salary  review date, which is the first Monday 
 after six months of service. Label the column REVIEW. Format the dates to appear in the 
 format similar to "Sunday, the Seventh of September, 1981."
*/

SELECT ENAME, HIREDATE, SAL, TO_CHAR(NEXT_DAY((ADD_MONTHS(HIREDATE,'6')),'MONDAY'),'Day", the "Ddspth" of "Month", "YYYY"."') AS "REVIEW" FROM EMP;

/*
3. For each employee display the employee name and calculate the number of months between 
 today and the date the employee was hired. Label the column MONTHS_WORKED. Order 
 your results by the number of months employed. Round the number of months up to the  
 closest whole number.
*/

SELECT ENAME, ROUND(MONTHS_BETWEEN(HIREDATE,CURRENT_DATE)) AS "MONTHS_WORKED" FROM EMP ORDER BY MONTHS_WORKED ;

/*
4. Write a query that produces the following for each  employee: 
 <employee name> earns <salary> monthly but wants <3 times salary>. Label the column 
 Dream Salaries.
*/

SELECT ENAME||' earns '||SAL||' monthly but wants '||SAL*3 AS "Dream salaries." FROM EMP;

/*
5. Create a query to display name and salary for all employees. Format the salary to be 15 
 characters long, left-padded with $. Label the column SALARY. 
*/

SELECT ENAME, LPAD(SAL,15,'$') FROM EMP ;   

/*
6. Write a query that will display the employee’s name with the first letter capitalized and all 
 other letters lowercase and the length of their name, for all employees whose name starts with 
 J, A, or M. Give each column an appropriate label.
*/

SELECT INITCAP(ENAME), LENGTH(TRIM(ENAME)) AS "Length" FROM EMP WHERE (SUBSTR(ENAME,1,1) IN ('J','A','M')) ;
--																WHERE ENAME LIKE "J%" OR ENAME LIKE "A%" OR ENAME LIKE "M%")

/*
7. Display the name, hire date, and day of the week on which the employee started. Label 
 the column DAY. Order the results by the day of the week starting with Monday.
*/

SELECT ENAME, HIREDATE, TO_CHAR((HIREDAY,'fmDAY')) AS "DAY" FROM EMP ORDER BY HIREDAY - NEXTDAY(HIREDATE,'MONDAY');
--																		      DECODE (TO_CHAR(HIREDATE),'MONDAY','1','TUSDAY','2','WEDNESDAY','3','THURSDAY','4','FRIDAY','5','SATURDAY','6','SUNDAY','7')		

/*
8. Create a query that will display the employee name and commission amount. If the employee 
 does not earn commission, put “No Commission”. Label the column COMM.
*/

SELECT ENAME, NVL(TO_CHAR(COMM),'"No Commission"') AS "COMM" FROM EMP; 
--===============================SETUL 2================================
/*
1. Afisati numele angajatilor (ename) si numele oraselor în care lucreaza interogând doar tabela 
EMP.
*/

SELECT ENAME, DECODE(DEPTNO,10,'NEW YORK',20,'DALAS',30,'CHICAGO',40,'BOSTON') FROM EMP;

/*
2. Afisati pentru angajatii care nu câstiga comision numele (ename), numarul de zile lucrate si 
jobul.
*/

SELECT ENAME, (SYSDATE-HIREDATE), JOB FROM EMP WHERE COMM IS NULL OR COMM=0;

/*
3. Afisati numele tuturor angajatilor înlocuind aparitia literei i cu y si aparitia literei y cu i.
*/

SELECT TRANSLATE(ENAME,'IY','YI') FROM EMP;

/*
4. Daca salariul angajatilor creste la implinirea a 32 ani vechime cu 10%, afisati numele fiecarui 
angajat, data la care are loc marirea salariului, numarul de luni de asteptare pâna la marire si 
valoarea noului salariu.
*/

SELECT ENAME,ADD_MONTHS(HIREDATE,12*32) AS "ZI MARIRE", MONTHS_BETWEEN(ADD_MONTHS(HIREDATE,12*32),SYSDATE) AS "LUNI DE ASTEPTARE", SAL+SAL*0.1 AS "SALARIU NOU" FROM EMP;

/*
5. Presupunând ca salariul se mareste cu fiecare luna  ce trece de la data angajarii cu 0.01%, iar 
salariul stocat în baza de date e cel primit la data angajarii, care a fost salariul fiecarui angajat pe 
data de 1 ianuarie anul 2000 (afisati numele angajatului si valoarea salariului) ? 
*/

SELECT ENAME, MONTHS_BETWEEN(TO_DATE('01-01-2000',HIREDATE)*0.0001*SAL+SAL FROM EMP;

/*
6. Consideram ca salariul se mareste cu fiecare an de vechime cu 0.1%, pentru cei ce nu câstiga 
comision si cu 0.05% pe an pentru cei ce beneficiaza de comision. Cât câstiga fiecare angajat în 
aceasta luna? Afisati numele capitalizat si salariul cu 2 zecimale.
*/

SELECT 