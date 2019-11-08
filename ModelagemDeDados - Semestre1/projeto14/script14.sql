create database dbyoutube;

use dbyoutube;


create table video (
	
    idvideo int not null primary key,
    nome varchar(45) not null,
    categoria varchar(45) not null,
    datapub varchar(45) not null
    
);

create table usuario (
	
    idusuario int not null primary key,
    nome varchar(45) not null,
    login varchar(45) not null,
    senha varchar(10) not null,
    datacad date
    
);

create table relacionamento (
	
    idusuario int not null,
    idvideo int not null,
	primary key (idusuario , idvideo),
    foreign key (idusuario) references usuario (idusuario),
    foreign key (idvideo) references video (idvideo)

);