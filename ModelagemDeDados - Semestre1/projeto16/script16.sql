create database dbexercicio16;

use dbexercicio16;


create table departamento (
	iddepartamento int not null primary key,
    nome varchar(45) not null
    );

create table funcionario(
	idfuncionario int not null, 
    nome varchar(45) not null,
    dataadmissao date not null,
    telefone varchar(15) not null,
    iddepartamento int not null,
    primary key(idfuncionario , iddepartamento),
    foreign key (iddepartamento) references departamento (iddepartamento)

);

create table cordena (
	idsupervisor int not null,
    idsupervisionado int not null,
    primary key (idsupervisor, idsupervisionado),
    foreign key (idsupervisor) references departamento (iddepartamento),
    foreign key (idsupervisionado) references departamento (iddepartamento)


);
