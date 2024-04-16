
/* 1  creating tables programticallly*/


sp_addtype loc,'nchar(2)'

create default dloc as 'NY'
create rule r1 as @loc in ('NY','DS','KW')

sp_bindefault dloc,loc
sp_bindrule r1,loc
sp_addtype loc,'nchar(2)'



CREATE TABLE Department (
	DeptNo varchar(10) primary key,
	DeptName varchar(30),
	Location loc
	)

Insert  Into Department values ('d2','Accounting','DS')
Insert  Into Department values ('d3','Marketing','KW')


---------------------------------



CREATE TABLE Employee (
	EmpNO int primary key,
	EmpFname varchar(30) NOT NULL,
	EmpLname varchar(30) NOT NULL ,
	DeptNo	 varchar(10),
	Salary	 int Unique

	constraint c1 foreign key(DeptNo) references Department(DeptNo)

	)

Create Rule r2 as @sal <6000

sp_bindrule r2,'Employee.Salary'

Insert  Into Employee values ('25348','Mathew','Smith','d3' ,2500 )
Insert  Into Employee values ('10102','Ann','Jones','d3' ,3000)
Insert  Into Employee values ('18316','John','Barrimore','d1' ,2400 )


	alter table works_on  ADD foreign key(EmpNO) references Employee(EmpNo)
	alter table works_on  ADD foreign key(ProjectNo) references Project(ProjectNo)

	------------
CREATE TABLE Project (
	ProjectNo varchar(10) primary key,
	ProjectName varchar(30) NOT NULL,
	Budget int  
	)
	-----------------

	CREATE TABLE Works_on (
	EmpNo int  ,
	ProjectNo varchar(10),
	Job Varchar(30)  ,
	Enter_Date Date Not Null,

	constraint c5 primary key(EmpNo,ProjectNo),
	constraint c3 foreign key(EmpNO) references Employee(EmpNo),
	constraint c4 foreign key(ProjectNo) references Project(ProjectNo)
	)

	INsert into Project values('p1','Apollo',120000)
	INSERT INTO PROJECT VALUES('P2' , 'Gemini',95000  )
	INSERT INTO PROJECT VALUES('P3' , 'Mercury',185600  )


	INSERT INTO Works_on Values(10102,'p1','Analyst','1/10/2006')
	INSERT INTO Works_on Values(10102,'p3','Manager','1/10/2012')



--------------------

/*TestingIntegrity*/

Insert into Works_on (EmpNo)
values(11111)   ----> error because parent not fonud

UPDATE Works_on Set EmpNo =11111
 Where EmpNo=10102   ---> CANN'T UPDATE BECAuES THERE IS ANOTHER EMPNO WITH THE SAME NUM 

 UPDATE Employee Set EmpNo =22222
 Where EmpNo=10102   -----> cann't update because foreign in another table

 DELETE HumanResource.Employee WHERE Employee.EmpNO=10102  --> foreign on another table

 --------------

 /*Table modfication*/

 ALTER TABLE EMPLOYEE ADD  TelephoneNmber int 

 ALTER TABLE EMPLOYEE DROP Column TelephoneNmber
 ----------------------
 
 /*2    schema and transfer the following tables */
 
 Create Schema Company 
 Alter schema Company transfer Department

  Create Schema HumanResource 
 Alter schema HumanResource transfer Employee


 /*3 display the constraints for the Employee table			*/

 sp_helpconstraint 'HumanResource.Employee'



 /*4   Synonym for table Employee */ 

 CREATE Synonym Emp 
 for SD.HumanResource.Employee

 Select * From Employee  ------> ERROR Because it's on a diff schema

 SELECT * FROM [HumanResource].Employee ---> Runs normally

 SELECT *FROM Emp   ----> RUNS normally
 
 SELECT * FROM HumanResource.EMP  --- Error becase  emp is a synonym not a table on the schema 
 


 /*5   Increase the budget of the project  by 10%  **/


 UPDATE Company.Project Set Budget = Budget+0.1*Budget
 WHERE ProjectNo IN ( SELECT ProjectNo FROM Works_on WHERE EmpNo=10102 )



 /*6  	Change the name of the department for which the employee named James works */ 


 UPDATE Company.Department SET DeptName='Sales'
 WHERE Company.Department.DeptNo = (SELECT DeptNo from HumanResource.Employee Where Employee.EmpFname='James')


 /*7  7.	Change the enter date for the projects   */

 UPDATE Works_on SET Enter_Date = '12/12/2007'
 WHERE ProjectNo='p1' AND EmpNo = (SELECT EmpNO 
 FROM Company.Department , HumanResource.Employee
 WHERE Department.DeptNo=Employee.DeptNo AND Department.DeptName='Sales')
 

 /*8  8.	Delete the information in the works_on  */ 

DELETE Works_on WHERE EmpNo in (SELECT EmpNO 
 FROM Company.Department , HumanResource.Employee
 WHERE Department.DeptNo=Employee.DeptNo AND Department.Location='KW' )



 /*9   Create Login  */

 use iti
 create schema Allowed

 alter schema allowed transfer student
  alter schema allowed transfer course


  SELECT * FROM ALLOWED.Course
 DELETE FROM Allowed.Student
 WHERE St_Id='1'
