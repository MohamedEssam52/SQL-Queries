USE Company_SD
/*1*/
SELECT Dnum,Dname ,MGRSSN , Fname+Lname AS Name
FROM Departments , Employee
WhERE MGRSSN=SSN
/*2*/
------
SELECT Dname ,Pname
FROM Departments D , Project P
WhERE D.Dnum=P.Dnum

/*3*/
-------
SELECT D.*, E.*
FROM Dependent D, Employee E
WHERE SSN=ESSN

/*4*/
-------
SELECT Pnumber,Pname,Plocation ,City
FROM Project
WHERE City='CAIRO' OR City='Alex'  

/*5*/
-----------
SELECT P.* 
FROM Project P
WHERE Pname Like 'a%'

/*6*/
------------
SELECT Fname+Lname
FROM Departments D , Employee E
WHERE D.Dnum = E.Dno AND( Dnum=30) AND (Salary>1000 AND Salary<2000)
----
/*7*/
--------
SELECT E.Fname+E.Lname, P.Pname
FROM Departments D ,Employee E , Works_for W , Project P
WHERE (D.Dnum = E.Dno) AND(E.SSN=W.ESSn) AND(W.Pno=P.Pnumber)
AND (D.Dnum=10) AND P.Pname='Al Rabwah'
/*8*/
-------
SELECT Y.Fname+Y.Lname 
FROM Employee X , Employee Y 
WHERE X.Superssn=Y.SSN AND X.Fname='Kamel'

/*9*/
------
SELECT E.Fname+E.Lname , P.Pname
FROM Employee E ,Works_for W,Project P
WHERE E.SSN=W.ESSn AND W.Pno=P.Pnumber 
ORDER BY Pname

/*10*/
-------
SELECT P.Pname,D.Dname,E.Lname,E.Address, E.Lname
FROM Project P , Departments D , Employee E
WHERE P.Dnum=D.Dnum AND D.MGRSSN=E.SSN AND P.City='Cairo'

/*11*/
--------
SELECT E.*
FROM Departments D ,Employee E
WHERE D.MGRSSN=E.SSN

/*12*/
-----------
SELECT E.*
FROM Employee E LEFT JOIN Dependent D
ON E.SSN=D.ESSN

/*13*/
---------
INSERT INTO Employee Values('Mohamed','Essam',102672,27/11/1999,'sidibishr','M',3000,112233,30 ) 

/*14*/
-------
INSERT INTO Employee(Fname,Lname,Dno,SSN)
Values('Seif','Amr',30,102660 ) 

/*15*/
-------
UPDATE Employee SET Salary=Salary+Salary*0.2
WHERE Employee.SSN=102672

