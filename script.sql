create table introduction_to_database.coaches
(
    id   int auto_increment
        primary key,
    name text not null
);

create table introduction_to_database.`groups`
(
    id               int auto_increment
        primary key,
    name             text not null,
    location         text not null,
    start_date       date not null,
    max_participants int  null,
    status           text not null,
    id_coach         int  not null,
    constraint groups_ibfk_1
        foreign key (id_coach) references introduction_to_database.coaches (id)
);

create index id_coach
    on introduction_to_database.`groups` (id_coach);

create table introduction_to_database.learners
(
    id       int auto_increment
        primary key,
    name     text             not null,
    email    text             not null,
    active   bit default b'1' not null,
    id_group int              not null,
    constraint learners_ibfk_1
        foreign key (id_group) references introduction_to_database.`groups` (id)
);

create index id_group
    on introduction_to_database.learners (id_group);


