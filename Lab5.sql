----------------------
/* ITI DATABASE */
---------------------

/*1*/

/* 	Retrieve number of students     */

SELECT COUNT(*) 
FROM STUDENT 
WHERE St_Age IS NOT NULL


-----------------------------
/*2*/

/*  2.	Get all instructors Names without repetition  */


SELECT DISTINCT Ins_Name
FROM Instructor


-----------------------------

/*3*/
/*  3.	Display student with the following Format (use isNull function)  */


SELECT St_Id AS[ID], ISNULL(St_Fname+St_Lname,' ' ) AS[FULLNAME], D.Dept_Name AS[Department Name]
FROM Student INNER JOIN Department D
ON D.Dept_Id =Student.Dept_Id


-----------------------------

/*4*/
/*  4.	Display instructor Name and Department Name   */


SELECT I.Ins_Name , D.Dept_Name AS[Department Name]
FROM Instructor I LEFT JOIN Department D
ON D.Dept_Id =I.Dept_Id


-----------------------------


/*5*/
/*   5.	Display student full name and the name of the course he is taking  */


SELECT S.St_Fname+S.St_Lname AS[FullName] ,C.Crs_Name
FROM Student S ,Stud_Course STC, Course C
WHERE S.St_Id=STC.St_Id AND STC.Crs_Id=C.Crs_Id AND STC.Grade IS NOT NULL


-----------------------------



/*6*/

/* 6.	Display number of courses for each topic name   */

SELECT COUNT(*) AS [NUMBER OF COURSES] ,T.Top_Name
FROM Topic T, Course C 
WHERE T.Top_Id=C.Top_Id
GROUP BY Top_Name


-----------------------------

/*7*/
/*  7.	Display max and min salary for instructors  */


SELECT MAX(I.Salary) AS MIN ,MIN(I.SALARY) AS MAX 
FROM Instructor I 


-----------------------------

/*8*/
/*  8.	Display instructors who have salaries less than the average salary of all instructors.  */


SELECT I.Ins_Name
FROM Instructor I
WHERE SALARY < (SELECT AVG(SALARY) FROM Instructor)


-----------------------------



/*9*/
/*  9.	Display the Department name that contains the instructor who receives the minimum salary.  */

SELECT D.Dept_Name, I.Ins_Name
FROM Department D INNER JOIN Instructor I 
ON  D.Dept_Id=I.Dept_Id 
WHERE I.Salary = (SELECT MIN(Salary) FROM Instructor)


-----------------------------



/*10*/

/*   Select max two salaries in instructor table */

SELECT TOP 2 SALARY
FROM Instructor
ORDER BY SALARY DESC


-----------------------------



/*11*/
/* Select instructor name and his salary but if there is no salary display instructor bonus keyword. “use coalesce Function”  */

SELECT I.Ins_Name , COALESCE(CONVERT(VARCHAR,I.Salary),'Bouns')
FROM  Instructor I 


-----------------------------



/*12*/

/*  12.	Select Average Salary for instructors   */

SELECT AVG(SALARY)
FROM Instructor


-----------------------------



/*13*/
/*  Select Student first name and the data of his supervisor  */


SELECT X.St_Fname , Y.* 
FROM Student X , Student Y
WHERE X.St_super=Y.St_Id


-----------------------------



/*14*/
/*  14.	Write a query to select the highest two salaries   */

SELECT Salary ,Dept_Id FROM (
SELECT Salary ,Dept_Id,ROW_NUMBER() OVER(PARTITION BY Dept_id  ORDER BY SALARY DESC) AS RN
FROM Instructor) AS NEWTABLE
WHERE RN<=2 AND Salary IS NOT NULL


-----------------------------



/*15*/
/* random  student from each department.  “using one of Ranking Functions”   */

SELECT * FROM (
SELECT *,ROW_NUMBER() OVER(PARTITION BY Dept_id  ORDER BY NEWID()) AS RN
FROM STUDENT) AS NEWTABLE
WHERE RN=1 AND Dept_Id IS NOT NULL



SELECT TOP(1) * 
FROM Student
ORDER BY NEWID()
