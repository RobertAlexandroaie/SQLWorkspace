/*
1. Afisati prietenii lui Gabriel. 
R: Alexis, Andrew, Cassandra, Jessica, Jordan
*/

SELECT E.NUME 
FROM ELEV E, PRIETEN P
WHERE (P.ID1 IN	(
					SELECT ID
					FROM ELEV
					WHERE UPPER(NUME) LIKE '%GABRIEL%'
				) AND E.ID=P.ID2) 
/*
				OR 
		(P.ID2 IN (
					SELECT ID
					FROM ELEV
					WHERE UPPER(NUME) LIKE '%GABRIEL%'
				) AND E.ID=P.ID1)
*/
ORDER BY NUME
;


/* 
2. Pentru fiecare elev care place pe un altul cu 2 sau mai mult de 2 clase mai putin decat a sa, 
afisati numele si clasa sa, si numele si clasa elevului pe care il place. 
R: 
*/
  
  SELECT E.NUME, E.CLASA, EP.NUME, EP.CLASA
  FROM ELEV E, ELEV EP,PLACE P	
  WHERE E.ID=P.ID1 AND P.ID2=EP.ID AND EP.CLASA<E.CLASA-1; 

  
/*  
3. Pentru fiecare pereche de elevi care se plac reciproc, returnati numele si clasa ambilor.Fiecare 
pereche s apara o singura data. 
R:
Cassandra 9 Gabriel 9
Jessica 11 Kyle 12
John 12 Haley 10
*/

SELECT E1.NUME, E1.CLASA, E2.NUME, E2.CLASA
FROM ELEV E1, ELEV E2
WHERE	(E1.ID,E2.ID) IN (SELECT ID1, ID2 FROM PLACE)
		AND (E2.ID,E1.ID) IN (SELECT ID1, ID2 FROM PLACE)
		AND E1.ID<E2.ID
ORDER BY E1.NUME;

/*
4. Pentru fiecare situatie în care elevul A îl place pe B, dar elevul B îl place pe un alt elev C, 
returnati numele si clasa pentru A,B,C 
R: 
Andrew 10 Cassandra 9 Gabriel 9
Gabriel 11 Alexis 11 Kris 10
*/

SELECT E1.NUME, E1.CLASA, E2.NUME, E2.CLASA, E3.NUME, E3.CLASA
FROM ELEV E1, ELEV E2, ELEV E3
WHERE	(E1.ID,E2.ID) IN (SELECT ID1, ID2 FROM PLACE)
		AND (E2.ID,E1.ID) NOT IN (SELECT ID1, ID2 FROM PLACE)
		AND (E2.ID,E3.ID) IN (SELECT ID1, ID2 FROM PLACE)
ORDER BY E1.NUME;


/*
5. Gasiti toti elevii care nu apar în tabela Place (nu place si nu e placut) si returnati numele si clasa
lor. Sortati dupa clasa apoi dupa nume. 
R: 
Jordan 9
Tiffany 9
Logan 12
*/

SELECT NUME, CLASA
FROM ELEV
WHERE ID NOT IN (SELECT ID1 FROM PLACE)
		AND ID NOT IN (SELECT ID2 FROM PLACE)
ORDER BY CLASA,NUME
;

/*
Subinterogari 
6. Pentru fiecare situatie în care A îl place pe B dar B nu place pe nimeni, returnati numele si clasa 
lui A si B. 
R: 
John 12 Haley 10
Alexis 11 Kris 10
Brittany 10 Kris 10
Austin 11 Jordan 12
*/

SELECT E1.NUME, E1.CLASA, E2.NUME, E2.CLASA
FROM ELEV E1, ELEV E2
WHERE 
	(E1.ID,E2.ID) IN (SELECT ID1,ID2 FROM PLACE)
	AND	E2.ID NOT IN (SELECT ID1 FROM PLACE)
;

/*
7. Gasiti numele si clasa pentru elevii care au prieteni doar în clasa lor. Returnati rezultatul sortat 
dupa clasa apoi dupa nume. 
R: 
Jordan 9
Brittany 10
Haley 10
Kris 10
Gabriel 11
John 12
Logan 12
*/

SELECT E.NUME, E.CLASA
FROM ELEV E
WHERE E.ID NOT IN	(
						SELECT ID1 
						FROM PRIETEN 
						WHERE ID2 IN	(
											SELECT ID
											FROM ELEV
											WHERE CLASA<>E.CLASA
										)
					)
ORDER BY E.CLASA,E.NUME;

/*
8. Gasiti numele si clasa elevilor care au doar prieteni în alte clase. 
R: Austin 11 
9. Pentru fiecare elev A care îl place pe B iar cei doi nu sunt prieteni, gasiti daca au un prieten C în
comun. Pentru aceste situatii returnati numele si clasa elevilor (A,B,C). R: 
Andrew 10 Cassandra 9 Gabriel 9
Austin 11 Jordan 12 Andrew 10
Austin 11 Jordan 12 Kyle 12
Agregare 
10. Gasiti diferenta dintre numarul numarul de elevi din scoala ti numarul de nume diferite.  
R: 2 
11. Care este numrul mediu de prieteni pe student? 
R: 2.5 
12. Gasiti numarul de elevi care sunt prieteni cu Cassandra sau sunt prieteni ai prietenilor 
Cassandrei. Nu o numarati si pe Cassandra chiar daca tehnic este prietena cu prietenii 
Cassandrei. 
R: 7 
13. Gasiti elevii si clasa tuturor elevilor care sunt placuti de mai mult de un elev. 
R:
Cassandra 9
Kris 10
14. Gasiti numele si clasa studentului/ilor cu cel mai mare numar de prieteni. 
R:
Alexis 11
Andrew 10
Modificarea datelor 
Raspunsurile sunt obtinute în urma executiei tuturor comenzilor de modificare anterioare. 
Reîncarcati scriptul de creare pentru a reveni la starea initiala. 
15. Este sfârsitul anului scolar. Incrementati clasa tuturor elevilor cu o unitate. Pentru a verifica 
modificarea realizata, gasiti numele elevilor care au clasa > 12. 
R: Jordan, John, Kyle, Logan 
16. Eliminati elevii care au terminat liceul (clasa>12). Pentru a verifica modificarea determinati 
numarul de elevi care au ramas în tabela Elev. 
R: 12 17. Desi relatia de prietenie poate continua, ea nu poate fi modelata în tabelele noastre pentru elevi 
care nu mai sunt. Eliminati toate uplele din Prieten si toate uplele din Place care fac referire la 
elevi ce nu mai exista. Pentru verificare gasiti numele elevilor pe care îi place Austin sau care 
sunt prieteni cu Austin. 
R: Andrew 
18. Este vacanta. Drept rezultat cercul social al elevilor se extinde. Pentru toate cazurile în care A 
este prieten cu B si B este prieten cu C, adaugati relatia de prietenie între A si C. Nu duplicati 
prietenii existente si nu inserati prietenia unui elev cu el însusi. Pentru verificare, returnati 
numele pritenilor lui Jordan (din clasa a 10-a la momentul current). 
R: Tiffany, Gabriel, Alexis, Cassandra, Andrew
*/

