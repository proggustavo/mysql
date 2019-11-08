create database dbfuncionariodependente;

use dbfuncionariodependente;

create table funcionario (
	idfuncionario int not null primary key,
    nome varchar(45) not null,
    matricula varchar(45) not null,
    sexo varchar(45) not null,
    datanasc date not null
    


);

create table dependente (
	iddependentes int not null ,
    sexo varchar(45) not null ,
    nome varchar(45) not null,
    datanasc date not null,
    idfuncionario int not null,
    
        
    primary key (iddependentes),
    foreign key (idfuncionario) references funcionario (idfuncionario)
    
    
);