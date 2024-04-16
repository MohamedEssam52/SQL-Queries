/* 1  stored procedure to show the number of students per department */

ALTER procedure num_Students
as
 SELECT  D.Dept_Name, COUNT(ST_ID) as numofstudents 
 FROM Student S ,Department D
 where S.Dept_Id=D.Dept_Id
 GROUP BY  Dept_Name

 execute iti.dbo.num_Students

 /*2 stored procedure that will check for the number of total of employees in the project P1  if they are more than 3...   */

create PROC CheckForEmployess 
as
	DECLARE @number int 
	SELECT @number = COUNT(SSN)
	FROM Company_SD.dbo.Employee, Company_SD.dbo.Works_for
	where Employee.SSN=Works_for.ESSn AND Works_for.Pno='P1'

	if @number >=3
		SELECT 'The number of employees in the project P1 is 3 or more' 
	ELSE IF @NUMBER<3
		SELECT 'The following employees work for the project P1' ,Employee.Fname+Employee.Lname 
		FROM Company_SD.dbo.Employee,Company_SD.dbo.Works_for
		where Employee.SSN=Works_for.ESSn AND Works_for.Pno=100

	
execute Company_SD.dbo.CheckForEmployess


/*3  procedure that will be used in case there is an old employee has left the project and a new one become instead of him*/

CREATE PROC Old_New_Employee @oldssn int ,@newssn int ,@Pno int

as
	update Company_SD.DBO.Works_for
	SET ESSN=@newssn
	WHERE ESSn=@oldssn AND Pno=@Pno


execute Company_SD.dbo.Old_New_Employee 223344 , 112233, 200


/*4	add column budget in project table and insert any draft values in it then 
then Create an Audit table 
	*/

ALTER TABLE PROJECT ADD Budget int 

 create table Audit_Table_Emp (
	projectno int,
	username varchar(20),
	modifieddate date ,
	budget_Old int,
	budget_new int
)

create trigger t3
on project 
instead of update
as
	 if update(budget)
		begin
		declare @projectno int , @newbudg int , @oldbudg int 
		select @oldbudg=budget from deleted
		select @newbudg=budget from inserted
		select @projectno=pnumber from inserted
		insert into Audit_Table_emp
		values (@projectno,SUSER_NAME(),getdate(),@oldbudg,@newbudg)

		end



 /*5 Create a trigger to prevent anyone from inserting a new record in the Department table [ITI DB]*/
 
 CREATE TRIGGER t1
 on department 
 instead of insert 
 as
	select 'unable to insert '

	insert into Department(dept_id) 
	values(50000)


/*6   Create a trigger that prevents the insertion Process for Employee table in March	*/ 
	CREATE TRIGGER T5 
	ON EMPLOYEE
	instead of insert 
	as 
		IF MONTH(getdate()) != 3
		begin
		insert into Employee 
		select * from deleted
		end

	insert into Employee (ssn)
	values(50000)



/* 7 Create a trigger on student table after insert to add Row in Student Audit table */ 
	

create table student_audit_table(

server_user_name varchar(30),
date date ,
note varchar(100)
)


create TRIGGER Info_about_student
on student 
after insert 
as 
		begin
		declare @id int
		select @id=St_Id from inserted
		insert into student_audit_table
		values (SUSER_NAME(),getdate(),SUSER_NAME()+'inserted new row with key '+CAST(@id as varchar)+' in table student')

		end
  

insert into student (St_Id) 
values(16)



/*8	 Create a trigger that prevents the insertion Process for Employee table in March [Company DB].
	*/

	create TRIGGER Delete_from_student
on student 
instead of delete 
as 
		begin
		declare @id int
		select @id=St_Id from deleted
		insert into student_audit_table
		values (SUSER_NAME(),getdate(),SUSER_NAME()+' tried to delete row with key  '+CAST(@id as varchar)+' in table student')

		end
  

  delete Student where St_Id=15


	
