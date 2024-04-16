/*1  returns Month name  */

create function getmonth(@date date)
returns varchar(10)
	begin
	declare @Month varchar(10)
	set @Month =DATENAME(month,@date)
	return @month
	end


SELECT dbo.getmonth('12/12/2022')

/*2  MULTI takes 2 integers and returns the values between them*/

alter FUNCTION Vales_between(@x int ,@y int)
returns @t table(
	numbers int
) 
as 
begin
	While @x<@y-1
		begin
		insert into @t values(@x+1)
		set @x=@x+1
		end

	return
end

SELECT* FROM VALES_BETWEEN(5,20)

/*3 Create inline returns Department Name with Student full name. */

create function student_department(@id int)
returns table 
as 
	return
	( SELECT Department.Dept_Name, Student.St_Fname+Student.St_Lname as fullname
	FROM Department,Allowed.Student
	WHERE Department.Dept_Id=Student.Dept_Id AND Student.St_Id=@id


	)


	select * from student_department(1)





/*4  returns AN ERROR message to user */

create function message(@id int)
returns varchar(30)
	begin
	declare @msg varchar(30)
	
	if
		(select St_Fname from allowed.Student
		where student.St_Id=@id) IS NULL AND (select St_Lname from allowed.Student
		where student.St_Id=@id) IS NULL

		SET @MSG= 'First name & last name are null'
	
	ELSE IF (select St_Fname from allowed.Student
		where student.St_Id=@id) IS NULL
		SET @MSG= 'FIRST NAME IS NULL'
	
	ELSE IF (select St_Lname from allowed.Student
		where student.St_Id=@id) IS NULL
		SET @MSG= 'LAST NAME IS NULL'

	ELSE 
		SET @MSG= 'NO NULL'

RETURN @MSG
	end

	SELECT DBO.MESSAGE(13)


/*5	inline function that takes integer which represents manager ID 	*/


	CREATE FUNCTION INFO_MNG(@Mg_id int)
	returns table 
	as 
	
	return
	(
	
	SELECT Dept_Name,Ins_Name ,Manager_hiredate
	FROM Department,Instructor
	WHERE Department.Dept_Manager=Instructor.Ins_Id AND Dept_Manager=@Mg_id

 	)


	SELECT*FROM INFO_MNG(1)


/*6 multi-statements table-valued function that takes a string  */


CREATE FUNCTION RETURN_NAME (@NAME VARCHAR(20))
RETURNS @t table (

	Name varchar(20)
)

as 

begin 

	If	@NAME='first name' 
		insert into @t 
		SELECT ISNULL(STUDENT.St_Fname,' ') FROM Allowed.Student
	
	else IF @NAME='last name' 
		insert into @t 
		SELECT ISNULL(STUDENT.St_Lname,' ') FROM Allowed.Student
	
	else IF @NAME='full name' insert into @t 
		SELECT ISNULL(STUDENT.St_Fname,' ')+ISNULL(STUDENT.St_Lname,' ') AS FULLNAME FROM Allowed.Student

		RETURN
end


SELECT * FROM RETURN_NAME('FULL NAME')


/*7	a query that returns the Student No and Student first name without the last char	*/

SELECT St_Id , left(St_Fname,LEN(st_fname)-1)
FROM Allowed.student


/*8		query to delete all grades for the students Located in SD Department 	*/

DELETE Stud_Course 
WHERE St_Id IN( 
SELECT Student.St_Id
FROM Allowed.Student , Department
where Student.Dept_Id=Department.Dept_Id and Dept_Name='SD')



/*BOUNS 1 hierarchyid Data type */





/*BOUNS 2  Bath 3000 */

DECLARE @ID INT =3000
WHILE @ID<6001
BEGIN
	INSERT INTO Allowed.Student(St_Id,St_Fname,St_Lname)
	VALUES(@ID,'JANE','SMITH' )
	SET @ID=@ID+1
END


SELECT * FROM Allowed.STUDENT
WHERE St_Id=6000