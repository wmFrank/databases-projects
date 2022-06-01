create database exp2;
use exp2;
drop tables Stuff,Section,Project,Job;

#task1
create table Stuff(
    StuffName char(8),
    StuffNo int,
    Age int,
    Salary int,
    SectionNo int);
create table Section(
	SectionName char(20),
    SectionNo int,
    StuffInCharge int);
create table Project(
	ProjectName char(20),
    ProjectNo int,
    SectionInCharge int);
create table Job(
	StuffNo int,
    ProjectNo int,
    WorkTime int);
insert into Stuff values('Lily',1,27,30000,1);
insert into Stuff values('Alice',2,26,32000,2);
insert into Stuff values('Tom',3,29,27000,4);
insert into Stuff values('Jim',4,25,31000,4);
insert into Stuff values('Jack',5,33,46000,2);
insert into Stuff values('Molly',6,30,40000,3);
insert into Section values('Personnel',1,1);
insert into Section values('Sales',2,5);
insert into Section values('Advertising',3,6);
insert into Section values('Research',4,3);
insert into Project values('StuffReduce',1,1);
insert into Project values('PricePromotion',2,2);
insert into Project values('Branding',3,3);
insert into Project values('Excelsior',4,4);
insert into Job values(1,1,23);
insert into Job values(2,2,13);
insert into Job values(3,4,29);
insert into Job values(4,4,24);
insert into Job values(5,2,18);
insert into Job values(6,3,30);
select * from Stuff;
select * from Section;
select * from Project;
select * from Job;

#task2
alter table Stuff add primary key(StuffNo);
alter table Section add primary key(SectionNo);
alter table Project add primary key(ProjectNo);
alter table Job add primary key(StuffNo,ProjectNo);
alter table Stuff modify StuffNo int not null;
alter table Section modify SectionNo int not null;
alter table Project modify ProjectNo int not null;
alter table Job modify StuffNo int not null;
alter table Job modify ProjectNo int not null;
alter table Stuff add constraint FKC1 foreign key FK1(SectionNo) 
references Section(SectionNo) on update cascade on delete restrict;
alter table Section add constraint FKC2 foreign key FK2(StuffInCharge) 
references Stuff(StuffNo) on update cascade on delete restrict;
alter table Project add constraint FKC3 foreign key FK3(SectionInCharge) 
references Section(SectionNo) on update cascade on delete restrict;
alter table Job add constraint FKC4 foreign key FK4(StuffNo) 
references Stuff(StuffNo) on update cascade on delete restrict;
alter table Job add constraint FKC5 foreign key FK5(ProjectNo) 
references Project(ProjectNo) on update cascade on delete restrict;

#task3
insert into Stuff values('Bob',null,20,20000,1);
insert into Stuff values('Bob',7,20,20000,5);
update Section set StuffInCharge = 7 where SectionNo = 1; 
delete from Section where SectionNo = 1;
delete from Stuff where Stuffno = 1; 

#task4
delimiter $$
create trigger trigger1 before insert on Job 
for each row 
begin 
	if new.WorkTime > 24 then set new.WorkTime = 24;
    end if;
    update Stuff set Stuff.Salary = Stuff.Salary * (1 + 0.05) 
    where Stuff.StuffNo = new.StuffNo; 
    update Stuff set Stuff.Salary = Stuff.Salary * (1 + 0.03) 
    where Stuff.StuffNo = new.StuffNo 
    and new.StuffNo in (select StuffInCharge from Section);
end$$
delimiter ;
drop trigger trigger1;

insert into Job values(6,2,60);
select * from Job;
select * from Stuff;
delete from Job where StuffNo = 6 and ProjectNo = 2;
update Stuff set Salary = 40000 where StuffNo = 6;

insert into Job values(2,1,44);
select * from Job;
select * from Stuff;
delete from Job where StuffNo = 2 and ProjectNo = 1;
update Stuff set Salary = 32000 where StuffNo = 2;

#task5
create user 'worker'@'localhost' identified by 'wmfrank';
grant select, update(Age) on Stuff to 'worker'@'localhost';
drop user 'worker'@'localhost';

#use exp2;
#update Stuff set Age = 22 where StuffNo = 1;
#select * from Stuff;
#update Stuff set Salary = 60000 where StuffNo = 5;
#select * from Stuff;
