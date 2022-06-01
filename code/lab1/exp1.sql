create database exp1;
use exp1;
show databases;
show tables;
drop table Student;
create table Student(
	SNO int not null primary key,
    SNAME char(8) not null,
    SEX char(2),
    DEPTNO int);
create table Course(
	CNO int not null,
    CNAME char(20),
    TNO int not null,
    CREDIT int,
    primary key(CNO,TNO));
create table SC(
	SNO int not null,
    CNO int not null,
    GRADE int,
    primary key(SNO,CNO));
create table Teacher(
	TNO int not null primary key,
    TNAME char(8) not null,
    DEPTNO int);
create table Dept(
	DEPTNO int not null primary key,
    DNAME char(20) not null);
select * from Student;
select * from Course;
select * from SC;
select * from Teacher;
select * from Dept;

alter table Student add(AGE smallint);
alter table Student modify AGE int;

insert into Student values(1001,'喵喵','m',10,20);
insert into Student values(1002,'汪汪','f',10,21);
insert into Student values(1003,'咩咩','m',10,21);
insert into Student values(1004,'哞哞','f',20,21);
insert into Student values(1005,'呱呱','m',20,22);
insert into Student values(1006,'嘎嘎','f',20,22);
insert into Student values(1007,'咕咕哒','f',30,20);

insert into Course values(1,'数据结构',101,4);
insert into Course values(2,'数据库',102,4);
insert into Course values(3,'离散数学',103,4);
insert into Course values(4,'C语言程序设计',101,2);
insert into Course values(5,'高等量子力学',105,3);

insert into SC values(1001,1,80);
insert into SC values(1001,2,85);
insert into SC values(1001,3,78);
insert into SC values(1002,1,72);
insert into SC values(1002,2,82);
insert into SC values(1002,3,86);
insert into SC values(1003,1,92);
insert into SC values(1003,3,90);
insert into SC values(1004,1,87);
insert into SC values(1004,4,90);
insert into SC values(1005,1,85);
insert into SC values(1005,4,92);
insert into SC values(1006,5,99);
insert into SC values(1006,2,100);
insert into SC values(1007,1,80);
insert into SC values(1007,3,91);

insert into Teacher values(101,'张小天',10);
insert into Teacher values(102,'胡小伟',10);
insert into Teacher values(103,'黄程',10);
insert into Teacher values(104,'郭冰',20);
insert into Teacher values(105,'钱祺',30);

insert into Dept values(10,'计算机');
insert into Dept values(20,'信管');
insert into Dept values(30,'物理');

select * from Student where SEX = 'f';
select * from SC where GRADE between 80 and 89 order by GRADE asc;
select DEPTNO,count(*) from Student group by DEPTNO;

select SNAME,AGE from Student,Dept where Dept.DEPTNO = Student.DEPTNO and Dept.DNAME = '信管' and Student.AGE <= 21 and Student.SEX = 'f';

select SNAME from Student where SNO in (select SNO from SC,Course where SC.GRADE >= 60 and SC.CNO = Course.CNO and Course.TNO in (select TNO from Teacher where DEPTNO in (select DEPTNO from Dept where DNAME = '计算机')) group by SNO having sum(CREDIT) < 5);
select A.SNAME,A.GRADE from (select Student1.SNAME,SC1.CNO,SC1.GRADE from SC SC1 natural inner join Student Student1) A natural inner join (select SC2.CNO,max(SC2.GRADE) GRADE from SC SC2 group by SC2.CNO) B;
select Student1.SNO from Student Student1 where not exists(select * from (select SC1.CNO from SC SC1 where SC1.SNO = 1007) A where A.CNO not in (select SC2.CNO from SC SC2 where Student1.SNO = SC2.SNO));
select Student1.SNAME from Student Student1 where not exists(select * from (select SC1.CNO from SC SC1 where SC1.SNO = 1006) A where A.CNO in (select SC2.CNO from SC SC2 where Student1.SNO = SC2.SNO));

SET SQL_SAFE_UPDATES = 0;
update SC SC1,Course Course1 set SC1.GRADE = SC1.GRADE + 2 where SC1.CNO = Course1.CNO and Course1.CNAME = '数据结构';
SET SQL_SAFE_UPDATES = 1;
select * from SC;

delete from SC where 'f' = (select Student1.SEX from Student Student1 where SC.SNO = Student1.SNO and SC.GRADE < 80); 

create view CS_STUDENT(SNO,SNAME,SEX,DEPTNO,AGE) as (select * from Student Student1 where '计算机' = (select Dept1.DNAME from Dept Dept1 where Dept1.DEPTNO = Student1.DEPTNO));
select * from CS_STUDENT;

drop view CS_STUDENT;
drop tables Student,Course,SC,Teacher,Dept; 
