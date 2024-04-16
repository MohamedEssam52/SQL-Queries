/*1 A*/

SELECT D.Dependent_name,D.Sex 
FROM Dependent D , Employee E
WHERE (D.ESSN =E.SSN) AND (D.Sex='M') AND (E.Sex='m')
union
SELECT D.Dependent_name,D.Sex 
FROM Dependent D , Employee E
WHERE (D.ESSN =E.SSN) AND (D.Sex='f') AND (E.Sex='f')

/*2*/ 

SELECT P.Pname ,Sum(W.Hours) 
FROM Project P , Works_for W
WHERE P.Pnumber=W.Pno
GROUP BY P.Pname

/*3*/

SELECT D.Dname ,MIN(E.SSN)
FROM Employee E , Departments D
WHERE E.Dno = D.Dnum 
GROUP BY D.Dname


/*4*/

SELECT D.Dname,MAX(E.Salary) AS [MAX SALARY],MIN(E.Salary) AS [MIN SALARY],AVG(E.Salary) AS [AVG SALARY]
FROM Employee E , Departments D
WHERE E.Dno = D.Dnum 
Group BY D.Dname
/*5*/

SELECT DISTINCT E.Fname+ E.Lname
FROM  Departments D , Employee E
WHERE D.MGRSSN=E.SSN AND D.MGRSSN NOT IN (SELECT ESSN FROM Dependent)

/*6*/
SELECT D.Dnum,D.Dname,COUNT(E.SSN) AS[NUM OF EMPLOYEES]
FROM Departments D ,Employee E
WHERE D.Dnum=E.Dno
GROUP BY D.Dnum,D.Dname
HAVING AVG(E.SALARY)< SUM(E.SALARY)

/*7*/

SELECT E.FNAME+E.LNAME [NAME] , P.Pname
FROM Employee E , Project P , Works_for W
WHERE E.SSN=W.ESSn  AND W.Pno=P.Pnumber
ORDER BY P.Dnum , E.Fname ,E.Lname


/*8*/
SELECT max(salary)
from Employee
union all 
SELECT MAX(SALARY)
FROM Employee
WHERE Salary!= (SELECT MAX(SALARY) FROM Employee)


/*9*/
SELECT E.Fname+E.Lname FROM Employee E 
intersect
SELECT Dependent_name
FROM Dependent D

/*10*/

SELECT SSN
FROM Employee  
WHERE EXISTS (SELECT ESSN FROM Dependent WHERE Employee.SSN=Dependent.ESSN) 


/*11*/

INSERT INTO Departments VALUES('DEPT IT',100,112233,'1-11-2006')

/*12*/
UPDATE Departments SET MGRSSN=968574
WHERE Dnum=100

UPDATE Departments SET MGRSSN=102672
WHERE Dnum=20

UPDATE Employee SET Superssn=102672
WHERE SSN=102660 

/*13*/
UPDATE Employee SET SUPERSSN=102672
WHERE Superssn=223344

UPDATE Departments SET MGRSSN= 102672 
WHERE MGRSSN=223344

DELETE FROM Dependent WHERE ESSN=223344

DELETE FROM Works_for WHERE ESSn=223344

DELETE FROM Employee WHERE SSN= 223344

/*14*/

UPDATE Employee SET Salary=Salary+0.3*Salary
WHERE Employee.SSN IN ( SELECT E.SSN FROM Employee E , Works_for W , Project	P
	WHERE E.SSN=W.ESSn AND W.Pno=P.Pnumber AND P.Pname='Al Rabwah')


