/*1	Create a cursor for Employee table that increases Employee salary by 10% if Salary <3000 and increases it by 20% if Salary >=3000	*/

declare c1 cursor
for select Salary from Employee
for update 
	
declare @salary int
open c1
fetch c1 into @salary
while @@FETCH_STATUS=0
	begin
		if @salary<3000
			begin
			update Employee set Salary+=Salary*0.1
			where current of c1
			end

		else if @salary>=3000
			begin
			update Employee set salary+=Salary*0.2
			where current of  c1
			end
	fetch c1 into @salary
	end
close c1
deallocate c1




/*2  2.	Display Department name with its manager name using cursor using iti */ 

declare c6 cursor
for select D.Dept_Name , I.Ins_Name  from Department D , Instructor as I 
	where D.Dept_Id=I.Dept_Id
for read only 

declare @Did nvarchar(50),@name varchar(20)
open c6
fetch c6 into @did,@name
while @@FETCH_STATUS=0
	begin
		select @Did,@name
		fetch c6 into @did,@name  
	end
close c6
deallocate c6



/*3 Try to display all students first name in one cell separated by comma. Using Cursor */	


declare c9 cursor
for select distinct st_fname
	from Student
	where st_fname is not null
for read only

declare @sname varchar(20),@all_names varchar(300)=''
open c9
fetch c9 into @sname
while @@FETCH_STATUS=0
	begin
		set @all_names=CONCAT(@all_names,',',@sname)
		fetch c9 into @sname
	end
select @all_names
close c9
deallocate c9


/*4 Create full, differential Backup for SD DB.	*/

		backup database iti
		to disk='f:\databasesbackup\iti.bak'

		backup database iti
		to disk='f:\databasesbackup\iti2.bak'
		WITH DIFFERENTIAL;





/*7 Create a sequence object that allow values from 1 to 10 without cycling in a specific column and test it.	*/


create table testing (
id int 
)


Create SEQUENCE MySequence
START WITH 1
INCREMENT BY 1
MinValue 1
MaxValue 10
no CYCLE;


	insert into testing (values(1)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
	insert into testing VALUES (NEXT VALUE FOR MySequence)
select * from testing 




	

	





