Create database BookMarket


use BookMarket

Create Table Author(
id int primary key identity,
Name nvarchar(30),
Surname nvarchar(30),
)

Create Table Books(
Id int primary key identity,
AuthorId int foreign key references  Author(id),
[PageCount] int check([PageCount]>=10),
[Name] nvarchar(100) check(len([Name])>=2)
)
insert into Author
values('Ravil','Isayev'),
('Rahil','Isazade'),
('Nurlan','Mammadli'),
('Dilare','Quliyeva'),
('Hesen','Semedov'),
('Ceyhun','Hacili')

insert into Books
values (1,15,'Felsefe'),
(2,13,'Beynelxalq Munasibetler'),
(3,11,'Junior Developer'),
(4,16,'Filankesin Heyati'),
(5,13,'Futbol Kariyerasi'),
(6,13,'Kompyuter Delisi')


create view ShowAll
as
select B.Id as ID,B.Name as 'Name',b.PageCount as 'PageCount',(A.Name+ ' '+ A.Surname) as FullName from Author A
 join Books B
on B.AuthorId=A.id

select * from ShowAll


create procedure Show
@Serach nvarchar(100)
as
select * from ShowAll

where @Serach= ID

exec Show 4

create procedure DeleteColumn
@Name nvarchar(50)
as
delete  from Author
where @Name=Name

exec DeleteColumn 'Nurlan'

create procedure AddColum

@Name nvarchar(50),
@Surname nvarchar(50)
as
insert into Author
values(@Name,@Surname)

exec AddColum 'Gulzar','Necefli'

create procedure UpdateColumm
@Id int,
@Name nvarchar(50) 
as
update Author

set Name=@Name  
where id=@Id and len(@Name)>2

exec UpdateColumm 4,'lal'





Create view AuthorView
as

select B.AuthorId as ID,(A.Name+ ' '+ A.Surname) as FullName,count(b.Id)as BookCount ,MAX(B.PageCount) as 'PageCount' from Books B
 join Author A
on B.AuthorId=A.id
group by B.AuthorId, (A.Name + ' '+ A.Surname),B.PageCount


select * from  AuthorView



