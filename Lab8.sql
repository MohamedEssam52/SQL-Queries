/* 1  displays student full name, course name if the student has a grade more than 50  */


CREATE View display_student_Course
as
 SELECT St_Fname,Crs_Name, Grade
 FROM Student S  ,Course C,Stud_Course SD
 where S.St_Id=sd.St_Id and SD.CRS_ID=C.CRS_ID AND sd.Grade>50


 /* 2  Encrypted view that displays manager names and the topics they teach.   */

 CREATE View Manager_topics
 with encryption

as
 SELECT I.Ins_Name , Top_Name
 FROM Department D  ,Instructor I, Ins_Course instc ,COURSE C, Topic T
 where Dept_Manager=i.Ins_Id AND I.Ins_Id=instc.Ins_Id AND instc.Crs_Id=C.Crs_Id AND T.Top_Id=C.Top_Id




 /*3  view that will display Instructor Name, Department Name for the ‘SD’ or ‘Java’ Department  */


 CREATE View INST_DETAILS	
 with encryption

as
 SELECT I.Ins_Name , D.Dept_Name
 FROM Department D  ,Instructor I
 where Dept_Manager=i.Ins_Id AND Dept_Name IN ('SD','Java')


 /*4 Create a view V1 that displays student data for student who lives in Alex or Cairo.*/ 


CREATE VIEW V1
as
SELECT * FROM Student
WHERE St_Address IN('Alex','Cairo')
with check option


Update V1 set st_address='tanta'
Where st_address='alex'    --- ERROR


/*5  view that will display the project name and the number of employees work on it*/ 

CREATE VIEW PROJECT_DETAILS
AS 
SELECT ProjectName ,  COUNT(EmpNo) AS [Number of workers]
FROM SD.Company.Project,SD.DBO.Works_on 
WHERE SD.Company.Project.ProjectNo = SD.DBO.Works_on.ProjectNo
GROUP BY ProjectName


/*6 Create index on (Hiredate) that allow u to cluster the data in table Department. */

create clustered index i2
on department(manager_hiredate)   ---cann't make because there is a primary in the table


/*7 Create index that allow u to enter unique ages in student table*/ 

create unique index i3 
on student(st_age)    ----> cann't make because data is duplicated on the age


/*8 Using Merge statement   */

MERGE INTO LastTransactions as T

	using dailytransactions as s
	on T.userid =S.userid
	when matched then 
		update 
			set t.TransactionAmount = s.TransactionAmount

	when not matched then 
		insert VALues (s.userid,s.TransactionAmount) 
		;

