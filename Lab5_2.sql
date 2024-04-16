--------------------------------

/*ADVENTURE DATABASE*/

-------------------------------
/*1*/

/*  show SalesOrders that occurred within the period ‘7/28/2002’ and ‘7/29/2014’  */
SELECT SalesOrderID,ShipDate
FROM Sales.SalesOrderHeader 
WHERE ShipDate BETWEEN  '7-28-2002' AND '7-29-2014'



-----------------------------



/*2*/

/*  2.	Display only Products(Production schema) */

SELECT ProductID,Name ,StandardCost
FROM Production.Product
WHERE StandardCost<110


-----------------------------



/*3*/

/*  3.	Display ProductID, Name if its weight is unknown */



SELECT ProductID,Name
FROM Production.Product
WHERE WeiGHT IS NULL


-----------------------------



/*4*/

/*  Display all Products with a Silver, Black, or Red Color */


SELECT ProductID,Name,Color
FROM Production.Product
WHERE Color IN('Black','Silver','Red')


-----------------------------



/*5*/

/* Display any Product with a Name starting with the letter B  */


SELECT ProductID,Name
FROM Production.Product
WHERE Name like 'B%'


-----------------------------



/*6*/

/*  write a query that displays any Product description with underscore  */


UPDATE Production.ProductDescription
SET Description = 'Chromoly steel_High of defects'
WHERE ProductDescriptionID = 3

SELECT Description
FROM Production.ProductDescription
WHERE Description LIKE '%[_]%'



-----------------------------



/*7*/

/*  7.	Calculate sum of TotalDue  */


SELECT SUM(TotalDue)
FROM Sales.SalesOrderHeader
WHERE OrderDate BETWEEN '7-1-2001' AND '7/31/2014'


-----------------------------



/*8*/

/* 8.	 Display the Employees HireDate   */


SELECT DISTINCT HireDate
FROM HumanResources.Employee


-----------------------------



/*9*/

/* Calculate the average of the unique ListPrices   */


SELECT SUM (DISTINCT ListPrice)
FROM Production.Product


-----------------------------



/*10*/

/* Display the Product Name and its ListPrice within the values of 100 and 120  */


SELECT Name, 'The' +[Name]+' is only! '+CONVERT(VARCHAR,[Listprice])
FROM Production.Product
WHERE ListPrice BETWEEN 100 AND 120
ORDER BY ListPrice


-----------------------------



/*11*/

/* Transfer the rowguid ,Name, SalesPersonID  */


SELECT rowguid,Name,SalesPersonID ,Demographics INTO Store_Archive
FROM Sales.Store

SELECT rowguid,Name,SalesPersonID ,Demographics INTO Trying_The_Query
FROM Sales.Store
WHERE 2=3


-----------------------------



/*12*/

/* retrieve the today’s date   */

select convert(varchar(20),getdate(),103)
UNION ALL
select convert(varchar(20),getdate(),107)
UNION ALL
select format(getdate(),'dd-MM-yyyy')
UNION ALL
select format(getdate(),'dddd MMMM yyyy')
UNION ALL
select format(getdate(),'ddd MMM yy')




