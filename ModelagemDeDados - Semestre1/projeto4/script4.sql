create database DBCADASTRO;

create table cadastro (
	idcadastro int not null primary key,
    nome varchar(45) null,
    sobrenome varchar(45) not null,
    celularemail varchar(100) not null unique,
    senha varchar(10) not null,
    datanasc date not null,
    sexo enum ('M','F') not null
    

);

desc cadastro;