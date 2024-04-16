
/*1 view “v_clerk” that will display employee#,project#, the date of hiring of all the jobs of the type 'Clerk'*/

Create view  v_clerk
as
	
	select EmpNo , ProjectNo, Enter_Date
	from Works_on 
	where Job='clerk'



/*2 view named  “v_without_budget”   */

create view v_without_budget 
as

select * from Company.Project 
where budget is null



/*3 Create view named  “v_count 	*/

create view v_count 
as 

select projectname ,COUNT(empno) as Numberofemps
from Company.Project ,Works_on
where Company.Project.ProjectNo=Works_on.ProjectNo
group by ProjectName



/* 4  Create view named ” v_project_p2”  */
create view v_project_p2 
as 

select empno  from v_clerk
where ProjectNo='p2'


/*5 modifey  “v_without_budget”  to display all DATA  p1 and p2 */


alter view v_without_budget 
as
	select * from Company.Project
	where ProjectNo in ('p1','p2')


/*6 	Delete the views  “v_ clerk” and “v_count*/

Drop view v_clerk 
drop view v_count

/*7		Create view that will display the emp# and emp lastname who works on dept# is ‘d2’	*/

create view emp_Details
as
 select EmpNO ,Emplname
 from HumanResource.Employee
 WHERE DeptNo='d2'


 /*8	Display the employee  lastname that contains letter “J”		*/

 SELECT * FROM emp_Details
 WHERE EmpLname LIKE '%S'


 /*9  Create view named “v_dept” that will display the department# and department name.*/ 

 CREATE VIEW v_dept 
 AS
 SELECT DeptNo,DeptName
 FROM Company.Department


 /*10 using the previous view try enter new department data where dept# is ’d4’ and dept name is ‘Development’*/

 select *from v_dept

insert into v_dept
values ('d4','Development')   ------> enters normally 



/*11 Create view name “v_2006_check” that will display employee#, the project #where he works and the date of joining the project which must be from the first of January and the last of December 2006.	*/ 


create view v_2006_check
as
 select EmpNo, ProjectNo ,Enter_Date
 from Works_on
 where Enter_Date between '1-1-2006' and '12-30-2006'