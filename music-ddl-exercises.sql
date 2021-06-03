drop database if exists music_ddl_exercise;
create database music_ddl_exercise;
use music_ddl_exercise;

create table artist (
	artist_id int primary key auto_increment,
    name varchar(50) not null
);

create table album (
	album_id int primary key auto_increment,
    artist_id int not null,
    title varchar(50) not null,
    release_date date not null,
    label varchar(50),
    constraint artist_id foreign key (artist_id) references artist(artist_id)
);

create table track (
	track_id int primary key auto_increment,
    album_id int,
    order_no int not null,
    title varchar(50) not null,
    length time not null,
    constraint album_id 
		foreign key (album_id) 
        references album(album_id)
);

create table artist_track (
    artist_id int not null,
    track_id int not null,
    is_featured BIT(1),
    constraint pk_artist_track 
		primary key (artist_id, track_id),
    constraint fk_artist_track_artist_id 
		foreign key (artist_id) 
		references artist(artist_id),
    constraint fk_artist_track_track_id 
		foreign key (track_id) 
        references track(track_id)
);

insert into artist (name) values ('Rihanna');

insert into album (artist_id, title, release_date, label)
	values (
    (select artist_id 
	 from artist 
     where name = 'Rihanna'),
     'Loud', '2010-11-12',
     'SRP Records');
     
insert into track (album_id, order_no, title, length) 
values (
	(select album_id
     from album
     where title = 'Loud'
     and label = 'SRP Records'),
     1, 'S&M', '00:04:04');

insert into artist_track (artist_id, is_featured, track_id)
values (
(select a.artist_id 
 from artist a 
 where a.name = 'Rihanna'),
 0,
(select t.track_id
 from track t
 where t.title = 'S&M')
 );

