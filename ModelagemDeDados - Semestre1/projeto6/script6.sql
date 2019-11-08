create database dbfuncionario;

use dbfun

create table funcionario (

	idfuncionario int not null primary key auto_increment,
    nome varchar(100) not null,
    dddresidencial varchar(5) not null,
    numresidencial varchar(15) not null,
    dddcel varchar (5) not null,
    numcel varchar(15) not null,
    dddrecado varchar(5) not null,
    numrecado varchar(15) not null,
    nomerecado varchar(100) not null

);


desc funcionario;
