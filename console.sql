use introduction_to_database;
create table groups (
    id integer primary key auto_increment,
    name text not null,
    location text not null,
    start_date date not null,
    max_participants integer
);
create table learners (
    id integer primary key auto_increment,
    name text not null,
    email text not null,
    active integer not null
);
create table coaches (
    id integer primary key auto_increment,
    name text not null
);
insert into groups (name, location, start_date, max_participants) values
('becode1', 'bruxelles','2023-10-03','25');
insert into groups (name, location, start_date, max_participants) values
('becode2', 'gand','2023/03/10','30');
insert into learners (name, email, active) values ('safa', 'safaparleanoah@becode', 1);
alter table learners modify column active bit not null default 1;
select *from learners
insert into coaches (name) values ('diogo')
select  name as learner_name, email from learners order by id asc limit 1
select *from groups
update groups set start_date='2023-11-03' where id=(select id from groups order by id limit 1)
alter table groups add column status text not null
update groups set status='covidasse' where id=(select id from groups order by id limit 1)
delete from learners where id=(select id from groups order by id limit 2 offset 1)
select *from learners
alter table learners add column id_group integer not null
update learners set id_group='1' where id=(select id from learners order by id limit 1)
update learners set id_group='2' where ``.learners.id_group='0'
alter table groups add column id_coach integer not null
select *from groups
update groups set ``.`groups`.id_coach=id
select *from coaches inner join groups on coaches.id=groups.id_coach where coaches.id='1'
select *from learners inner join groups on groups.id=learners.id_group
inner join coaches on groups.id_coach=coaches.id
where coaches.id='2' and learners.active='1'
select *from learners
select *from coaches
insert into coaches (name) values ('diogo')
update learners set active=false where learners.id='3'
ALTER TABLE groups
ADD FOREIGN KEY (id_coach) REFERENCES coaches(id)
ALTER TABLE learners
ADD FOREIGN KEY (id_group) REFERENCES groups(id)
select *from groups